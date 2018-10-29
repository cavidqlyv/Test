using System;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Enumerates each possible task status.
	/// </summary>
	[Flags]
	public enum BugStatus : int
	{
		//NotSet = 0,
		Pending = 1,
		InProgress = 2,
		OnHold = 3,
		Fixed = 4,
		Tested = 5
	}
}
