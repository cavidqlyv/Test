using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Activate", "Milestone")]
	[Serializable]
	public class ActivateMilestoneStrategy : ActivateStrategy
	{
		public ActivateMilestoneStrategy()
		{
		}
		
		public override void Activate(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			base.Activate(entity);
			
			SortTasks((Milestone)entity);
		}
		
		public override void Activate(SoftwareMonkeys.WorkHub.Entities.IEntity entity, int depth)
		{
			base.Activate(entity, depth);
			
			SortTasks((Milestone)entity);
		}
		
		public override void Activate(SoftwareMonkeys.WorkHub.Entities.IEntity entity, string propertyName)
		{
			base.Activate(entity, propertyName);
			
			if (propertyName == "Tasks")
				SortTasks((Milestone)entity);
		}
		
		public void SortTasks(Milestone milestone)
		{
			milestone.Tasks = Collection<Task>.Sort(milestone.Tasks, "TitleAscending");
		}
	}
}
