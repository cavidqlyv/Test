using System;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Defines a mock module context.
	/// </summary>
	public class MockModuleContext : ModuleContext
	{		
		public MockModuleContext()
		{
		}
		
		
        public override void Enable()
		{
		}

        public override void Disable()
		{
		}

		
		public override SoftwareMonkeys.WorkHub.Web.ISiteMapManager GetSiteMapManager()
		{
			throw new NotImplementedException();
		}
	}
}
