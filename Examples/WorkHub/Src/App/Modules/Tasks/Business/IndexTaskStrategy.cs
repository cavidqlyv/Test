using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Data;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Index", "Task")]
	public class IndexTaskStrategy : IndexStrategy
	{
		public IndexTaskStrategy()
		{
		}
		
		
		public Task[] Index(Guid projectID, bool includePending, bool includeInProgress, bool includeOnHold, bool includeCompleted, bool includeTested)
		{
			Task[] tasks = new Task[]{};
			
			using (LogGroup logGroup = LogGroup.StartDebug("Indexing tasks with the specified filters."))
			{
				LogWriter.Debug("Project ID: " + projectID.ToString());
				LogWriter.Debug("Include 'pending': " + includePending.ToString());
				LogWriter.Debug("Include 'in progress': " + includeInProgress.ToString());
				LogWriter.Debug("Include 'on hold': " + includeOnHold.ToString());
				LogWriter.Debug("Include 'completed': " + includeCompleted.ToString());
				LogWriter.Debug("Included 'tested': " + includeTested.ToString());
				
				// Outer filter group
				FilterGroup group = new FilterGroup();
				group.Operator = FilterGroupOperator.And;
				
				// Filter by project
				if (projectID != Guid.Empty)
					group.Add(new ReferenceFilter(typeof(Task), "Project", "Project", projectID));
								
				// Status filter group
				FilterGroup statusGroup = new FilterGroup();
				group.Add(statusGroup);
				statusGroup.Operator = FilterGroupOperator.Or;
				
				// Filter by flags
				if (includePending)
					statusGroup.Add(new PropertyFilter(typeof(Task), "Status", TaskStatus.Pending));
				
				if (includeInProgress)
					statusGroup.Add(new PropertyFilter(typeof(Task), "Status", TaskStatus.InProgress));
				
				if (includeOnHold)
					statusGroup.Add(new PropertyFilter(typeof(Task), "Status", TaskStatus.OnHold));
				
				if (includeCompleted)
					statusGroup.Add(new PropertyFilter(typeof(Task), "Status", TaskStatus.Completed));
				
				if (includeTested)
					statusGroup.Add(new PropertyFilter(typeof(Task), "Status", TaskStatus.Tested));
				
				tasks = Index<Task>(group);
			}
			return tasks;
		}
		
		public Task[] IndexImportantTasks(Guid projectID, int maximumQuantity)
		{
			Collection<Task> tasks = new Collection<Task>(Index(projectID, true, true, false, false, false));
			Collection<Task> topTasks = new Collection<Task>();
			
			// Order the tasks by priority
			tasks.Sort("TitleAscending");
			tasks.Sort("PriorityDescending");
			
			for (int i = 0; i < tasks.Count; i++)
			{
				if (i < maximumQuantity)
				{
					topTasks.Add(tasks[i]);
				}
			}
			
			return topTasks.ToArray();
		}
		
		static public IndexTaskStrategy New()
		{
			return new IndexTaskStrategy();
		}
		
		static public IndexTaskStrategy New(PagingLocation location, string sortExpression)
		{
			IndexTaskStrategy strategy = new IndexTaskStrategy();
			strategy.Location = location;
			strategy.EnablePaging = true;
			strategy.SortExpression = sortExpression;
			return strategy;
		}
	}
}
