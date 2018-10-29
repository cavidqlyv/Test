using System;
using NUnit.Framework;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Description of ModuleContextCollectionTests.
	/// </summary>
	[TestFixture]
	public class ModuleContextCollectionTests : BaseModuleTestFixture
	{
		[Test]
		public void Test_this()
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			collection.Loader = new MockModuleLoader();
			
			ModuleContext mockModule = collection.Loader.GetModule("MockModule");
			
			collection.Add(mockModule);
			
			ModuleContext module = collection["MockModule"];
			
			Assert.IsNotNull(module, "The mock module wasn't loaded into the collection.");
		}
		
		[Test]
		public void Test_Contains()
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			collection.Loader = new MockModuleLoader();
			
			collection.Add(collection.Loader.GetModule("sdf")); // path doesn't have to be real for mock loader
			
			Assert.IsTrue(collection.Contains("MockModule"), "The Contains function returned false when it shouldn't.");
			
			Assert.IsFalse(collection.Contains("MissingModule"), "The Contains function returned true when it shouldn't.");
		}
		
		[Test]
		public void Test_Remove()
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			collection.Loader = new MockModuleLoader();
			
			collection.Add(collection.Loader.GetModule("sdf")); // ID doesn't have to be real for mock loader
			
			Assert.AreEqual(1, collection.Count, "Invalid number of items found before removing.");
			
			collection.Remove(collection[0]);
			
			Assert.AreEqual(0, collection.Count, "Invalid number of items found.");
		}
		
		
		[Test]
		public void Test_RemoveAt()
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			collection.Loader = new MockModuleLoader();
			
			collection.Add(collection.Loader.GetModule("sdf")); // ID doesn't have to be real for mock loader
			
			Assert.AreEqual(1, collection.Count, "Invalid number of items found before removing.");
			
			collection.RemoveAt(0);
			
			Assert.AreEqual(0, collection.Count, "Invalid number of items found.");
			
			Assert.IsFalse(collection.Contains("MissingModule"), "The Contains function returned true when it shouldn't.");
		}
	}
}
