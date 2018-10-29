using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Modules.Planning.Web;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Planning
{
	/// <summary>
	///
	/// </summary>
	[Entity("PlanningModuleContext")]
	public class PlanningModuleContext : ModuleContext
	{

		/// <summary>
		/// Enables the provided planning module.
		/// </summary>
		public override void Enable()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling module: "+ Config.Name, NLog.LogLevel.Debug))
			{
				EnableDependencies();		
			}
		}

		public override void Disable()
		{
			using (LogGroup logGroup = LogGroup.Start("Disabling the planning module.", NLog.LogLevel.Debug))
			{
			}
		}

		/// <summary>
		/// Enables any modules that this module depends on.
		/// </summary>
		public void EnableDependencies()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the dependencies of the module.", NLog.LogLevel.Debug))
			{
				if (!ModuleState.IsEnabled("Projects"))
					ModuleState.Enable("Projects");
			}
		}
		
		public override ISiteMapManager GetSiteMapManager()
		{
			return new PlanningSiteMapManager();
		}
	}
}
