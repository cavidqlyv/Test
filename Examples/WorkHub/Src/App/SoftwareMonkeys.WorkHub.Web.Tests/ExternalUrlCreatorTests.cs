using System;
using NUnit.Framework;
using System.Web;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Modules.Tests;
using SoftwareMonkeys.WorkHub.Web.Modules;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Web.Tests
{
	/// <summary>
	/// 
	/// </summary>
	[TestFixture]
	public class ExternalUrlCreatorTests : BaseWebTestFixture
	{
		public ExternalUrlCreatorTests()
		{
		}
		
		[Test]
		public void Test_CreateExternalUrl()
		{
			ModuleState.Initialize();
			
			InitializeDummyModule();
			
			string applicationPath = "/Test";
			string originalUrl = "http://localhost/Test";
			
			string action = "TestAction";
			string typeName = "TestType";
			
			ExternalUrlCreator creator = new ExternalUrlCreator(applicationPath, originalUrl);
			creator.Converter = new MockUrlConverter();
			
			creator.EnableFriendlyUrls = true;
			
			string url = creator.CreateExternalUrl(action, typeName);
			
			string expectedUrl = "http://localhost/Test/" + creator.PrepareForUrl(action) + "-"	+ creator.PrepareForUrl(typeName) + ".aspx";
			
			Assert.AreEqual(expectedUrl, url, "The URL doesn't match what's expected.");
		
		}
		
		
		[Test]
		public void Test_CreateExternalUrl_MatchProperty()
		{
			ModuleState.Initialize();
			
			InitializeDummyModule();
			
			string applicationPath = "/Test";
			string originalUrl = "http://localhost/Test";
			
			string action = "TestAction";
			string typeName = "TestType";
			
			ExternalUrlCreator creator = new ExternalUrlCreator(applicationPath, originalUrl);
			creator.Converter = new MockUrlConverter();
			creator.EnableFriendlyUrls = true;
			
			string propertyName = "ID";
			string dataKey = Guid.NewGuid().ToString();
			
			string url = creator.CreateExternalUrl(action, typeName, propertyName, dataKey);
			
			string expectedUrl = "http://localhost/Test/" + creator.PrepareForUrl(action) + "-"	+ creator.PrepareForUrl(typeName) + "/" + creator.PrepareForUrl(propertyName) + "--" + creator.PrepareForUrl(dataKey) + ".aspx";
			
			Assert.AreEqual(expectedUrl, url, "The URL doesn't match what's expected.");
		
		}
		
		
		[Test]
		public void Test_CreateExternalXmlUrl()
		{
			ModuleState.Initialize();
			
			string applicationPath = "/Test";
			string originalUrl = "http://localhost/Test";
			
			string action = "Create";
			string typeName = "User";
			
			
			ExternalUrlCreator creator = new ExternalUrlCreator(applicationPath, originalUrl);
			creator.Converter = new MockUrlConverter();
			creator.EnableFriendlyUrls = true;
			
			string url = creator.CreateExternalXmlUrl(action, typeName);
			
			string expectedUrl = originalUrl + "/" + action + "-" + typeName + ".xml.aspx";
			
			Assert.AreEqual(expectedUrl, url, "The URL doesn't match what's expected.");
		
		}
		
		
        private void InitializeDummyModule()
        {
            ModuleConfig moduleConfig = new ModuleConfig();
            
            ModuleContext module = new MockModuleLoader().GetModule(moduleConfig.ModuleID);
            module.Config = moduleConfig;
            
            module.ModuleID = "TestModule";
            module.Config.Name = "TestModule";


            if (ModuleState.Modules.Contains("TestModule"))
                ModuleState.Modules.Remove(ModuleState.Modules["TestModule"]);

           ModuleState.Modules.Add(module);
        }
	}
}
