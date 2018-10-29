using System;
using SoftwareMonkeys.WorkHub.Modules;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Web.Parts
{
	/// <summary>
	/// Used to enable all the parts within a particular module.
	/// </summary>
	public class ModulePartsEnabler
	{
		public PartLoader Loader;
		
		public ModulePartsEnabler(PartLoader loader)
		{
			Loader = loader;
		}
		
		public void Enable(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the projections for the module '" + module.ModuleID + "'.", NLog.LogLevel.Debug))
			{
				if (!PartState.IsInitialized)
					InitializeParts();
				
				foreach (PartInfo part in Loader.LoadInfoFromFile(true))
				{
					if (IsInModule(module, part))
					{
						LogWriter.Debug("Enabling part - Action: " + part.Action + " | Type Name: " + part.TypeName + " | Path: " + part.PartFilePath);
						
						// Enable the part
						part.Enabled = true;
						
						// Update the memory state
						PartState.Parts[PartState.Parts.GetPartKey(part)] = part;
					}
				}
				
				new PartSaver().SaveInfoToFile(PartState.Parts.ToArray());
			}
		}
		
		public void Disable(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Disabling the projections for the module '" + module.ModuleID + "'.", NLog.LogLevel.Debug))
			{
				if (!PartState.IsInitialized)
					InitializeParts();
				
				foreach (PartInfo part in Loader.LoadInfoFromFile(true))
				{
					if (IsInModule(module, part))
					{
						LogWriter.Debug("Disabling part - Action: " + part.Action + " | Type Name: " + part.TypeName + " | Path: " + part.PartFilePath);
						
						// Disable the part
						part.Enabled = false;
						
						// Update the memory state
						PartState.Parts[PartState.Parts.GetPartKey(part)] = part;
					}
				}
				
				new PartSaver().SaveInfoToFile(PartState.Parts.ToArray());
			}
		}
		
		public bool IsInModule(ModuleContext module, PartInfo part)
		{
			bool output = false;
			
			using (LogGroup logGroup = LogGroup.Start("Checking whether the provided part is in the provided module.", NLog.LogLevel.Debug))
			{
				string[] sections = part.PartFilePath.Trim('/').Split('/');
				
				if (sections.Length > 0)
				{
					// If the first section of the path is "Modules" then it's part of a module
					if (sections[0] == "Modules")
					{
						// If the second section matches the ID then it's in the provided module
						if (sections[1] == module.ModuleID)
							output = true;
					}
				}
				
				LogWriter.Debug("Output: " + output.ToString());
			}
			
			return output;
		}
		
		public void InitializeParts()
		{
			
			if (Configuration.Config.IsInitialized)
			{
				// TODO: Check if needed. Shouldn't be.
				//new ControllersInitializer().Initialize();
				new PartsInitializer().Initialize();
			}
			
		}
	}
}
