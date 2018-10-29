using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Web;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Voting
{
	/// <summary>
	/// 
	/// </summary>
	[Entity("VotingModuleContext")]
	public class VotingModuleContext : ModuleContext
	{

        public override void Enable()
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Enabling module: "+ Config.Name))
			{
				
			}
		}

        public override void Disable()
		{
		}

		
		public override ISiteMapManager GetSiteMapManager()
		{
			return new VotingSiteMapManager();
		}
	}
}
