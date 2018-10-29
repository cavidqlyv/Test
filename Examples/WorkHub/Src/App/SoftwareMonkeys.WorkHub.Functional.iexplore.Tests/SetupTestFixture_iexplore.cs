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
	public class SetupTestFixture_iexplore : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_Setup()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx?Config=true");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Open("Default.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("WorkHub Setup"), "Text 'WorkHub Setup' not found when it should be.");
			selenium.Type("Username", "test");
			selenium.Type("Password", "pass");
			selenium.Type("PasswordConfirm", "pass");
			selenium.Type("FirstName", "Test");
			selenium.Type("LastName", "User");
			selenium.Type("Email", "testuser@softwaremonkeys.net");
			selenium.Click("StartButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Getting started"), "Text 'Getting started' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Setup Complete"), "Text 'Setup Complete' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("You are signed in as: test"), "Text 'You are signed in as: test' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Sign Out"), "Text 'Sign Out' not found when it should be.");

		}
	}
}