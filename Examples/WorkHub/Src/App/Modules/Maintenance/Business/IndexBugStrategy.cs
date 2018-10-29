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
	[Strategy("Index", "Bug")]
	public class IndexBugStrategy : IndexStrategy
	{
		public IndexBugStrategy()
		{
		}
		
		
		public Bug[] Index(Guid projectID, bool includePending, bool includeInProgress, bool includeOnHold, bool includeFixed, bool includeTested)
		{
			// Outer filter group
			FilterGroup group = new FilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			
			// Filter by project
			if (projectID != Guid.Empty)
				group.Add(new ReferenceFilter(typeof(Bug), "Project", "Project", projectID));
			
			
			// Status filter group
			FilterGroup statusGroup = new FilterGroup();
			group.Add(statusGroup);
			statusGroup.Operator = FilterGroupOperator.Or;
			
			
			// Filter by flags
			if (includePending)
				statusGroup.Add(new PropertyFilter(typeof(Bug), "Status", BugStatus.Pending));
			
			if (includeInProgress)
				statusGroup.Add(new PropertyFilter(typeof(Bug), "Status", BugStatus.InProgress));
			
			if (includeOnHold)
				statusGroup.Add(new PropertyFilter(typeof(Bug), "Status", BugStatus.OnHold));
			
			if (includeFixed)
				statusGroup.Add(new PropertyFilter(typeof(Bug), "Status", BugStatus.Fixed));
			
			if (includeTested)
				statusGroup.Add(new PropertyFilter(typeof(Bug), "Status", BugStatus.Tested));
			
			Bug[] bugs = Index<Bug>(group);
			
			return bugs;
		}
		
		public Bug[] IndexImportantBugs(Guid projectID, int maximumQuantity)
		{
			Collection<Bug> bugs = new Collection<Bug>(Index(projectID, true, true, true, false, false));
			Collection<Bug> topBugs = new Collection<Bug>();
			
			// Order the bugs by priority
			bugs.Sort("TitleAscending");
			bugs.Sort("PriorityDescending");
			
			for (int i = 0; i < bugs.Count; i++)
			{
				if (i < maximumQuantity)
				{
					topBugs.Add(bugs[i]);
				}
			}
			
			return topBugs.ToArray();
		}
		
		static public IndexBugStrategy New()
		{
			return new IndexBugStrategy();
		}
		
		static public IndexBugStrategy New(PagingLocation location, string sortExpression)
		{
			IndexBugStrategy strategy = new IndexBugStrategy();
			strategy.Location = location;
			strategy.EnablePaging = true;
			strategy.SortExpression = sortExpression;
			return strategy;
		}
	}
}
