using System;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Reflection;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// Provides a mock implementation of the module loader component.
	/// </summary>
	public class MockModuleLoader : ModuleLoader
	{
		public MockModuleLoader()
		{
		}
		
		/// <summary>
		/// Retrieves a mock module context.
		/// </summary>
		/// <param name="module"></param>
		/// <returns></returns>
		public override ModuleContext GetModule(ModuleConfig config)
		{
			ModuleContext module = new MockModuleContext();
			module.ModuleID = config.ModuleID;
			
			return module;
		}
		
		/// <summary>
		/// Creates a mock instance of the module config without having to load it from file.
		/// </summary>
		/// <param name="path">The path to the config file (not used in mock loader).</param>
		/// <returns>A mock instance of the module config.</returns>
		public override SoftwareMonkeys.WorkHub.Configuration.ModuleConfig GetConfigFromPath(string path)
		{
			ModuleConfig config = new ModuleConfig();
			config.ModuleID = "MockModule";
			config.Name = "Mock Module";
			
			return config;
		}
		
		/// <summary>
		/// Retrieves the assembly from Assembly.GetExecutingAssembly instead of trying to load one from file.
		/// </summary>
		/// <param name="moduleID">The ID of the module to load the assembly for (not used in mock loader).</param>
		/// <returns>The executing assembly.</returns>
		public override System.Reflection.Assembly GetModuleAssembly(string moduleID)
		{
			return Assembly.GetExecutingAssembly();
		}
		
		/// <summary>
		/// Retrieves a collection of module module contexts instead of loading from file.
		/// </summary>
		/// <returns>The collection of module contexts.</returns>
		public override ModuleContextCollection GetModules()
		{
			ModuleContextCollection collection = new ModuleContextCollection();
			collection.Add(GetModule("sdf")); // The path doesn't have to be real for the mock loader
			return collection;
		}
	}
}
