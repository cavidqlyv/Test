using System;
using System.Reflection;
using System.Collections.Generic;
using System.IO;
using SoftwareMonkeys.WorkHub.Diagnostics;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Web.Projections
{
	/// <summary>
	/// Used for scanning assemblies to look for usable business projections.
	/// </summary>
	public class ModuleProjectionScanner : ProjectionScanner
	{
		private string modulesDirectoryPath = String.Empty;
		/// <summary>
		/// Gets the full path to the directory containing the modules.
		/// </summary>
		public string ModulesDirectoryPath
		{
			get {
				if (modulesDirectoryPath == String.Empty)
					modulesDirectoryPath = StateAccess.State.PhysicalApplicationPath + Path.DirectorySeparatorChar
						+ "Modules";
				return modulesDirectoryPath; }
		}
		
		private string module = String.Empty;
		/// <summary>
		/// Gets the full path to the directory containing the modules.
		/// </summary>
		public string Module
		{
			get
			{
				return module;
			}
			set { module = value; }
		}
		
		public ModuleProjectionScanner()
		{
		}
		
		public ModuleProjectionScanner(ControlLoader controlLoader) : base(controlLoader)
		{
		}
		
		public ModuleProjectionScanner(ControlLoader controlLoader, string moduleID)
		{
			ControlLoader = controlLoader;
			Module = moduleID;
		}
		
		/// <summary>
		/// Finds all the projections in the available assemblies.
		/// </summary>
		/// <returns>An array of info about the projections found.</returns>
		public override ProjectionInfo[] FindProjections()
		{
			List<ProjectionInfo> projections = new List<ProjectionInfo>();
			
			using (LogGroup logGroup = LogGroup.StartDebug("Finding module projections."))
			{
				string[] directories = new String[] {};
				
				LogWriter.Debug("Modules directory path: " + ModulesDirectoryPath);
				
				if (Module == String.Empty)
					directories = Directory.GetDirectories(ModulesDirectoryPath);
				else
				{
					directories = new string[] {
						ModulesDirectoryPath + Path.DirectorySeparatorChar
							+ Module
					};
				}
				
				foreach (string directory in directories)
				{
					string srcDirectory = directory + Path.DirectorySeparatorChar + "Projections";
					
					using (LogGroup logGroup2 = LogGroup.StartDebug("Scanning directory: " + srcDirectory))
					{
						if (Directory.Exists(srcDirectory))
						{
							foreach (string file in Directory.GetFiles(srcDirectory, "*.ascx"))
							{
								using (LogGroup logGroup3 = LogGroup.StartDebug("Checking projection file: " + file))
								{
									
									if (IsProjection(file))
									{
										LogWriter.Debug("Found projection file: " + file);
										
										foreach (ProjectionInfo info in ExtractProjectionInfo(file))
										{
											if (info.Name != String.Empty)
												LogWriter.Debug("Adding info: " + info.Name);
											else
												LogWriter.Debug("Adding nifo: " + info.Action + "-" + info.TypeName);
											
											// Disabled by default. Gets enabled when the module is enabled.
											info.Enabled = false;
											
											projections.Add(info);
										}
									}
									else
										LogWriter.Debug("File is not projection. Skipping.");
								}
							}
						}
						else
							LogWriter.Debug("Directory doesn't exist. Skipping.");
					}
				}
			}
			return projections.ToArray();
		}
	}
	
}
