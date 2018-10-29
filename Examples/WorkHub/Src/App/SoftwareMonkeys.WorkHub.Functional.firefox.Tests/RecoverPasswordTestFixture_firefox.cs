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
	public class RecoverPasswordTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
	{
		private ISelenium selenium;
		private StringBuilder verificationErrors;
	
		[SetUp]
		public void Initialize()
		{
			RemoteWebDriver driver = new OpenQA.Selenium.Firefox.FirefoxDriver();
			
			selenium = new WebDriverBackedSelenium(driver, "http://localhost/WorkHub-beta-Workspace");
			
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
		public void Test_RecoverPassword()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx?Config=true");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.Click("link=Users");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Edit");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("id=ctl00_Body_ctl00_Email", "support@softwaremonkeys.net");
			selenium.Click("id=ctl00_Body_ctl00_UpdateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Settings");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Email Settings");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("id=ctl00_Body_ctl00_SmtpServer", "mail.bigpond.com");
			selenium.Click("id=ctl00_Body_ctl00_UpdateButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("successfully"), "Text 'successfully' not found when it should be.");
			selenium.Click("id=TestSmtpLink");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Success"), "Text 'Success' not found when it should be.");
			selenium.Click("id=SignOutLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Forgot my password!");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("id=ctl00_Body_ctl00_EmailAddress", "support@softwaremonkeys.net");
			selenium.Click("id=ctl00_Body_ctl00_RecoverButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			selenium.Open("Admin/Tests/ChangePassword.aspx?Email=support@softwaremonkeys.net");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("id=ctl00_Body_ctl00_Password", "newpass");
			selenium.Type("id=ctl00_Body_ctl00_PasswordConfirm", "newpass");
			selenium.Click("id=ctl00_Body_ctl00_UpdateButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Account Details"), "Text 'Account Details' not found when it should be.");
			selenium.Click("id=SignOutLink");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("id=ctl00_Body_ctl00_Login_UserName", "admin");
			selenium.Type("id=ctl00_Body_ctl00_Login_Password", "newpass");
			selenium.Click("id=ctl00_Body_ctl00_Login_LoginButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Sign In Details"), "Text 'Sign In Details' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("signed in as"), "Text 'signed in as' not found when it should be.");

		}
	}
}