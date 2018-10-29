using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Web;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Messages
{
	/// <summary>
	/// Defines the interface required for a guide output class.
	/// </summary>
	public class MessagesModuleContext : ModuleContext
	{

        public override void Enable()
		{
			using (LogGroup logGroup = AppLogger.StartGroup("Enabling module: "+ Config.Name, NLog.LogLevel.Debug))
			{
				
			}
		}

        public override void Disable()
		{
		}

		
		public override ISiteMapManager GetSiteMapManager()
		{
			return new MessagesSiteMapManager();
		}
	}
}
