using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business
{
	/// <summary>
	/// Deletes all releated votes after the subject gets deleted.
	/// </summary>
	[Reaction("Delete", "IEntity")]
	public class DeleteVoteSubjectReaction : BaseDeleteReaction
	{
		public DeleteVoteSubjectReaction()
		{
		}
		
		public override void React(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			// Get all the votes which have the provided entity as the subject
			Vote[] votes = IndexStrategy.New<Vote>().IndexWithReference<Vote>("Subject", entity.ShortTypeName, entity.ID);
			
			// Loop through the found votes
			foreach (Vote vote in votes)
			{
				// Delete each vote
				DeleteStrategy.New(vote).Delete(vote);
			}			
			
			base.React(entity);
		}
	}
}
