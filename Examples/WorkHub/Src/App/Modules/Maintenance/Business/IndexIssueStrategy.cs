using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;
using SoftwareMonkeys.WorkHub.Data;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Index", "Issue")]
	public class IndexIssueStrategy : IndexStrategy
	{
		public IndexIssueStrategy()
		{
		}
		
		
		public Issue[] Index(Guid projectID, bool includePending, bool includeResolved, bool includeClosed)
		{
			// Outer filter group
			FilterGroup group = new FilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			
			// Filter by project
			if (projectID != Guid.Empty)
				group.Add(new ReferenceFilter(typeof(Issue), "Project", "Project", projectID));
			
			
			// Status filter group
			FilterGroup statusGroup = new FilterGroup();
			group.Add(statusGroup);
			statusGroup.Operator = FilterGroupOperator.Or;
			
			
			// Filter by flags
			if (includePending)
				statusGroup.Add(new PropertyFilter(typeof(Issue), "Status", IssueStatus.Pending));
			
			if (includeResolved)
				statusGroup.Add(new PropertyFilter(typeof(Issue), "Status", IssueStatus.Resolved));
			
			if (includeClosed)
				statusGroup.Add(new PropertyFilter(typeof(Issue), "Status", IssueStatus.Closed));
			
			Issue[] issues = Index<Issue>(group);
			
			return issues;
		}
		
		public Issue[] IndexImportantIssues(Guid projectID, int maximumQuantity)
		{
			Collection<Issue> issues = new Collection<Issue>(Index(projectID, true, false, false));
			Collection<Issue> topIssues = new Collection<Issue>();
			
			// Order the issues by priority
			issues.Sort("SubjectAscending");
			issues.Sort("DateReportedDescending");
			issues.Sort("ConfirmedVotesBalance");
			
			for (int i = 0; i < issues.Count; i++)
			{
				if (i < maximumQuantity)
				{
					topIssues.Add(issues[i]);
				}
			}
			
			return topIssues.ToArray();
		}
		
		static public IndexIssueStrategy New()
		{
			return new IndexIssueStrategy();
		}
		
		static public IndexIssueStrategy New(PagingLocation location, string sortExpression)
		{
			IndexIssueStrategy strategy = new IndexIssueStrategy();
			strategy.Location = location;
			strategy.EnablePaging = true;
			strategy.SortExpression = sortExpression;
			return strategy;
		}
	}
}
