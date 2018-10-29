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
	public class CreateRoadmapTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateRoadmap()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/Tests/TestReset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Tasks");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test task #1");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Milestones");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test milestone #1");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Milestones");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test milestone #3");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Tasks");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Milestones");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test milestone #2");
			selenium.AddSelection("ctl00_Body_ctl00_Prerequisites", "label=Test milestone #1");
			selenium.AddSelection("ctl00_Body_ctl00_Tasks", "label=Test task #1");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Milestones");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl05_MoveUpButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl03_MoveDownButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl05_MoveUpButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl03_MoveDownButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl05_MoveUpButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl04_MoveUpButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_IndexGrid_ctl04_MoveDownButton");
			selenium.WaitForPageToLoad("30000");

		}
	}
}