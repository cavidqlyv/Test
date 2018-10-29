using System;

namespace SoftwareMonkeys.WorkHub.UI.Modules
{
	/// <summary>
	/// Defines the interface of all module facade components.
	/// </summary>
	public interface IModuleFacade
	{
		/// <summary>
		/// Enables the module with the specified ID and takes care of facade configuration such as site maps, etc.
		/// </summary>
		/// <param name="moduleID">The ID of the module to enable.</param>
		void Enable(string moduleID);
		
		/// <summary>
		/// Disables the module with the specified ID and takes care of undoing facade configuration such as site maps, etc.
		/// </summary>
		/// <param name="moduleID">The ID of the module to disable.</param>
		void Disable(string moduleID);
	}
}
