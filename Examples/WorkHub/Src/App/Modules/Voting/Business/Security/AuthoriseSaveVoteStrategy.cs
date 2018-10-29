using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Save", "Vote")]
	public class AuthoriseSaveVoteStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveVoteStrategy()
		{
			Action = "Vote";
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// All users can vote generally once signed in
			if (AuthenticationState.IsAuthenticated)
				return true;
			else
				return false;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the user is authorised to vote."))
			{
				Vote vote = (Vote)entity;
				
				if (vote.Subject == null)
					throw new ArgumentException("vote.Subject must be set");
				
				bool userHasVoted = CheckVoteStrategy.New().UserHasVoted(vote);
				bool isSignedIn = AuthenticationState.IsAuthenticated;
				
				LogWriter.Debug("User has voted: " + userHasVoted);
				LogWriter.Debug("User is signed in:  " + isSignedIn);
				
				isAuthorised = isSignedIn
					&& !userHasVoted;

				LogWriter.Debug("Is authorised: " + isAuthorised);
			}
			
			return isAuthorised;
		}
		
		public bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity subject, bool isFor)
		{
			Vote vote = new Vote();
			vote.Subject = subject;
			vote.IsFor = isFor;
			if (AuthenticationState.IsAuthenticated)
				vote.Voter = AuthenticationState.User;
			return IsAuthorised(vote);
		}
		
		public override void EnsureAuthorised(IEntity entity)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Ensuring that the user can vote."))
			{
				Vote vote = (Vote)entity;
				
				LogWriter.Debug("Is for: " + vote.IsFor.ToString());
				
				if (vote.Subject == null)
					throw new ArgumentException("vote.Subject must be set");
				
				base.EnsureAuthorised(entity);
			}
		}
		
		
		
		public static AuthoriseSaveVoteStrategy New()
		{
			return new AuthoriseSaveVoteStrategy();
		}
	}
}
