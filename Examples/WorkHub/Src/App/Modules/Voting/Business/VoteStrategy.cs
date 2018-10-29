using System;
using System.Reflection;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Create", "Vote")]
	public class VoteStrategy : CreateStrategy
	{
		public VoteStrategy()
		{
		}
		
		public override IEntity Create()
		{
			return base.Create();
		}
		
		/// <summary>
		/// Records a vote for the specified subject.
		/// </summary>
		/// <param name="subject">The entity that is the subject of the vote.</param>
		/// <param name="isFor">A value indicating whether the vote is in favor of the subject.</param>
		public virtual void Vote(IEntity subject, bool isFor)
		{
			Vote(subject, String.Empty, String.Empty, isFor);
		}
		
		/// <summary>
		/// Records a vote for the specified subject.
		/// </summary>
		/// <param name="subject">The entity that is the subject of the vote.</param>
		/// <param name="balanceProperty">The name of the property containing the balance of votes.</param>
		/// <param name="totalProperty">The name of the property containing the total number of votes.</param>
		/// <param name="isFor">A value indicating whether the vote is in favor of the subject.</param>
		public virtual void Vote(IEntity subject, string balanceProperty, string totalProperty, bool isFor)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Recording vote."))
			{
				if (subject == null)
					throw new ArgumentNullException("subject");
				
				LogWriter.Debug("Subject type: " + subject.ShortTypeName);
				LogWriter.Debug("Subject: " + subject.ToString());
				
				if (AuthoriseVoteStrategy.New().IsAuthorised(subject, balanceProperty, totalProperty, isFor))
				{
					Vote existingVote = RetrieveVoteStrategy.New().RetrieveExisting(subject, balanceProperty, totalProperty);
					
					// If an existing vote is found then update it
					if (existingVote != null)
					{
						existingVote.IsFor = isFor;
						
						UpdateStrategy.New(existingVote).Update(existingVote);
					}
					// Otherwise create a new vote
					else
					{
						Vote vote = new Vote();
						
						vote.Voter = AuthenticationState.User;
						vote.Subject = subject;
						vote.IsFor = isFor;
						vote.BalanceProperty = balanceProperty;
						vote.TotalProperty = totalProperty;
						
						// TODO: Remove if not needed. Shouldn't be needed because the SaveStrategy.Save function takes care of it
						//if (RequireAuthorisation)
						//	AuthoriseSaveVoteStrategy.New().EnsureAuthorised(vote);
						
						SaveStrategy.New(vote).Save(vote);
					}
					
					if (totalProperty != String.Empty)
						SetTotal(subject, totalProperty);
					
					if (balanceProperty != String.Empty)
						SetBalance(subject, balanceProperty);
					
					// Authorisation check skipped in update below because it's only setting the count property internally
					// and the user has no access to it
					ActivateStrategy.New(subject, false).Activate(subject);
					UpdateStrategy.New(subject, false).Update(subject);
				}
			}
		}
		
		public void SetBalance(IEntity subject, string balancePropertyName)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Setting the balance of votes to '" + balancePropertyName + "' property on type '" + subject.ShortTypeName + "'."))
			{
				PropertyInfo property = subject.GetType().GetProperty(balancePropertyName);
				
				if (property == null)
					throw new ArgumentException("Property '" + balancePropertyName + "' not found on type '" + subject.GetType().ToString());
				
				int balance = CountVotesStrategy.New().CountBalance(subject, balancePropertyName);
				
				LogWriter.Debug("Balance: " + balance);
				
				property.SetValue(subject, balance, null);
			}
		}
		
		public void SetTotal(IEntity subject, string totalPropertyName)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Setting the total number of votes to '" + totalPropertyName + "' property on type '" + subject.ShortTypeName + "'."))
			{
				PropertyInfo property = subject.GetType().GetProperty(totalPropertyName);
				
				if (property == null)
					throw new ArgumentException("Property '" + totalPropertyName + "' not found on type '" + subject.GetType().ToString());
				
				int total = CountVotesStrategy.New().CountTotal(subject, totalPropertyName);
				
				LogWriter.Debug("Total: " + total);
				
				property.SetValue(subject, total, null);
			}
		}
		
		static public VoteStrategy New()
		{
			return StrategyState.Strategies.Creator.New<VoteStrategy>("Create", "Vote");
		}
	}
}
