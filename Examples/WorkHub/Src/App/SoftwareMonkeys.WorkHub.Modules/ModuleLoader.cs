using System;
using SoftwareMonkeys.WorkHub.Diagnostics;
using System.IO;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using System.Xml;
using System.Reflection;
using System.Collections;

namespace SoftwareMonkeys.WorkHub.Modules
{
	/// <summary>
	/// Loads modules from module configuration files.
	/// </summary>
	public class ModuleLoader
	{
		public ModuleLoader()
		{
		}
		
		
		/// <summary>
		/// Loads the module with the provided ID.
		/// </summary>
		/// <param name="moduleID">The ID of the module.</param>
		/// <returns>The config of the module with the provided ID.</returns>
		public virtual ModuleConfig GetModuleConfig(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Loads the '" + moduleID + "' module.", NLog.LogLevel.Debug))
			{
				if (moduleID == String.Empty)
					throw new ArgumentNullException("A module ID must be provided.");

				string configPath = GetConfigFilePath(moduleID);



				return GetConfigFromPath(configPath);
			}
		}

		/// <summary>
		/// Loads the module from the configuration file at the specified path.
		/// </summary>
		/// <param name="path">The path to the module configuration file.</param>
		/// <returns>The config of the loaded module.</returns>
		public virtual ModuleConfig GetConfigFromPath(string path)
		{

			LogWriter.Debug("Module configuration file path: " + path);

			// Make sure the config file exists
			if (!File.Exists(path))
				throw new InvalidOperationException("The configuration file was not found: " + path);

			ModuleConfig config = null;

			try
			{
				// Deserialize the config file
				using (FileStream stream = File.Open(path, FileMode.Open))
				{
					XmlSerializer serializer = new XmlSerializer(typeof(ModuleConfig));
					config = (ModuleConfig)serializer.Deserialize(stream);
					stream.Close();
				}
			}
			catch (XmlException ex)
			{
				LogWriter.Error(ex.ToString());
			}

			string moduleID = Path.GetFileName(Path.GetDirectoryName(path));

			config.ModuleID = moduleID;
			
			return config;
		}
		
		
		/// <summary>
		/// Gets the module context for the provided module.
		/// </summary>
		/// <param name="moduleID">The ID of the module to retrieve the context for.</param>
		/// <returns>The module context for the specified module.</returns>
		public virtual ModuleContext GetModule(string moduleID)
		{
			if (moduleID == String.Empty)
				throw new ArgumentException("A module ID must be provided.", "moduleID");
			
			ModuleConfig config = GetModuleConfig(moduleID);
			
			return GetModule(config);
		}
		
		/// <summary>
		/// Gets the module context for the provided module.
		/// </summary>
		/// <param name="moduleConfig">The module config to retrieve the context for.</param>
		/// <returns>The module context for the provided module config.</returns>
		public virtual ModuleContext GetModule(ModuleConfig moduleConfig)
		{
			ModuleContext returnContext = null;

			using (LogGroup logGroup = LogGroup.Start("Retrieving the module context for the provided module.", NLog.LogLevel.Debug))
			{
				if (moduleConfig == null)
					throw new ArgumentNullException("moduleConfig", "The provided module config is null.");

				// TODO: Cache module context
				Type contextType = null;

				Assembly assembly = GetModuleAssembly(moduleConfig.ModuleID);

				if (assembly == null)
					LogWriter.Debug("Module assembly not found.");

				foreach (Type type in assembly.GetTypes())
				{
					Type[] interfaces = type.GetInterfaces();
					if (interfaces != null && interfaces.Length > 0)
					{
						//bool found = false;
						foreach (Type t in interfaces)
						{
							if (t.FullName == typeof(IModuleContext).FullName)
							{
								// TODO: Add break to loop
								//if (Array.IndexOf(interfaces, typeof(IModuleContext)) > -1)
								//{
								contextType = type;
								//}
							}
						}
					}
				}


				if (contextType == null)
					returnContext = null;
				else
					returnContext = (ModuleContext)Activator.CreateInstance(contextType);
				
				returnContext.Config = moduleConfig;
				returnContext.ModuleID = moduleConfig.ModuleID;
			}

			return returnContext;
		}
		
		

		/// <summary>
		/// Retrieves the physical file path to the configuration file of the specified module.
		/// </summary>
		/// <param name="moduleID">The ID of the module to retrieve the configuration file for.</param>
		/// <returns>The physical file path to the specified configuration file.</returns>
		public virtual string GetConfigFilePath(string moduleID)
		{
			return Config.Application.PhysicalApplicationPath.TrimEnd('\\') + @"\Modules\" + moduleID + @"\Module.config";
		}
		
		/// <summary>
		/// Retrieves the assembly that corresponds with the specified module.
		/// </summary>
		/// <param name="moduleID">The ID of the module to retrieve the assembly for.</param>
		/// <returns>The assembly that corresponds with the specified module ID.</returns>
		public virtual Assembly GetModuleAssembly(string moduleID)
		{
			
			string name = "SoftwareMonkeys.WorkHub.Modules." + moduleID;
			
			
			// TODO: Allow for more flexibility in assembly names, so that other organizations can use their own name and still run their module within WorkHub
			
			// Load the assembly
			return Assembly.Load(name);
		}
		
		
		/// <summary>
		/// Loads all the modules in the module directory.
		/// </summary>
		/// <returns>The collection of module context components.</returns>
		public virtual ModuleContextCollection GetModules()
		{
			ModuleContextCollection modules = new ModuleContextCollection();

			using (LogGroup logGroup = LogGroup.Start("Loads all available modules for use in the application.", NLog.LogLevel.Info))
			{
				if (Config.IsInitialized)
				{
					string physicalApplicationPath = Config.Application.PhysicalApplicationPath;

					string moduleDirectory = Path.Combine(physicalApplicationPath, "Modules");

					// Load the module config
					foreach (DirectoryInfo directory in new DirectoryInfo(moduleDirectory).GetDirectories())
					{
						if (File.Exists(Path.Combine(directory.FullName, "Module.config")))
						{
							ModuleContext module = GetModule(directory.Name);

							modules.Add(module);
						}
					}

				}
			}

			return modules;
		}
		
		/// <summary>
		/// Gets the modules with the specified IDs.
		/// </summary>
		/// <param name="moduleIDs">The IDs of the modules to retrieve.</param>
		/// <returns>A collection of the module contexts.</returns>
		public ModuleContextCollection GetModules(string[] moduleIDs)
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			
			foreach (string moduleID in moduleIDs)
			{
				if (moduleID != String.Empty)
					collection.Add(GetModule(moduleID));
			}
			
			return collection;
		}
		
		/// <summary>
		/// Retrieves a list of the controls in the specified module.
		/// </summary>
		/// <param name="moduleID">The ID of the module to get the controls from.</param>
		/// <returns>An array of the names of the controls.</returns>
		public string[] GetControls(string moduleID)
		{
			ArrayList controls = new ArrayList();
			foreach (string control in Directory.GetFiles(Config.Application.PhysicalApplicationPath + @"\Modules\" + moduleID, "*.ascx"))
			{
				controls.Add(Path.GetFileNameWithoutExtension(control));
			}
			return (string[])controls.ToArray(typeof(string));
		}
	}
}
