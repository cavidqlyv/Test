using System;
using NUnit.Framework;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	[TestFixture]
	public class ModuleContextTest : BaseModuleTestFixture
	{
		bool DeleteEventHandled = false;
		
		[SetUp]
		public void Start()
		{
			DeleteEventHandled = false;
		}
		
		[TearDown]
		public void End()
		{
			DeleteEventHandled = false;
		}
		
		[Test]
		public void Test_EntityDeleted_Collection()
		{
			MockModuleLoader loader = new MockModuleLoader();
			
			ModuleContext module1 = loader.GetModule("MockModule1");
			module1.ModuleID = "MockModule1";
			ModuleState.Modules.Add(module1);
			
			ModuleContext module2 = loader.GetModule("MockModule2");
			module2.ModuleID = "MockModule2";
			ModuleState.Modules.Add(module2);
			
			module1.EntityDeleted += new EntityEventHandler(module1_EntityDeleted);
			
			module1.RaiseEntityDeleted(module1);
			
			Assert.IsTrue(DeleteEventHandled, "The delete event wasn't handled (or may not have been configured properly).");
		}

		void module1_EntityDeleted(object sender, EntityEventArgs e)
		{
			DeleteEventHandled = true;
		}
	}
}
