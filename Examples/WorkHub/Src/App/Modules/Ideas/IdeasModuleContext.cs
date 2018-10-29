using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Ideas.Entities;
using SoftwareMonkeys.WorkHub.Modules.Ideas.Web;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Ideas
{
	/// <summary>
	/// 
	/// </summary>
	[Entity("IdeasModuleContext")]
	public class IdeasModuleContext : ModuleContext
	{

        public override void Enable()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling module: "+ Config.Name, NLog.LogLevel.Debug))
			{
				
			}
		}

        public override void Disable()
		{
		}

		
		public override ISiteMapManager GetSiteMapManager()
		{
			return new IdeasSiteMapManager();
		}
	}
}
