using NUnit.Framework;
using System;
using System.Reflection;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Tests;
using System.IO;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Tests the module loader class.
	/// </summary>
	[TestFixture]
	public class ModuleLoaderTests : BaseModuleTestFixture
	{
		[Test]
		public void GetModuleAssembly()
		{
			Assembly assembly = new ModuleLoader().GetModuleAssembly("Projects");
			
			Assert.IsNotNull(assembly, "The assembly for the 'Projects' module wasn't loaded.");
		}
		
		[Test]
		public void GetModule()
		{
			ModuleLoader loader = new ModuleLoader();
			
			ModuleConfig config = new ModuleConfig();
			config.ModuleID = "Projects";
			
			ModuleContext context = loader.GetModule(config);
			
			Assert.IsNotNull(context, "The context for the 'Projects' module wasn't loaded.");
		}
		
		// TODO: Fix or remove
		/*[Test]
		public void GetModuleConfigFilePath()
		{
			ModuleLoader loader = new ModuleLoader();
			
			string path = loader.GetConfigFilePath("Projects");
			
			string expected = TestUtilities.GetTestingPath(this) + Path.DirectorySeparatorChar;
			
			Assert.AreEqual(expected, path, "The path doesn't match what's expected.");
		}*/
		
		[Test]
		public void GetModuleConfigFromPath()
		{
			CreateMockModule();
			
			
			string path = GetMockModuleConfigPath();
			
			Assert.IsTrue(File.Exists(path), "Test module configuration file not found.");
			
			ModuleConfig config = new ModuleLoader().GetConfigFromPath(path);
			
			Assert.IsNotNull(config, "The config for the 'Projects' module wasn't loaded.");
		}
	}
}
