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
	public class CreateIdeasTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateIdeas()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Ideas");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Details", "Test idea");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Create Idea"), "Text 'Create Idea' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Details:"), "Text 'Details:' not found when it should be.");
			selenium.Type("ctl00_Body_ctl00_Details", "Test idea 2");
			selenium.AddSelection("ctl00_Body_ctl00_SubIdeas", "label=Test idea");
			selenium.AddSelection("ctl00_Body_ctl00_RelatedIdeas", "label=Test idea");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Create Idea"), "Text 'Create Idea' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Details:"), "Text 'Details:' not found when it should be.");
			selenium.Type("ctl00_Body_ctl00_Details", "Test idea 3");
			selenium.AddSelection("ctl00_Body_ctl00_SubIdeas", "label=Test idea");
			selenium.AddSelection("ctl00_Body_ctl00_RelatedIdeas", "label=Test idea");
			selenium.AddSelection("ctl00$Body$ctl00$ctl01", "label=Idea Index");

			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Manage Ideas"), "Text 'Manage Ideas' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test idea"), "Text 'Test idea' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test idea 2"), "Text 'Test idea 2' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test idea 3"), "Text 'Test idea 3' not found when it should be.");
			selenium.Click("link=Delete");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.GetConfirmation() != null && selenium.GetConfirmation().IndexOf("Are you sure you wish to delete this idea?") > -1, "Confirm box didn't appear when expected.");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			Assert.IsFalse(selenium.IsTextPresent("Test Idea #1"), "Text 'Test Idea #1' found when it shouldn't be.");

		}
	}
}