using System;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Enumerates the options available for a bug type.
	/// </summary>
	public enum BugType
	{
		NotSet,
		Cosmetic,
		Functional,
		Security,
		Performance,
		Hidden
	}
}
