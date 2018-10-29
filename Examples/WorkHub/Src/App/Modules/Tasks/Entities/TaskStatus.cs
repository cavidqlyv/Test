using System;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Entities
{
	/// <summary>
	/// Enumerates each possible task status.
	/// </summary>
	public enum TaskStatus
	{
		NotSet = 0,
		Pending = 1,
		InProgress = 2,
		OnHold = 3,
		Assigned = 4,
		Completed = 5,
		Tested = 6
	}
}
