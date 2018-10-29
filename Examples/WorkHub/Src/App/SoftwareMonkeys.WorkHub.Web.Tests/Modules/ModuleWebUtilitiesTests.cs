using System;
using NUnit.Framework;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Modules;

namespace SoftwareMonkeys.WorkHub.Web.Tests.Modules
{
	/// <summary>
	/// 
	/// </summary>
	[TestFixture]
	public class ModuleWebUtilitiesTests : BaseWebTestFixture
	{
		[Test]
		public void Test_GetModuleID_FromProjectionInfo()
		{
			string moduleID = "TestModule";
			
			ProjectionInfo info = new ProjectionInfo();
			info.ProjectionFilePath = "Modules/" + moduleID + "/Projections/Entity-Action.ascx";
			
			string result = ModuleWebUtilities.GetModuleID(info);
			
			Assert.AreEqual(moduleID, result, "Didn't return correct module ID.");
		}
		
		[Test]
		public void Test_GetModuleID_FromPartInfo()
		{
			string moduleID = "TestModule";
			
			PartInfo info = new PartInfo();
			info.PartFilePath = "Modules/" + moduleID + "/Parts/Entity-Action.ascx";
			
			string result = ModuleWebUtilities.GetModuleID(info);
			
			Assert.AreEqual(moduleID, result, "Didn't return correct module ID.");
		}
	}
}
