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
	public class DeleteProjectTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_DeleteProject()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("IndexProjectsLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Goals");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Test Goal #1"), "Text 'Test Goal #1' not found when it should be.");
			selenium.Click("IndexProjectsLink");
			selenium.WaitForPageToLoad("30000");
			selenium.ChooseOkOnNextConfirmation();
			selenium.Click("link=Delete");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.GetConfirmation() != null && selenium.GetConfirmation().IndexOf("Are you sure you wish to delete this project and all related data?") > -1, "Confirm box didn't appear when expected.");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("No projects found."), "Text 'No projects found.' not found when it should be.");
			selenium.Open("Admin/Data.aspx");
			selenium.Click("link=Goal");
			Assert.IsFalse(selenium.IsTextPresent("Test Goal"), "Text 'Test Goal' found when it shouldn't be.");
			selenium.Open("Admin/Data.aspx");
			selenium.Click("link=Project");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Test Project"), "Text 'Test Project' found when it shouldn't be.");
			selenium.Open("Admin/Data.aspx");
			selenium.Click("link=Goal-Project");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("EntityReference"), "Text 'EntityReference' found when it shouldn't be.");

		}
	}
}