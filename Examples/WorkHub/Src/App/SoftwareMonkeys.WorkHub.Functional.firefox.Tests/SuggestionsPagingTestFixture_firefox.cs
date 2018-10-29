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
	public class SuggestionsPagingTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_SuggestionsPaging()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("MockCreate-Suggestion.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Done"), "Text 'Done' not found when it should be.");
			selenium.Click("link=Suggestions");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=2");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Test suggestion 10"), "Text 'Test suggestion 10' not found when it should be.");
			Assert.IsFalse(selenium.IsTextPresent("Test suggestion 8"), "Text 'Test suggestion 8' found when it shouldn't be.");
			selenium.Click("link=3");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Test suggestion 20"), "Text 'Test suggestion 20' not found when it should be.");
			Assert.IsFalse(selenium.IsTextPresent("Test suggestion 8"), "Text 'Test suggestion 8' found when it shouldn't be.");
			Assert.IsFalse(selenium.IsTextPresent("Test suggestion 15"), "Text 'Test suggestion 15' found when it shouldn't be.");
			selenium.Click("link=1");
			selenium.WaitForPageToLoad("30000");
			Assert.IsFalse(selenium.IsTextPresent("Exception"), "Text 'Exception' found when it shouldn't be.");
			Assert.IsTrue(selenium.IsTextPresent("Test suggestion 1"), "Text 'Test suggestion 1' not found when it should be.");
			Assert.IsFalse(selenium.IsTextPresent("Test suggestion 15"), "Text 'Test suggestion 15' found when it shouldn't be.");
			Assert.IsFalse(selenium.IsTextPresent("Test suggestion 25"), "Text 'Test suggestion 25' found when it shouldn't be.");

		}
	}
}