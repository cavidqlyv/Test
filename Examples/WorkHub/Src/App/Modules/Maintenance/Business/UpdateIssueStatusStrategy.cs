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
	[Strategy("UpdateStatus", "Issue")]
	public class UpdateIssueStatusStrategy : BaseStrategy
	{
		public UpdateIssueStatusStrategy()
		{
		}
		
		public void UpdateIssueStatus(Guid issueID, IssueStatus status)
		{
			if (issueID == Guid.Empty)
				throw new ArgumentException("The provided issue ID cannot be Guid.Empty.", "issueID");
			
			Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);
			
			if (issue == null)
				throw new ArgumentException("No issue found with the ID: " + issue);
			
			ActivateStrategy.New(issue).Activate(issue);
			
			if (issue.Status == IssueStatus.Pending
			    && (status == IssueStatus.Resolved
			        || status == IssueStatus.Closed))
				issue.DateResolved = DateTime.Now;
			
			issue.Status = status;
			
			UpdateStrategy.New(issue).Update(issue);
		}
		
		
		static public UpdateIssueStatusStrategy New()
		{
			return new UpdateIssueStatusStrategy();
		}
	}
}
