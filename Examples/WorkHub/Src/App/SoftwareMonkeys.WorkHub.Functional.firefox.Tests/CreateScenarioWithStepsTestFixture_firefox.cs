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
	public class CreateScenarioWithStepsTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateScenarioWithSteps()
		{
			selenium.SetTimeout("1000000");
			selenium.Open("Admin/tests/testreset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Scenario-MockCreate.aspx");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Done"), "Text 'Done' not found when it should be.");
			selenium.AddSelection("ctl00_CurrentProject", "label=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Scenarios");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Test scenario");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Test scenario"), "Text 'Test scenario' not found when it should be.");
			selenium.Click("ctl00_Body_ctl00_CreateScenarioStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_ScenarioStepText", "Test step 1");
			selenium.Click("ctl00_Body_ctl00_SaveStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Scenario: Test scenario"), "Text 'Scenario: Test scenario' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test step 1"), "Text 'Test step 1' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Scenario Steps"), "Text 'Scenario Steps' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Up"), "Text 'Up' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Down"), "Text 'Down' not found when it should be.");
			selenium.Click("ctl00_Body_ctl00_ScenarioStepsGrid_ctl02_EditButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_ScenarioStepText", "New test step");
			selenium.Type("ctl00_Body_ctl00_ScenarioStepComments", "Test comment");
			selenium.Click("ctl00_Body_ctl00_UpdateStepButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("New test step"), "Text 'New test step' not found when it should be.");
			selenium.ChooseOkOnNextConfirmation();
			selenium.Click("ctl00_Body_ctl00_ScenarioStepsGrid_ctl02_DeleteButton");
			Assert.IsTrue(selenium.GetConfirmation() != null && selenium.GetConfirmation().IndexOf("Are you sure you want to delete the selected step?") > -1, "Confirm box didn't appear when expected.");
			selenium.WaitForPageToLoad("30000");
			while (!selenium.IsTextPresent("deleted successfully"))
			Thread.Sleep(1000);
			Assert.IsTrue(selenium.IsTextPresent("No steps have been defined"), "Text 'No steps have been defined' not found when it should be.");

		}
	}
}