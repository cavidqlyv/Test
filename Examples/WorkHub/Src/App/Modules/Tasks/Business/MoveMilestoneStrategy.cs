using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// Used to move a milestone up or down in the list.
	/// </summary>
	[Strategy("Move", "Milestone")]
	public class MoveMilestoneStrategy : BaseStrategy
	{
		public MoveMilestoneStrategy()
		{
		}
		
		public void MoveUp(Guid milestoneID)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Moving specified milestone up one position in the list."))
			{
				Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);
				
				if (milestone == null)
					throw new ArgumentException("Milestone not found with the provided ID.");
				
				ActivateStrategy.New<Milestone>().Activate(milestone);
				
				Milestone[] milestones = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", milestone.Project.ID);
				
				milestones = Collection<Milestone>.Sort(milestones, "MilestoneNumberAscending");
				
				RefreshMilestoneNumbers(milestones);
				
				int milestoneIndex = milestone.MilestoneNumber - 1; // Adjust to index

				if (milestone.MilestoneNumber <= 0)
				{
					throw new InvalidOperationException("The specified milestone is already at the top of the list.");
				}


				Milestone previousMilestone = milestones[milestoneIndex-1];
				
				ActivateStrategy.New<Milestone>().Activate(previousMilestone);

				if (milestone != null && previousMilestone != null)
				{
					milestone.MilestoneNumber = milestone.MilestoneNumber - 1;
					previousMilestone.MilestoneNumber = previousMilestone.MilestoneNumber + 1;
				}
				else
					throw new Exception("milestone or previousMilestone == null");
				
				if (previousMilestone.Project == null)
					throw new InvalidOperationException("The previous milestone doesn't have a parent project associated with it.");

				UpdateStrategy.New<Milestone>().Update(previousMilestone);
				
				UpdateStrategy.New<Milestone>().Update(milestone);
			}
		}
		
		public void MoveDown(Guid milestoneID)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Moving specified milestone down one position in the list."))
			{
				Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);
				
				if (milestone == null)
					throw new ArgumentException("Milestone not found with the provided ID.");
				
				ActivateStrategy.New<Milestone>().Activate(milestone);
				
				Milestone[] milestones = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", milestone.Project.ID);
				
				milestones = Collection<Milestone>.Sort(milestones, "MilestoneNumberAscending");

				RefreshMilestoneNumbers(milestones);
				
				int milestoneIndex = milestone.MilestoneNumber - 1; // Adjust to index

				if (milestone.MilestoneNumber > milestones.Length)
				{
					throw new InvalidOperationException("The specified milestone is already at the bottom of the list.");
				}
				
				Milestone nextMilestone = milestones[milestoneIndex + 1];
				
				ActivateStrategy.New<Milestone>().Activate(nextMilestone);
				
				if (nextMilestone.Project == null)
					throw new InvalidOperationException("The next milestone doesn't have a parent project associated with it.");

				if (milestone != null && nextMilestone != null)
				{
					milestone.MilestoneNumber = milestone.MilestoneNumber + 1;
					nextMilestone.MilestoneNumber = nextMilestone.MilestoneNumber - 1;
				}
				else
					throw new Exception("milestone or nextMilestone == null");

				UpdateStrategy.New<Milestone>().Update(nextMilestone);
				UpdateStrategy.New<Milestone>().Update(milestone);
			}
		}
		
		public void RefreshMilestoneNumbers(Milestone[] milestones)
		{
			for (int i = 0; i < milestones.Length; i++)
			{
				milestones[i].MilestoneNumber = i+1; // +1 to convert 0 based index to 1 based number
			}
		}
		
		static public MoveMilestoneStrategy New()
		{
			return new MoveMilestoneStrategy();
		}
	}
}
