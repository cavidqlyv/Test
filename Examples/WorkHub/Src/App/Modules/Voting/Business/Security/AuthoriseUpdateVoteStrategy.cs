using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Update", "Vote")]
	public class AuthoriseUpdateVoteStrategy : AuthoriseUpdateStrategy
	{
		public AuthoriseUpdateVoteStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			Vote vote = (Vote)entity;
			
			ActivateStrategy.New(vote).Activate(vote);
			
			return vote.Voter.ID == AuthenticationState.User.ID;
		}
	}
}
