using System;
using System.Collections;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules
{
	/// <summary>
	/// Provides functions for configuring modules.
	/// </summary>
	public class ModuleStateConfiguration
	{
		//private string[] enabledModules;
		/// <summary>
		/// Gets/sets the modules currently enabled.
		/// </summary>
		public string[] EnabledModules
		{
			get {
				// If the enabledModules field hasn't been set then use the underlying application configuration
				//if (enabledModules == null)
				//	enabledModules = Configuration.Config.Application.EnabledModules;
				//return enabledModules;
				return Configuration.Config.Application.EnabledModules;
			}
			set {
				// If the enabledModules field hasn't been set then use the underlying application configuration
				//if (enabledModules == null)
					Configuration.Config.Application.EnabledModules = value;
				//else
				//	enabledModules = value;
			}
		}
		
		/// <summary>
		/// Adds the module ID to the Config.Application.EnabledModules collection.
		/// </summary>
		/// <param name="moduleID">The ID of the module to add to the EnabledModules property.</param>
		public void AddToConfig(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding the module ID '" + moduleID + "' to the Config.Application.EnabledModules list.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Adding module to enabled modules list on application.");

				ArrayList list = (Config.Application.EnabledModules == null
				                  ? new ArrayList()
				                  : new ArrayList(Config.Application.EnabledModules));
				
				if (!list.Contains(moduleID))
					list.Add(moduleID);
				
				EnabledModules = (string[])list.ToArray(typeof(string));

				LogWriter.Debug("Added");

				LogWriter.Debug("Updating application config.");

				Save();
			}
		}
		
		/// <summary>
		/// Removes the module ID from the Config.Application.EnabledModules collection.
		/// </summary>
		/// <param name="moduleID">The ID of the module to add to the EnabledModules property.</param>
		public void RemoveFromConfig(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the module ID '" + moduleID + "' from the Config.Application.EnabledModules list.", NLog.LogLevel.Debug))
			{
				ArrayList list = new ArrayList(Config.Application.EnabledModules);
				list.Remove(moduleID);
				EnabledModules = (string[])list.ToArray(typeof(string));

				Save();
			}
		}
		
		/// <summary>
		/// Checks whether the configuration contains the specified module in the EnabledModules array.
		/// </summary>
		/// <param name="moduleID">The ID of the module to check</param>
		/// <returns>A boolean value indicating whether the module was found.</returns>
		public bool Contains(string moduleID)
		{
			if (EnabledModules == null || EnabledModules.Length == 0)
				return false;
			else
				return Array.IndexOf(EnabledModules, moduleID) > -1;
		}
		
		/// <summary>
		/// Saves the module configuration details.
		/// </summary>
		public void Save()
		{
			Configuration.Config.Application.Save();
		}
	}
}
