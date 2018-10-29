using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Index", "Milestone")]
	public class IndexMilestoneStrategy : IndexStrategy
	{
		public IndexMilestoneStrategy()
		{
		}
		
		public override T[] Index<T>()
		{
			Collection<Milestone> milestones = new Collection<Milestone>(base.Index<T>());
			
			PrepareMilestoneNumbers(milestones);
			
			return Collection<T>.ConvertAll(milestones.ToArray(), typeof(T));
		}
		
		public override T[] IndexWithReference<T>(string propertyName, string referencedEntityType, Guid referencedEntityID)
		{
			if (typeof(T).Name != "Milestone")
				throw new ArgumentException("The generic type parameter is not a Milestone when is must be.");
			
			Collection<Milestone> milestones = new Collection<Milestone>(base.IndexWithReference<Milestone>(propertyName, referencedEntityType, referencedEntityID));
			
			PrepareMilestoneNumbers(milestones);
			
			return Collection<T>.ConvertAll(milestones.ToArray(), typeof(T));
			
			
		}
		
		public override IEntity[] IndexWithReference(string propertyName, string referencedEntityType, Guid referencedEntityID)
		{
			Collection<Milestone> milestones = new Collection<Milestone>(base.IndexWithReference(propertyName, referencedEntityType, referencedEntityID));
			
			PrepareMilestoneNumbers(milestones);
			
			return milestones.ToArray();
			
			
		}
		
		public void PrepareMilestoneNumbers(Collection<Milestone> milestones)
		{
			
			milestones.Sort("MilestoneNumberAscending");
			
			ResetMilestoneNumbers(milestones);
		}
		
		public void ResetMilestoneNumbers(Collection<Milestone> milestones)
		{
			for (int i = 0; i < milestones.Count; i++)
			{
				milestones[i].MilestoneNumber = i+1;
				
			}
		}
	}
}
