using System;
using NUnit.Framework;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Tests the ModuleStateConfiguration component.
	/// </summary>
	[TestFixture]
	public class ModuleStateConfigurationTests : BaseModuleTestFixture
	{
		[Test]
		public void Test_AddToConfig_Detached()
		{
			ModuleStateConfiguration configuration = new ModuleStateConfiguration();
			configuration.EnabledModules = new String[]{};
			configuration.AddToConfig("MockModule");
			
			Assert.AreEqual(1, configuration.EnabledModules.Length, "Invalid number of module IDs found in the array.");
		}
		
		[Test]
		public void Test_AddToConfig_Attached()
		{
			ModuleStateConfiguration configuration = new ModuleStateConfiguration();
			
			configuration.AddToConfig("MockModule");
			
			Assert.AreEqual(1, configuration.EnabledModules.Length, "Invalid number of module IDs found in the array.");
			Assert.AreEqual(1, Configuration.Config.Application.EnabledModules.Length, "Invalid number of module IDs found in the application configuration's EnabledModules array.");
		}
		
		
		[Test]
		public void Test_RemoveFromConfig_Detached()
		{
			ModuleStateConfiguration configuration = new ModuleStateConfiguration();
			
			configuration.EnabledModules = new String[]{"MockModule"};
			
			configuration.RemoveFromConfig("MockModule");
			
			Assert.AreEqual(0, configuration.EnabledModules.Length, "Invalid number of module IDs found in the array.");
		}
		
		[Test]
		public void Test_RemoveFromConfig_Attached()
		{
			Configuration.Config.Application.EnabledModules = new String[]{"MockModule", "MockModule2", "MockModule3"};
			
			ModuleStateConfiguration configuration = new ModuleStateConfiguration();
			
			configuration.RemoveFromConfig("MockModule");
			
			Assert.AreEqual(2, configuration.EnabledModules.Length, "Invalid number of module IDs found in the array.");
			Assert.AreEqual(2, Configuration.Config.Application.EnabledModules.Length, "Invalid number of module IDs found in the application configuration's EnabledModules array.");
			
			Assert.AreEqual("MockModule2", configuration.EnabledModules[0], "MockModule2 not found in the array.");
			Assert.AreEqual("MockModule3", configuration.EnabledModules[1], "MockModule3 not found in the array.");
		}
		
		
		[Test]
		public void Test_Contains_Attached()
		{
			Configuration.Config.Application.EnabledModules = new String[]{"MockModule", "MockModule2", "MockModule3"};
			
			ModuleStateConfiguration configuration = new ModuleStateConfiguration();
			
			bool contains = configuration.Contains("MockModule2");
			bool doesntContain = configuration.Contains("MissingModule");
			
			Assert.IsTrue(contains, "The Contains function returned false when it should have returned true.");
			Assert.IsFalse(doesntContain, "The Contains function returned true when it should have returned false.");
		}
	}
}
