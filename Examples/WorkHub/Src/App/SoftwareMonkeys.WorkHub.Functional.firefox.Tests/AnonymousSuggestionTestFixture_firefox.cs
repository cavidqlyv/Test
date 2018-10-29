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
	public class AnonymousSuggestionTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_AnonymousSuggestion()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Click("SettingsLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("UserSettingsLink");
			selenium.WaitForPageToLoad("30000");
			if (!selenium.IsChecked("ctl00_Body_ctl00_AutoApproveNewUsers"))
			selenium.Click("ctl00_Body_ctl00_AutoApproveNewUsers");
			selenium.Click("ctl00_Body_ctl00_UpdateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("SignOutLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("RegisterLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_FirstName", "Approved");
			selenium.Type("ctl00_Body_ctl00_LastName", "User");
			selenium.Type("ctl00_Body_ctl00_Email", "approveduser@softwaremonkeys.net");
			selenium.Type("ctl00_Body_ctl00_Username", "approveduser");
			selenium.Type("ctl00_Body_ctl00_Password", "pass");
			selenium.Type("ctl00_Body_ctl00_PasswordConfirm", "pass");
			selenium.Click("ctl00_Body_ctl00_EnableNotifications");
			selenium.Click("ctl00_Body_ctl00_RegisterButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("My Details"), "Text 'My Details' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("approveduser@softwaremonkeys.net"), "Text 'approveduser@softwaremonkeys.net' not found when it should be.");
			selenium.Click("CreateProjectLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "My Project");
			selenium.Type("ctl00_Body_ctl00_Summary", "My summary");
			selenium.Type("ctl00_Body_ctl00_MoreInfo", "More info");
			selenium.Type("ctl00_Body_ctl00_CompanyName", "MyBiz");
			selenium.Type("ctl00_Body_ctl00_CurrentVersion", "2.0");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("My Project"), "Text 'My Project' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("My summary"), "Text 'My summary' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("More info"), "Text 'More info' not found when it should be.");
			selenium.Click("SignOutLink");
			selenium.WaitForPageToLoad("30000");
			selenium.AddSelection("ctl00_CurrentProject", "label=-- Overview --");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Suggestions");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Subject", "Test suggestion");
			selenium.Type("ctl00_Body_ctl00_Description", "Test description");
			selenium.Type("ctl00_Body_ctl00_AuthorName", "Test name");
			selenium.Type("ctl00_Body_ctl00_AuthorEmail", "test@softwaremonkeys.net");
			selenium.AddSelection("ctl00_Body_ctl00_Project", "label=My Project");

			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Suggestion Submitted"), "Text 'Suggestion Submitted' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("saved successfully"), "Text 'saved successfully' not found when it should be.");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");

		}
	}
}