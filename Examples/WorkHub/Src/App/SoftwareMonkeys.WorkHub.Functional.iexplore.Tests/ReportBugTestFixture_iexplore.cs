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

namespace SoftwareMonkeys.WorkHub.Functional.iexplore.Tests
{
	[TestFixture]
	public class ReportBugTestFixture_iexplore : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
	{
		private ISelenium selenium;
		private StringBuilder verificationErrors;
	
		[SetUp]
		public void Initialize()
		{
			RemoteWebDriver driver = new OpenQA.Selenium.IE.InternetExplorerDriver();
			
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
		public void Test_ReportBug()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("SettingsLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("UserSettingsLink");
			selenium.WaitForPageToLoad("30000");
			if (!selenium.IsChecked("ctl00_Body_ctl00_AutoApproveNewUsers"))
			selenium.Click("ctl00_Body_ctl00_AutoApproveNewUsers");
			selenium.Click("ctl00_Body_ctl00_UpdateButton");
			selenium.WaitForPageToLoad("30000");
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
			selenium.Click("link=Bugs");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Title", "Test bug");
			selenium.Type("ctl00_Body_ctl00_Description", "Test description");
			selenium.AddSelection("ctl00_Body_ctl00_Priority", "label=Extreme");

			selenium.AddSelection("ctl00_Body_ctl00_Type", "label=Security");

			selenium.AddSelection("ctl00_Body_ctl00_Status", "label=In Progress");

			selenium.Type("ctl00_Body_ctl00_Version", "2.9");
			selenium.Type("ctl00_Body_ctl00_FixVersion", "3");
			selenium.Type("ctl00_Body_ctl00_PercentFixed", "50");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Bug: Test bug"), "Text 'Bug: Test bug' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("reported successfully"), "Text 'reported successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test description"), "Text 'Test description' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Extreme"), "Text 'Extreme' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Security"), "Text 'Security' not found when it should be.");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");

		}
	}
}