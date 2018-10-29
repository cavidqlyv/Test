using System;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Diagnostics;
using System.Web.UI;

namespace SoftwareMonkeys.WorkHub.Web.Modules
{
	/// <summary>
	/// Initializes the modules state.
	/// </summary>
	static public class ModulesInitializer
	{
		static public void Initialize()
		{
			if (!ModuleState.IsInitialized)
				Initialize(new string[] {});
		}
		
		/// <summary>
		/// Initializes the modules state with a facade component provided and EnableFacade set to true.
		/// </summary>
		static public void Initialize(string[] moduleIDs)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Initializing the modules state."))
			{
				if (!ModuleState.IsInitialized)
				{
					LogWriter.Debug("# modules: " + moduleIDs.Length);
					
					ModuleState.EnableFacade = true;
					ModuleState.Facade = new ModuleFacade();

					ModuleState.Configuration = new ModuleStateConfiguration();
					
					ModuleState.Initialize(moduleIDs);
				}
				else
					LogWriter.Debug("Modules are already initialized.");
			}
		}
	}
}
