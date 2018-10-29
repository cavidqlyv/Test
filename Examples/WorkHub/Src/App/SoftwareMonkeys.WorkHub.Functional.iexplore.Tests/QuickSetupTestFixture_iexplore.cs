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
	public class QuickSetupTestFixture_iexplore : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_QuickSetup()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx?Config=true");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Getting started"), "Text 'Getting started' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Setup Complete"), "Text 'Setup Complete' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("You are signed in as: admin"), "Text 'You are signed in as: admin' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Sign Out"), "Text 'Sign Out' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Projects"), "Text 'Projects' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Planning"), "Text 'Planning' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Maintenance"), "Text 'Maintenance' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Components"), "Text 'Components' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Ideas"), "Text 'Ideas' not found when it should be.");

		}
	}
}