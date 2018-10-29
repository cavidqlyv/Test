using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Web;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance
{
	/// <summary>
	/// 
	/// </summary>
	[Entity("MaintenanceModuleContext")]
	public class MaintenanceModuleContext : ModuleContext
	{

		public override void Enable()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling module: "+ Config.Name, NLog.LogLevel.Debug))
			{
				EnableDependencies();
			}
		}

        public override void Disable()
		{
			
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
			return new MaintenanceSiteMapManager();
		}
	}
}
