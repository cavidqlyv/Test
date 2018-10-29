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
	public class CreateTasks_SameTitleDifferentProjectsTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateTasks_SameTitleDifferentProjects()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/Tests/TestReset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateMediumData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Home");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Tasks");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test task");
			selenium.AddSelection("ctl00_Body_ctl00_AssignedUsers", "label=System Administrator");
			selenium.AddSelection("ctl00_Body_ctl00_AssignedUsers", "label=Test User #1");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("System Administrator"), "Text 'System Administrator' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test User #1"), "Text 'Test User #1' not found when it should be.");
			selenium.Click("link=Tasks");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #2");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test task");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Test User #1"), "Text 'Test User #1' found when it shouldn't be.");

		}
	}
}