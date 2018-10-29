using System;
using SoftwareMonkeys.WorkHub.Modules;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using System.Web.UI;

namespace SoftwareMonkeys.WorkHub.Web.Projections
{
	/// <summary>
	/// Used to enable all the projections within a particular module.
	/// </summary>
	public class ModuleProjectionsEnabler
	{
		public ProjectionLoader Loader;
		
		public ModuleProjectionsEnabler(ProjectionLoader loader)
		{
			Loader = loader;
		}
		
		public void Enable(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the projections for the module '" + module.ModuleID + "'.", NLog.LogLevel.Debug))
			{
				if (!ProjectionState.IsInitialized)
					InitializeProjections();
				
				LogWriter.Debug("Projections in state before: " + ProjectionState.Projections.Count.ToString());
				
				foreach (ProjectionInfo projection in Loader.LoadInfoFromFile(true))
				{
					if (IsInModule(module, projection))
					{
						LogWriter.Debug("Enabling projection - Category: " + projection.MenuCategory + " | Title: " + projection.MenuTitle + " | Action: " + projection.Action + " | Type Name: " + projection.TypeName + " | Format: " + projection.Format + " | Path: " + projection.ProjectionFilePath);
						
						projection.Enabled = true;
						
						// Update the state
						ProjectionState.Projections.SetStateValue(ProjectionState.Projections.GetProjectionKey(projection), projection);
					}
				}
				
				new ProjectionSaver().SaveInfoToFile(ProjectionState.Projections.ToArray());
				
				LogWriter.Debug("Projections in state after: " + ProjectionState.Projections.Count.ToString());
				
				LogWriter.Debug("Projections are enabled. Info was saved to file.");
			}
		}
		
		public void Disable(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Disabling the projections for the module '" + module.ModuleID + "'.", NLog.LogLevel.Debug))
			{
				if (!ProjectionState.IsInitialized)
					InitializeProjections();
				
				foreach (ProjectionInfo projection in Loader.LoadInfoFromFile(true))
				{
					if (IsInModule(module, projection))
					{
						LogWriter.Debug("Disabling projection - Category: " + projection.MenuCategory + " | Title: " + projection.MenuTitle + " | Action: " + projection.Action + " | Type Name: " + projection.TypeName + " | Format: " + projection.Format + " | Path: " + projection.ProjectionFilePath);
						
						projection.Enabled = false;
						
						// Update the state
						ProjectionState.Projections[ProjectionState.Projections.GetProjectionKey(projection)] = projection;
					}
				}
				
				new ProjectionSaver().SaveInfoToFile(ProjectionState.Projections.ToArray());
			}
		}
		
		public bool IsInModule(ModuleContext module, ProjectionInfo projection)
		{
			bool isInModule = false;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the projection '" + projection.ProjectionFilePath + "' is in the '" + module.ModuleID + "' module."))
			{
				string[] sections = projection.ProjectionFilePath.Trim('/').Split('/');
				
				if (sections.Length > 0)
				{
					// If the first section of the path is "Modules" then it's part of a module
					if (sections[0] == "Modules")
					{
						// If the second section matches the ID then it's in the provided module
						if (sections[1] == module.ModuleID)
							isInModule = true;
					}
				}
				
				LogWriter.Debug("Is in module: " + isInModule.ToString());
			}
			return isInModule;
		}
		
		public void InitializeProjections()
		{
			
			if (Configuration.Config.IsInitialized)
			{
				new ProjectionsInitializer().Initialize();
			}
			
		}
	}
}
