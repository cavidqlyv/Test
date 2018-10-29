using System.IO;
using System.Web;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using System;

namespace SoftwareMonkeys.WorkHub.Web.Modules
{
	/// <summary>
	/// Description of ModuleWebUtilities.
	/// </summary>
	public class ModuleWebUtilities
	{
		public ModuleWebUtilities()
		{
		}
		
		/// <summary>
		/// Retrieves the ID of the module that the provided part is in.
		/// </summary>
		/// <param name="part">The part info to identify the parent module for.</param>
		/// <returns>The ID of the module that the specified part is in.</returns>
		static public string GetModuleID(PartInfo part)
		{
			string[] pathParts = part.PartFilePath.Split('/'); // Path is virtual so forward slashes are used
			
			string moduleID = string.Empty;
			
			if (pathParts[0] == "Modules")
				moduleID = pathParts[1];
			
			return moduleID;
		}
		
		
		/// <summary>
		/// Retrieves the ID of the module that the provided projection is in.
		/// </summary>
		/// <param name="projection">The projection info to identify the parent module for.</param>
		/// <returns>The ID of the module that the specified projection is in.</returns>
		static public string GetModuleID(ProjectionInfo projection)
		{
			string moduleID = string.Empty;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Retrieving module ID for the provided projection info."))
			{
				LogWriter.Debug("Project path: " + projection.ProjectionFilePath);
				
				string[] pathParts = projection.ProjectionFilePath.Trim('/').Split('/'); // Path is virtual so forward slashes are used
				
				if (pathParts[0] == "Modules")
					moduleID = pathParts[1];
				else
					LogWriter.Debug("Path doesn't appear to be a module path.");
				
				LogWriter.Debug("Module ID: " + moduleID);
			}
			return moduleID;
		}
		
		static public ModuleContext GetCurrentModule()
		{
			ModuleContext module = null;
			using (LogGroup logGroup = LogGroup.StartDebug("Retrieving the current module context."))
			{
				if (QueryStrings.Action != String.Empty && QueryStrings.Type != String.Empty)
				{
					LogWriter.Debug("Detected action and type query strings.");
					
					if (ProjectionState.Projections.Contains(QueryStrings.Action, QueryStrings.Type))
					{
						ProjectionInfo projection = ProjectionState.Projections[QueryStrings.Action, QueryStrings.Type];
						
						string moduleID = ModuleWebUtilities.GetModuleID(projection);
						
						if (moduleID != String.Empty)
							module = ModuleState.Modules[moduleID];
					}
					else
						LogWriter.Debug("Projection info not found.");
				}
				else if (QueryStrings.Name != String.Empty)
				{
					LogWriter.Debug("Detected name strings.");
					
					if (ProjectionState.Projections.Contains(QueryStrings.Name))
					{
						ProjectionInfo projection = ProjectionState.Projections[QueryStrings.Name];
						
						string moduleID = ModuleWebUtilities.GetModuleID(projection);
						
						if (moduleID != String.Empty)
							module = ModuleState.Modules[moduleID];
					}
					else
						LogWriter.Debug("Projection info not found.");
				}
			}
			return module;
		}
		
		static public void EnableLegacyModules()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the original set of modules.", NLog.LogLevel.Debug))
			{
				string dataDirectoryPath = HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath) + Path.DirectorySeparatorChar + "App_Data";
				string legacyDirectoryPath = Path.Combine(dataDirectoryPath, "Legacy");
				if (!Directory.Exists(legacyDirectoryPath))
					legacyDirectoryPath = Path.Combine(dataDirectoryPath, "Import");
				
				string[] moduleIDs = GetDefaultModules();

				// Start with default, ordered modules
				foreach (string moduleID in moduleIDs)
				{
					ModuleState.Enable(moduleID);
				}
				
				// Now enable all the rest (those already enabled should be skipped)
				foreach (string moduleID in ModuleUtilities.GetLegacyModules(legacyDirectoryPath))
				{
					ModuleState.Enable(moduleID);
				}
			}
		}
		
		static public string[] GetDefaultModules()
		{
			string[] moduleIDs = new string[]{
				"Messages",
				"Ideas",
				"Projects",
				"Planning",
				"Components",
				"Tasks",
				"Maintenance",
				"Links",
				"Voting"
			};
			
			return moduleIDs;
		}
		
		static public void FixEnabledModules()
		{
			if (Config.Application.EnabledModules == null ||
			    Config.Application.EnabledModules.Length == 0)
			{
				Config.Application.EnabledModules = GetDefaultModules();
				Config.Application.Save();
			}
		}

		
	}
}
