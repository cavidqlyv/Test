using System;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.UI.Modules;

namespace SoftwareMonkeys.WorkHub.Modules.Tests
{
	/// <summary>
	/// A mock implementation of the ModuleFacade component for use during testing.
	/// </summary>
	public class MockModuleFacade : IModuleFacade
	{
		public void Enable(string moduleID)
		{
			// Skipped. This component is used when testing other parts of the modules functionality and the facade functionality is not needed.
		}
		
		public void Disable(string moduleID)
		{
			// Skipped. This component is used when testing other parts of the modules functionality and the facade functionality is not needed.
		}
	}
}
