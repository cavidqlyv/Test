using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("UpdateStatus", "Task")]
	public class UpdateTaskStatusStrategy : UpdateStrategy
	{
		public UpdateTaskStatusStrategy()
		{
		}
		
		
		public void UpdateTaskStatus(Guid taskID, TaskStatus status)
		{
			if (taskID == Guid.Empty)
				throw new ArgumentException("The provided task ID cannot be Guid.Empty.", "taskID");
			
			Task task = RetrieveStrategy.New<Task>().Retrieve<Task>("ID", taskID);
			
			if (task == null)
				throw new ArgumentException("No task found with the ID: " + task);
			
			ActivateStrategy.New(task).Activate(task);
			
			task.Status = status;
			
			UpdateStrategy.New(task).Update(task);
		}
		
		
		static public UpdateTaskStatusStrategy New()
		{
			return new UpdateTaskStatusStrategy();
		}
	}
}
