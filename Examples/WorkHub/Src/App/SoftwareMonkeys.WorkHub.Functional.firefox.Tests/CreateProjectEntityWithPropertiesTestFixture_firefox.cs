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
	public class CreateProjectEntityWithPropertiesTestFixture_firefox : SoftwareMonkeys.WorkHub.Functional.Tests.BaseFunctionalTestFixture
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
		public void Test_CreateProjectEntityWithProperties()
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
			selenium.WaitForPageToLoad("30000");
			selenium.Click("link=Entities");
			selenium.WaitForPageToLoad("30000");
			selenium.Click("ctl00_Body_ctl00_CreateButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_Name", "Test entity");
			selenium.Type("ctl00_Body_ctl00_Description", "sdf");
			selenium.Click("ctl00_Body_ctl00_SaveButton");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Entity: Test entity"), "Text 'Entity: Test entity' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("No properties have been added"), "Text 'No properties have been added' not found when it should be.");
			selenium.Click("ctl00_Body_ctl00_CreatePropertyButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_PropertyName", "Test property");
			selenium.Type("ctl00_Body_ctl00_OtherPropertyType", "Custom type");
			selenium.AddSelection("ctl00_Body_ctl00_PropertyType", "label=Other");

			selenium.Type("ctl00_Body_ctl00_Description", "Test description");
			selenium.Click("ctl00_Body_ctl00_Button1");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("saved successfully"), "Text 'saved successfully' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Test property"), "Text 'Test property' not found when it should be.");
			Assert.IsTrue(selenium.IsTextPresent("Custom type"), "Text 'Custom type' not found when it should be.");
			selenium.Click("ctl00_Body_ctl00_PropertiesGrid_ctl02_EditButton");
			selenium.WaitForPageToLoad("30000");
			selenium.Type("ctl00_Body_ctl00_PropertyName", "Test property 2");
			selenium.Type("ctl00_Body_ctl00_Description", "Test description 2");
			selenium.AddSelection("ctl00_Body_ctl00_PropertyType", "label=Text");

			selenium.Type("ctl00_Body_ctl00_OtherPropertyType", "");
			selenium.Click("ctl00_Body_ctl00_Button2");
			selenium.WaitForPageToLoad("30000");
			Assert.IsTrue(selenium.IsTextPresent("Test property 2"), "Text 'Test property 2' not found when it should be.");
			selenium.ChooseOkOnNextConfirmation();
			selenium.Click("ctl00_Body_ctl00_PropertiesGrid_ctl02_DeleteButton");
			Assert.IsTrue(selenium.GetConfirmation() != null && selenium.GetConfirmation().IndexOf("Are you sure you want to delete the selected property?") > -1, "Confirm box didn't appear when expected.");
			selenium.WaitForPageToLoad("30000");
			while (!selenium.IsTextPresent(""))
			Thread.Sleep(1000);

		}
	}
}