using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Create", "Vote")]
	public class AuthoriseVoteStrategy : BaseAuthoriseStrategy
	{
		public AuthoriseVoteStrategy()
		{
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
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
		
		public bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity subject, string balanceProperty, string totalProperty, bool isFor)
		{
			Vote vote = new Vote();
			vote.Subject = subject;
			vote.IsFor = isFor;
			vote.BalanceProperty = balanceProperty;
			vote.TotalProperty = totalProperty;
			if (AuthenticationState.IsAuthenticated)
				vote.Voter = AuthenticationState.User;
			return IsAuthorised(vote);
		}
		
		static public AuthoriseVoteStrategy New()
		{
			return new AuthoriseVoteStrategy();
		}
	}
}
