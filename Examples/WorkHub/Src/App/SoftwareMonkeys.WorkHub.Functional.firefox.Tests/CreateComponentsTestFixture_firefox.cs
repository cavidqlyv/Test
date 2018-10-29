using System;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using NUnit.Framework;
using Selenium;
using System.Net;
using System.Net.Sockets;
using OpenQA.Selenium;
using OpenQA.Selenium.Remote;

namespace SoftwareMonkeys.WorkHub.Functional.firefox.Tests
{
	[TestFixture]
	public class CreateComponentsTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
	{
		private ISelenium selenium;
		private StringBuilder verificationErrors;
	
		[SetUp]
		public void Initialize()
		{
			RemoteWebDriver driver = new OpenQA.Selenium.Firefox.FirefoxDriver();
			
			selenium = new WebDriverBackedSelenium(driver, "http://localhost/WorkHub");
			
			selenium.Start();
			verificationErrors = new StringBuilder();
		}
		
		[TearDown]
		public void Dispose()
		{
			try
			{
				selenium.Stop();
			}
			catch (Exception)
			{
				// Ignore errors if unable to close the browser
			}
			Assert.AreEqual("", verificationErrors.ToString());
		}
		
		[Test]
		public void Test_CreateComponents()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Components");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "Test Component");
			selenium.Type("ctl00_Body_ctl00_Summary", "Test summary");
			selenium.Type("ctl00_Body_ctl00_Name", "Test component");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			selenium.Click("link=Component Types");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "Test Component Type");
			selenium.Type("ctl00_Body_ctl00_Description", "Test description");
			selenium.AddSelection("ctl00_Body_ctl00_Components", "label=Test component");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test component"), "Text 'Test component' not found when it should be.");
			selenium.Click("link=Components");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "Another component");
			selenium.Type("ctl00_Body_ctl00_Summary", "Another summary");
			selenium.AddSelection("ctl00_Body_ctl00_ComponentType", "label=Test Component Type");

			selenium.AddSelection("ctl00_Body_ctl00_RelatedComponents", "label=Test component");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Test Component Type"), "Text 'Test Component Type' not found when it should be.");

		}
	}
}