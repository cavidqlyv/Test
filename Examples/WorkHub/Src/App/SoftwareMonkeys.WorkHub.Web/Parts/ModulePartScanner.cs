using System;
using System.Reflection;
using System.Collections.Generic;
using System.IO;
using SoftwareMonkeys.WorkHub.Diagnostics;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Web.Parts
{
	/// <summary>
	/// Used for scanning assemblies to look for usable business parts.
	/// </summary>
	public class ModulePartScanner : PartScanner
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
		
		public ModulePartScanner()
		{
		}
		
		public ModulePartScanner(Page page) : base(page)
		{
		}
		
		public ModulePartScanner(Page page, string moduleID)
		{
			Page = page;
			Module = moduleID;
		}
		
		/// <summary>
		/// Finds all the parts in the available assemblies.
		/// </summary>
		/// <returns>An array of info about the parts found.</returns>
		public override PartInfo[] FindParts()
		{
			List<PartInfo> parts = new List<PartInfo>();
			
			using (LogGroup logGroup = LogGroup.Start("Finding parts by scanning the attributes of the available type.", NLog.LogLevel.Debug))
			{
				string[] directories = new String[] {};
				
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
					string srcDirectory = directory + Path.DirectorySeparatorChar + "Parts";
					
					if (Directory.Exists(srcDirectory))
					{
						foreach (string file in Directory.GetFiles(srcDirectory, "*.ascx"))
						{
							if (IsPart(file))
							{
								foreach (PartInfo info in ExtractPartInfo(file))
								{
									// Disabled by default. Gets enabled when the module is enabled.
									info.Enabled = false;
									parts.Add(info);
								}
							}
						}
					}
				}
			}
			
			return parts.ToArray();
		}
	}
}
