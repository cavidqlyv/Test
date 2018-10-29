using System;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Modules;
using NUnit.Framework;
using SoftwareMonkeys.WorkHub.Modules.Tests;

namespace SoftwareMonkeys.WorkHub.Web.Tests.Projections
{
	[TestFixture]
	public class ModuleProjectionsEnablerTests : BaseWebTestFixture
	{
		public ModuleProjectionsEnablerTests()
		{
		}
		
		[Test]
		public void Test_IsInModule_True()
		{
			ModuleContext module = new MockModuleContext();
			module.ModuleID = "TestModule";
				
			ProjectionInfo projection = new ProjectionInfo();
			projection.ProjectionFilePath = "Modules/" + module.ModuleID + "/Projections/TestEntity-TestAction.ascx";
			
			ModuleProjectionsEnabler enabler = new ModuleProjectionsEnabler(new ProjectionLoader());
			bool isInModule = enabler.IsInModule(module, projection);
			
			Assert.IsTrue(isInModule, "Failed to match.");
		}
		
		[Test]
		public void Test_IsInModule_False()
		{
			ModuleContext module = new MockModuleContext();
			module.ModuleID = "TestModule";
				
			ProjectionInfo projection = new ProjectionInfo();
			projection.ProjectionFilePath = "Modules/" + module.ModuleID + "/Projections/TestEntity-TestAction.ascx";
			
			ModuleProjectionsEnabler enabler = new ModuleProjectionsEnabler(new ProjectionLoader());
			bool isInModule = enabler.IsInModule(module, projection);
			
			Assert.IsTrue(isInModule, "Failed to match.");
		}
	}
}
