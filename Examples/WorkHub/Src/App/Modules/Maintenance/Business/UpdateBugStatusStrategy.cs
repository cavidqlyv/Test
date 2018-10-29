using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("UpdateStatus", "Bug")]
	public class UpdateBugStatusStrategy : BaseStrategy
	{
		public UpdateBugStatusStrategy()
		{
		}
		
		
		public void UpdateBugStatus(Guid bugID, BugStatus status)
		{
			if (bugID == Guid.Empty)
				throw new ArgumentException("The provided bug ID cannot be Guid.Empty.", "bugID");
			
			Bug bug = RetrieveStrategy.New<Bug>().Retrieve<Bug>("ID", bugID);
			
			if (bug == null)
				throw new ArgumentException("No bug found with the ID: " + bug);
			
			ActivateStrategy.New(bug).Activate(bug);
			
			bug.Status = status;
			
			UpdateStrategy.New(bug).Update(bug);
		}
		
		
		static public UpdateBugStatusStrategy New()
		{
			return new UpdateBugStatusStrategy();
		}
	}
}
