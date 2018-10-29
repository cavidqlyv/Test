using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Links.Entities;
using SoftwareMonkeys.WorkHub.Modules.Links.Web;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Links
{
	/// <summary>
	/// 
	/// </summary>
	[Entity("LinksModuleContext")]
	public class LinksModuleContext : ModuleContext
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
			return new LinksSiteMapManager();
		}
	}
}
