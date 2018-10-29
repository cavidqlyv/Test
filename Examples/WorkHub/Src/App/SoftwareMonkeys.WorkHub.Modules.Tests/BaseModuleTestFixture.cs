using System;
using SoftwareMonkeys.WorkHub.Business.Tests;
using NUnit.Framework;
using SoftwareMonkeys.WorkHub.Tests;
using System.IO;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Provides a base implementation for all module test fixtures.
	/// </summary>
	public abstract class BaseModuleTestFixture : BaseBusinessTestFixture
	{
		
		[SetUp]
		public new void Start()
		{
			ModuleState.Initialize();
			
		}
		
		[TearDown]
		public new void End()
		{
			ModuleState.Dispose();
		}
		
		protected virtual string GetModulesDirectory()
		{
			return TestUtilities.GetTestingPath(this) + Path.DirectorySeparatorChar + "Modules";
		}
		
		protected virtual string GetTestModuleName()
		{
			return "TestModule";
		}
		
		protected virtual string GetTestModulePath()
		{
			string modulePath = GetModulesDirectory() + Path.DirectorySeparatorChar + GetTestModuleName();
			
			return modulePath;
		}
		
		protected virtual void CreateMockModule()
		{
			string path = GetTestModulePath();
			
			string config = GetMockModuleConfig();
			string configPath = GetMockModuleConfigPath();
			
			SaveTextToFile(config, configPath);
		}
		
		protected virtual void RemoveMockModule()
		{
			string path = GetTestModulePath();
		}
		
		protected virtual string GetMockModuleConfigPath()
		{
			return GetTestModulePath() + Path.DirectorySeparatorChar
				+ GetTestModuleName() + ".config";
		}
		
		protected virtual string GetMockModuleConfig()
		{
			string output = @"<?xml version=""1.0""?>
<Module xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <Name>TestModule</Name>
  <Title>TestModule</Title>
  <UniversalProjectID>19b18096-a320-4f79-bd8c-1a90df9e7324</UniversalProjectID>
  <Pages>
    <Page>
      <Title>Test</Title>
      <Category>Tests</Category>
      <ControlID>Test</ControlID>
      <Commands>
        <Command Name=""TestCommand"" Title=""Test"" Type=""TestType"" DisplayOnMenu=""true"" />
      </Commands>
    </Page>
  </Pages>
</Module>";
			
			return output;
		}
		
		protected virtual void SaveTextToFile(string text, string filePath)
		{
			if (!Directory.Exists(Path.GetDirectoryName(filePath)))
				Directory.CreateDirectory(Path.GetDirectoryName(filePath));
			
			using (StreamWriter writer = File.CreateText(filePath))
			{
				writer.Write(text);
				writer.Close();
			}
		}
	}
}
