using System;
using SoftwareMonkeys.WorkHub.State;
using SoftwareMonkeys.WorkHub.UI.Modules;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules
{
	/// <summary>
	/// Provides a way to interact with the application module state.
	/// </summary>
	public class ModuleState
	{
		static private string configurationKey = "ModuleState.Configuration";
		/// <summary>
		/// Gets/sets the key used for storing the configuration component in application state.
		/// </summary>
		static public string ConfigurationKey
		{
			get { return configurationKey; }
			set { configurationKey = value; }
		}
		
		/// <summary>
		/// Gets/sets the module configuration component.
		/// </summary>
		static public ModuleStateConfiguration Configuration
		{
			get
			{
				if (!IsInitialized)
					FailNotInitialized();
				
				ModuleStateConfiguration configuration = (ModuleStateConfiguration)StateAccess.State.GetApplication(ConfigurationKey);
				
				return configuration;
			}
			set {
				StateAccess.State.SetApplication(ConfigurationKey, value);
			}
		}
		
		static private bool enableFacade = true;
		/// <summary>
		/// Gets/sets a boolean value indicating whether the facade component is to be called upon enabling/disabling module.
		/// </summary>
		static public bool EnableFacade
		{
			get { return enableFacade; }
			set { enableFacade = value; }
		}
		
		static private IModuleFacade facade;
		/// <summary>
		/// Gets/sets the module facade component that takes care of UI related configuration.
		/// </summary>
		static public IModuleFacade Facade
		{
			get { return facade; }
			set { facade = value; }
		}
		
		static private ModuleLoader loader;
		/// <summary>
		/// Gets/sets the loader used to load modules as needed.
		/// </summary>
		static public ModuleLoader Loader
		{
			get {
				if (loader == null)
					loader = new ModuleLoader();
				return loader; }
			set { loader = value; }
		}
		
		/// <summary>
		/// The key used to store the module context collection in the application state.
		/// </summary>
		static public string ModulesKey = "ModuleState.Modules";
		
		/// <summary>
		/// The key used to store the IsInitialized value in the application state.
		/// </summary>
		static public string ModulesInitializedKey = "ModuleState.IsInitialized";
		
		/// <summary>
		/// Gets a boolean value indicating whether the module state has been initialized.
		/// </summary>
		static public bool IsInitialized
		{
			get {
				if (!StateAccess.State.ContainsApplication(ModulesInitializedKey))
					return false;
				return (bool)StateAccess.State.GetApplication(ModulesInitializedKey); }
			set { StateAccess.State.SetApplication(ModulesInitializedKey, value); }
		}
		
		/// <summary>
		/// Gets/sets a collection containing the module contexts that have been loaded for the application.
		/// </summary>
		static public ModuleContextCollection Modules
		{
			get
			{
				if (!IsInitialized)
					FailNotInitialized();
				
				// TODO: Check if needed. Remove if not.
				// The new context collection should be created via the Initialize function, not here
				//if (StateAccess.State.GetApplication(ModulesKey) == null)
				//	StateAccess.State.SetApplication(ModulesKey, new ModuleContextCollection());
				ModuleContextCollection modules = (ModuleContextCollection)StateAccess.State.GetApplication(ModulesKey);
				
				return modules;
			}
			set {
				StateAccess.State.SetApplication(ModulesKey, value);
			}
		}
		
		/// <summary>
		/// Initializes the module state.
		/// </summary>
		static public void Initialize()
		{
			if (!IsInitialized)
				Initialize(new string[]{});
		}
		
		/// <summary>
		/// Initializes the module state.
		/// </summary>
		/// <param name="moduleIDs">The IDs of the modules to initialize.</param>
		static public void Initialize(string[] moduleIDs)
		{
			using (LogGroup logGroup = LogGroup.Start("Initializing module state.", NLog.LogLevel.Debug))
			{
				if (!IsInitialized)
				{
					LogWriter.Debug("# modules: " + moduleIDs);
					
					Modules = InitializeModules(moduleIDs);
					
					IsInitialized = true;
				}
			}
		}
		
		/// <summary>
		/// Initializes the available modules.
		/// </summary>
		/// <param name="moduleIDs">The IDs of the modules to initialize.</param>
		/// <returns>The initialized modules.</returns>
		static public ModuleContextCollection InitializeModules(string[] moduleIDs)
		{
			ModuleContextCollection collection = null;
			using (LogGroup logGroup = LogGroup.Start("Initializing the specified modules.", NLog.LogLevel.Debug))
			{
				collection = Loader.GetModules(moduleIDs);
				collection.Loader = Loader;
			}
			return collection;
		}
		
		/// <summary>
		/// Disposes the module state.
		/// </summary>
		static public void Dispose()
		{
			Modules = null;
			IsInitialized = false;
		}
		
		/// <summary>
		/// Checks whether the module with the provided ID is currently enabled.
		/// </summary>
		/// <param name="moduleID">The ID of the module to check.</param>
		/// <returns>A boolean value indicating whether the specified module is enabled.</returns>
		static public bool IsEnabled(string moduleID)
		{
			bool isEnabled = false;
			//using (LogGroup logGroup = LogGroup.Start("Checking whether the module '" + moduleID + "' is currently enabled.", NLog.LogLevel.Debug))
			//{
			if (!IsInitialized)
			{
				FailNotInitialized();
				isEnabled = false;
			}
			else
			{
				
				isEnabled = (Modules != null &&
				             Modules.Contains(moduleID) &&
				             Configuration.Contains(moduleID));
			}
			
			//	LogWriter.Debug("Is enabled: " + isEnabled.ToString());
			//}
			
			return isEnabled;
		}

		/// <summary>
		/// Throws an exception explaining that the module state has not been initalized.
		/// </summary>
		static public void FailNotInitialized()
		{
			throw new InvalidOperationException("The module state has not been initialized. Call ModuleState.Initialize().");
		}
		
		/// <summary>
		/// Enables the module with the provided ID.
		/// </summary>
		/// <param name="moduleID">The ID of the module to enable.</param>
		static public void Enable(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the module with the ID: " + moduleID, NLog.LogLevel.Debug))
			{
				if (Modules == null)
					FailModulesNotInitialized();
				
				if (Configuration == null)
					FailConfigurationNotInitialized();
				
				AddToModulesState(moduleID);
				
				AddToModulesConfiguration(moduleID);
				
				AddToModulesFacade(moduleID);
			}
		}
		
		/// <summary>
		/// Adds the specified module to the ModuleState.Modules collection.
		/// </summary>
		/// <param name="moduleID">The ID of the module to add to the module state collection.</param>
		static protected void AddToModulesState(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding the specified module to the ModuleState.Modules collection.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + moduleID);
				
				if (!Modules.Contains(moduleID))
				{
					LogWriter.Debug("Module is new to the list. Adding.");
					
					// Load the module
					ModuleContext context = Loader.GetModule(moduleID);
					
					// Add the module to the list
					Modules.Add(context);
					
					// Call the Enable function on the module context
					context.Enable();
				}
				else
				{
					LogWriter.Debug("Module is already in the list. Skipping.");
					
				}
			}
		}
		
		/// <summary>
		/// Adds the specified module to the module configuration.
		/// </summary>
		/// <param name="moduleID">The ID of the module to add to the module configuration.</param>
		static protected void AddToModulesConfiguration(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding specified module to configuration.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + moduleID);
				
				if (!Configuration.Contains(moduleID))
				{
					Configuration.AddToConfig(moduleID);
				}
				else
					LogWriter.Debug("Configuration already contains module.");
			}
		}
		
		/// <summary>
		/// Adds the specified module to the facade (eg. site map, etc.).
		/// </summary>
		/// <param name="moduleID">The ID of the module to add to the facade.</param>
		static protected void AddToModulesFacade(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding the specified module to the facade.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + moduleID);
				
				if (EnableFacade)
				{
					LogWriter.Debug("EnableFacade == true");
					
					if (Facade == null)
						FailFacadeNotInitialized();
					
					Facade.Enable(moduleID);
				}
				else
				{
					LogWriter.Debug("EnableFacade == false");
				}
			}
		}
		
		/// <summary>
		/// Disables the module with the provided ID.
		/// </summary>
		/// <param name="moduleID">The ID of the module to enable.</param>
		static public void Disable(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Disabling the module with the ID: " + moduleID, NLog.LogLevel.Debug))
			{
				if (Modules == null)
					FailModulesNotInitialized();
				
				if (Configuration == null)
					FailConfigurationNotInitialized();
				
				RemoveFromModulesState(moduleID);
				
				RemoveFromModulesConfiguration(moduleID);
				
				RemoveFromModulesFacade(moduleID);
				
			}
		}
		
		/// <summary>
		/// Removes the specified module from the modules state collection.
		/// </summary>
		/// <param name="moduleID">The ID of the module to remove from the state collection.</param>
		static protected void RemoveFromModulesState(string moduleID)
		{
			using (LogGroup logGroup =LogGroup.Start("Removing the specified module from the modules state.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + moduleID);
				
				if (Modules.Contains(moduleID))
				{
					LogWriter.Debug("Module found. Removing.");
					
					ModuleContext context = Modules[moduleID];
					
					Modules.Remove(context);
					
					context.Disable();
				}
				else
				{
					LogWriter.Debug("Module not found. Skipping.");
				}
			}
		}
		
		/// <summary>
		/// Removes the specified module from the module configuration.
		/// </summary>
		/// <param name="moduleID">The ID of the module to remove from the configuration.</param>
		static protected void RemoveFromModulesConfiguration(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the specified module from the configuration.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("ModuleID: " + moduleID);
				
				if (Configuration.Contains(moduleID))
				{
					LogWriter.Debug("Module found. Removing.");
					
					Configuration.RemoveFromConfig(moduleID);
				}
				else
					LogWriter.Debug("Module not found. Skipping.");
			}
		}
		
		/// <summary>
		/// Removes the specified module from the facade (eg. site map, etc.).
		/// </summary>
		/// <param name="moduleID">The ID of the module to remove from the module facade.</param>
		static protected void RemoveFromModulesFacade(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the specified module from the facade.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + moduleID);
				
				if (EnableFacade)
				{
					LogWriter.Debug("EnableFacade == true");
					
					if (Facade == null)
						FailFacadeNotInitialized();
					
					Facade.Disable(moduleID);
				}
				else
					LogWriter.Debug("EnableFacade == false");
			}
		}
		
		/// <summary>
		/// Throws an exception explaining that the facade component hasn't been initialized.
		/// </summary>
		static private void FailFacadeNotInitialized()
		{
			throw new InvalidOperationException("The Facade component has not be initialized yet EnableFacade is set to true. Either set EnableFacade to false or use the");
		}
		
		/// <summary>
		/// Throws an exception explaining that the configuration component hasn't been initialized.
		/// </summary>
		static private void FailConfigurationNotInitialized()
		{
			throw new InvalidOperationException("The Configuration component has not be initialized on the Configuration property.");
		}
		
		
		/// <summary>
		/// Throws an exception explaining that the Modules property hasn't been initialized.
		/// </summary>
		static private void FailModulesNotInitialized()
		{
			throw new InvalidOperationException("The Modules property has not be initialized.");
		}
		
	}
}
