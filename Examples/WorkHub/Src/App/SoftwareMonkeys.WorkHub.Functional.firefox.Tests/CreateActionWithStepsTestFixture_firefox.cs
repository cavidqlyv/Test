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
	public class CreateActionWithStepsTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateActionWithSteps()
		{
			selenium.SetTimeout("10000000");
			selenium.Open("Admin/Tests/TestReset.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/QuickSetup.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Admin/Tests/CreateSmallData.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Open("Default.aspx");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("IndexProjectsLink");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Test Project #1");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Actions");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "Test action");
			selenium.Type("ctl00_Body_ctl00_Summary", "Test summary");
			selenium.AddSelection("ctl00_Body_ctl00_Goals", "label=Test Goal #1");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("No steps have been defined for this action."), "Text 'No steps have been defined for this action.' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test Goal #1"), "Text 'Test Goal #1' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Name:"), "Text 'Name:' not found when it should be.");
			selenium.Click("CreateActionStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Create Action Step"), "Text 'Create Action Step' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test action"), "Text 'Test action' not found when it should be.");
			selenium.Type("ctl00_Body_ctl00_ActionStepText", "Step one");
			selenium.Type("ctl00_Body_ctl00_ActionStepComments", "Test comment");
			selenium.Click("ctl00_Body_ctl00_SaveStepButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step one"), "Text 'Step one' not found when it should be.");
			selenium.Click("CreateActionStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Create Action Step"), "Text 'Create Action Step' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test action"), "Text 'Test action' not found when it should be.");
			selenium.Type("ctl00_Body_ctl00_ActionStepText", "Step two");
			selenium.Type("ctl00_Body_ctl00_ActionStepComments", "Test comment 2");
			selenium.Click("ctl00_Body_ctl00_SaveStepButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step two"), "Text 'Step two' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step one"), "Text 'Step one' not found when it should be.");
			selenium.Click("CreateActionStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Create Action Step"), "Text 'Create Action Step' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test action"), "Text 'Test action' not found when it should be.");
			selenium.Type("ctl00_Body_ctl00_ActionStepText", "Step three");
			selenium.Type("ctl00_Body_ctl00_ActionStepComments", "Test comment 3");
			selenium.Click("ctl00_Body_ctl00_SaveStepButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step two"), "Text 'Step two' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step one"), "Text 'Step one' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step three"), "Text 'Step three' not found when it should be.");
			selenium.Click("ctl00_Body_ctl00_ActionStepsGrid_ctl02_EditButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_ActionStepText", "New step one");
			selenium.Type("ctl00_Body_ctl00_ActionStepComments", "New comment");
			selenium.Click("ctl00_Body_ctl00_UpdateStepButton");
			selenium.WaitForPageToLoad("30000");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("updated successfully"), "Text 'updated successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("New step one"), "Text 'New step one' not found when it should be.");
			selenium.ChooseOkOnNextConfirmation();
			selenium.Click("ctl00_Body_ctl00_ActionStepsGrid_ctl02_DeleteButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.GetConfirmation() != null && selenium.GetConfirmation().IndexOf("Are you sure you want to delete the selected step?") > -1, "Confirm box didn't appear when expected.");
			selenium.WaitForPageToLoad("30000");
			while (!selenium.IsTextPresent("successfully"))
			Thread.Sleep(1000);
			while (!selenium.IsTextPresent("3)"))
			Thread.Sleep(1000);
			while (!selenium.IsTextPresent("Step three"))
			Thread.Sleep(1000);
			Assert.IsTrue(selenium.IsTextPresent("Action: Test action"), "Text 'Action: Test action' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Step two"), "Text 'Step two' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("2)"), "Text '2)' not found when it should be.");

		}
	}
}