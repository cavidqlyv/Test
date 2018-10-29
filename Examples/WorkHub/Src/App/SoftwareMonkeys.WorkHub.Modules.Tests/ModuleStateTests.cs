using NUnit.Framework;
using System;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Tests the ModuleState class.
	/// </summary>
	[TestFixture]
	public class ModuleStateTests : BaseModuleTestFixture
	{
    	[Test]
        public void Test_IsEnabled_true()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Facade = new MockModuleFacade();
        		
        	ModuleState.Configuration.EnabledModules = new string[] {"MockModule"};
        	
        	ModuleState.Loader = new MockModuleLoader();
        	
        	ModuleState.Initialize(new string[]{"MockModule"});
        	
        	Assert.IsTrue(ModuleState.IsEnabled("MockModule"), "The ModuleState.IsEnabled function returns false when it shouldn't.");
        	
        	Assert.IsFalse(ModuleState.IsEnabled("MissingModule"), "The ModuleState.IsEnabled function returns true when it shouldn't.");
        }
        
    	[Test]
        public void Test_IsEnabled_false()
        {
        	
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Facade = new MockModuleFacade();
        		
        	ModuleState.Configuration.EnabledModules = new string[] {};
        	
        	ModuleState.Initialize(new string[]{"MockModule"});
        	
        	Assert.IsFalse(ModuleState.IsEnabled("MockModule"), "The ModuleState.IsEnabled function returns true when it shouldn't. The module isn't in the Config.Application.Enabled modules list.");
        }
		
    	[Test]
        public void Test_IsInitialized()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	
        	if (ModuleState.IsInitialized)
	        	ModuleState.Dispose();
        	
        	Assert.IsFalse(ModuleState.IsInitialized, "The ModuleState.IsInitialized property returns true when it shouldn't.");
        	
        	ModuleState.Initialize();
        	
        	Assert.IsTrue(ModuleState.IsInitialized, "The ModuleState.IsInitialized property returns false when it shouldn't.");
        }
        
        [Test]
        public void Test_Initialize()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Initialize();
        	
        	Assert.IsTrue(ModuleState.IsInitialized);
        	
        	Assert.IsNotNull(ModuleState.Modules);
        }
		
    	[Test]
        public void Test_Modules_Exists()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Initialize();
        	
        	Assert.IsNotNull(ModuleState.Modules, "The ModuleState.Modules property is null.");
        }
        
    	[Test]
        public void Test_Modules_AddAndContains()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Initialize();
        	
        	ModuleContext testModule = new MockModuleContext();
        	
        	ModuleState.Modules.Add(testModule);
        	
        	Assert.IsTrue(ModuleState.Modules.Contains(testModule.ModuleID));
        }
        
        
    	[Test]
        public void Test_Enable()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Facade = new MockModuleFacade();
        	ModuleState.Initialize();
        	
        	ModuleContext testModule = ModuleState.Loader.GetModule("MockModule");
        	
        	ModuleState.Enable(testModule.ModuleID);
        	
        	Assert.IsTrue(ModuleState.Modules.Contains(testModule.ModuleID), "Module wasn't found when it should have been.");
        	
        	Assert.IsTrue(Array.IndexOf(Config.Application.EnabledModules, testModule.ModuleID) > -1, "The module is NOT the Config.Application.EnabledModules array when it SHOULD be.");
        }
        
    	[Test]
        public void Test_Disable()
        {
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Configuration.EnabledModules = new String[] {};
        	ModuleState.Facade = new MockModuleFacade();
        	ModuleState.Initialize();
        	
        	ModuleContext testModule = new MockModuleContext();
        	
        	ModuleState.Modules.Add(testModule);
        	
        	ModuleState.Disable(testModule.ModuleID);
        	
        	Assert.AreEqual(0, ModuleState.Modules.Count, "Module wasn't removed when it should have been.");
        	
        	Assert.IsFalse(ModuleState.Modules.Contains(testModule.ModuleID), "Module was found when it should have been removed.");
        	
        	Assert.IsTrue(Array.IndexOf(Config.Application.EnabledModules, testModule.ModuleID) == -1, "The module IS in the Config.Application.EnabledModules array when it SHOULDN'T be.");
        }
        
		// TODO: Remove if not needed
		/*[Test]
		public void Test_GetModuleID()
		{
			string action = "MockAction";
			string typeName = "MockType";
			
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Facade = new MockModuleFacade();
        	ModuleState.Initialize();
        	
        		
			ModuleContext module = new MockModuleContext();
			module.ModuleID = "MockModule1";
			module.Config = new ModuleConfig();
			
			ModulePageCommandConfig cmd1 = new ModulePageCommandConfig();
			cmd1.CommandName = "MockAction";
			cmd1.Type = "MockType";
			cmd1.DisplayOnMenu = true;
			cmd1.Title = "Menu Command";
			
			ModulePageCommandConfig cmd2 = new ModulePageCommandConfig();
			cmd2.CommandName = "MockCommand2";
			cmd2.Type = "MockType2";
			cmd2.DisplayOnMenu = false;
			
			ModulePageConfig page1 = new ModulePageConfig();
			page1.Title = "Mock Page 1";
			page1.Category = "Mock Category";
			page1.Commands = new ModulePageCommandConfig[]{
				cmd1,
				cmd2
			};
			
			module.Config.Pages = new ModulePageConfig[] {
				page1
			};
        	
        	ModuleState.Modules.Add(module);
        	
        	string moduleID = ModuleState.GetModuleID(action, typeName);
        	
        	Assert.AreEqual("MockModule1", moduleID, "The returned module ID isn't what's expected.");
        	
		}
		
		[Test]
		public void Test_GetControlID()
		{
			string action = "MockAction";
			string typeName = "MockType";
			
        	ModuleState.Loader = new MockModuleLoader();
        	ModuleState.Configuration = new ModuleStateConfiguration();
        	ModuleState.Facade = new MockModuleFacade();
        	ModuleState.Initialize();
        	
        		
			ModuleContext module = new MockModuleContext();
			module.ModuleID = "MockModule1";
			module.Config = new ModuleConfig();
			
			ModulePageCommandConfig cmd1 = new ModulePageCommandConfig();
			cmd1.CommandName = "MockAction";
			cmd1.Type = "MockType";
			cmd1.DisplayOnMenu = true;
			cmd1.Title = "Menu Command";
			
			ModulePageCommandConfig cmd2 = new ModulePageCommandConfig();
			cmd2.CommandName = "MockCommand2";
			cmd2.Type = "MockType2";
			cmd2.DisplayOnMenu = false;
			
			ModulePageConfig page1 = new ModulePageConfig();
			page1.Title = "Mock Page 1";
			page1.Category = "Mock Category";
			page1.ControlID = "MockControl";
			page1.Commands = new ModulePageCommandConfig[]{
				cmd1,
				cmd2
			};
			
			module.Config.Pages = new ModulePageConfig[] {
				page1
			};
        	
        	ModuleState.Modules.Add(module);
        	
        	string controlID = ModuleState.GetControlID(action, typeName);
        	
        	Assert.AreEqual("MockControl", controlID, "The returned control ID isn't what's expected.");
		}*/
	}
}
