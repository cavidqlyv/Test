using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// The strategy used to remove a specific task from a specific milestone.
	/// </summary>
	[Strategy("RemoveFromMilestone", "Task")]
	public class RemoveTaskFromMilestoneStrategy : BaseStrategy
	{
		private IRetrieveStrategy taskRetriever;
		/// <summary>
		/// Gets/sets the strategy used to retrieve a task.
		/// </summary>
		public IRetrieveStrategy TaskRetriever
		{
			get {
				if (taskRetriever == null)
					taskRetriever = StrategyState.Strategies.Creator.NewRetriever(typeof(Task).Name);
				return taskRetriever; }
			set { taskRetriever = value; }
		}
		
		private IActivateStrategy taskActivator;
		/// <summary>
		/// Gets/sets the strategy used to activate a task.
		/// </summary>
		public IActivateStrategy TaskActivator
		{
			get {
				if (taskActivator == null)
					taskActivator = StrategyState.Strategies.Creator.NewActivator(typeof(Task).Name);
				return taskActivator; }
			set { taskActivator = value; }
		}
		
		private IUpdateStrategy milestoneUpdater;
		/// <summary>
		/// Gets/sets the strategy used to update a milestone.
		/// </summary>
		public IUpdateStrategy MilestoneUpdater
		{
			get {
				if (milestoneUpdater == null)
					milestoneUpdater = StrategyState.Strategies.Creator.NewUpdater(typeof(Milestone).Name);
				return milestoneUpdater; }
			set { milestoneUpdater = value; }
		}
		
		
		private IRetrieveStrategy milestoneRetriever;
		/// <summary>
		/// Gets/sets the strategy used to retrieve milestones.
		/// </summary>
		public IRetrieveStrategy MilestoneRetriever
		{
			get {
				if (milestoneRetriever == null)
					milestoneRetriever = StrategyState.Strategies.Creator.NewRetriever(typeof(Milestone).Name);
				return milestoneRetriever; }
			set { milestoneRetriever = value; }
		}
		
		private IActivateStrategy milestoneActivator;
		/// <summary>
		/// Gets/sets the strategy used to activate a milestone.
		/// </summary>
		public IActivateStrategy MilestoneActivator
		{
			get {
				if (milestoneActivator == null)
					milestoneActivator = StrategyState.Strategies.Creator.NewActivator(typeof(Milestone).Name);
				return milestoneActivator; }
			set { milestoneActivator = value; }
		}
		
		public RemoveTaskFromMilestoneStrategy()
		{
		}
		
		/// <summary>
		/// Removes the specified task from the specified milestone.
		/// </summary>
		/// <param name="taskID">The ID of the task to remove from the specified milestone.</param>
		/// <param name="milestoneID">The ID of the milestone to remove the specified task from.</param>
		public void Remove(Guid taskID, Guid milestoneID)
		{
			if (taskID == Guid.Empty)
				throw new ArgumentException("Task ID cannot be Guid.Empty.", "taskID");
			
			if (milestoneID == Guid.Empty)
				throw new ArgumentException("Milestone ID cannot be Guid.Empty.", "milestoneID");
			
			Milestone milestone = MilestoneRetriever.Retrieve<Milestone>(milestoneID);
			
			if (milestone == null)
				throw new ArgumentException("No milestone found with the ID '" + milestoneID.ToString() + "'.");				
				
			MilestoneActivator.Activate(milestone);
			
			Task task = TaskRetriever.Retrieve<Task>(taskID);
			
			if (task == null)
				throw new ArgumentException("No task found with the ID '" + taskID.ToString() + "'.");
			
			milestone.Tasks = Collection<Task>.Remove(milestone.Tasks, task);
			
			MilestoneUpdater.Update(milestone);
			
		}
	}
}
