using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// Description of MoveTaskToMilestoneStrategy.
	/// </summary>
	[Strategy("MoveToMilestone", "Task")]
	public class MoveTaskToMilestoneStrategy
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
		
		private IUpdateStrategy taskUpdater;
		/// <summary>
		/// Gets/sets the strategy used to update a task.
		/// </summary>
		public IUpdateStrategy TaskUpdater
		{
			get {
				if (taskUpdater == null)
					taskUpdater = StrategyState.Strategies.Creator.NewUpdater(typeof(Task).Name);
				return taskUpdater; }
			set { taskUpdater = value; }
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
		
		public MoveTaskToMilestoneStrategy()
		{
		}
		
		/// <summary>
		/// Moves the task with the provided ID to the milestone with the provided ID.
		/// </summary>
		/// <param name="taskID"></param>
		/// <param name="fromMilestoneID"></param>
		/// <param name="milestoneID"></param>
		public void Move(Guid taskID, Guid fromMilestoneID, Guid milestoneID)
		{
			// Load the task
			Task task = TaskRetriever.Retrieve<Task>(taskID);
			
			if (task == null)
				throw new ArgumentException("No task found with the ID: " + taskID.ToString());
			
			TaskActivator.Activate(task);
			
			// Remove the old milestone from the task
			task.Milestones = Collection<Milestone>.Remove(task.Milestones, 
			                                              MilestoneRetriever.Retrieve<Milestone>(fromMilestoneID));
			
			
			// Add new new milestone to the task
			task.Milestones = Collection<Milestone>.Add(task.Milestones, 
			                                              MilestoneRetriever.Retrieve<Milestone>(milestoneID));
			
			
			TaskUpdater.Update(task);
			
			// Load the "from" milestone
			Milestone fromMilestone = MilestoneRetriever.Retrieve<Milestone>(fromMilestoneID);
			
			if (fromMilestone == null)
				throw new ArgumentException("No from milestone found with the ID: " + fromMilestoneID.ToString());
			
			MilestoneActivator.Activate(fromMilestone);
			
			// Remove the task from the old milestone
			fromMilestone.Tasks = Collection<Task>.Remove(fromMilestone.Tasks, task);
			
			MilestoneUpdater.Update(fromMilestone);
		}
		
		static public MoveTaskToMilestoneStrategy New()
		{
			return new MoveTaskToMilestoneStrategy();
		}
	}
}
