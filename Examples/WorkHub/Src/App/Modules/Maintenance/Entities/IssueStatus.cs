using System;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Enumerates each possible issue status.
	/// </summary>
	public enum IssueStatus
	{
		NotSet = 0,
		Pending = 1,
		//InProgress = 2,
		//OnHold = 3,
		//Assigned = 4,
		Resolved = 5,
		Closed = 6
	}
}
