/*
 * Created by SharpDevelop.
 * User: J
 * Date: 3/12/2011
 * Time: 8:27 AM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business
{
	/// <summary>
	/// Description of CheckVoteStrategy.
	/// </summary>
	public class CheckVoteStrategy
	{
		public CheckVoteStrategy()
		{
		}
		
		/// <summary>
		/// Checks the current user has already made a vote equivalent to the details provided.
		/// </summary>
		/// <param name="subjectType"></param>
		/// <param name="subjectID"></param>
		/// <param name="balanceProperty"></param>
		/// <param name="totalProperty"></param>
		/// <param name="isFor"></param>
		/// <returns></returns>
		public bool UserHasVoted(Type subjectType, Guid subjectID, string balanceProperty, string totalProperty, bool isFor)
		{
			
			bool hasVoted = false;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the current user has already voted."))
			{
				hasVoted = VoteExists(subjectType, subjectID, balanceProperty,  totalProperty, isFor);
				
				LogWriter.Debug("Has voted: " + hasVoted);
			}
			return hasVoted;
		}
		
		/// <summary>
		/// Checks whether a vote exists with the provided details.
		/// </summary>
		/// <param name="subjectType"></param>
		/// <param name="subjectID"></param>
		/// <param name="balanceProperty"></param>
		/// <param name="totalProperty"></param>
		/// <param name="isFor"></param>
		/// <returns></returns>
		public bool VoteExists(Type subjectType, Guid subjectID, string balanceProperty, string totalProperty, bool isFor)
		{
			return VoteExists(AuthenticationState.User,
			                  subjectType,
			                  subjectID,
			                  balanceProperty,
			                  totalProperty,
			                  isFor);
		}
		
		/// <summary>
		/// Checks whether a vote exists with the provided details.
		/// </summary>
		/// <param name="voter"></param>
		/// <param name="subjectType"></param>
		/// <param name="subjectID"></param>
		/// <param name="balanceProperty"></param>
		/// <param name="totalProperty"></param>
		/// <param name="isFor"></param>
		/// <returns></returns>
		public bool VoteExists(User voter, Type subjectType, Guid subjectID, string balanceProperty, string totalProperty, bool isFor)
		{
			int total = 0;
			using (LogGroup logGroup = LogGroup.StartDebug("Retrieving the existing vote (if any)."))
			{
				FilterGroup group = DataAccess.Data.CreateFilterGroup();
				group.Operator = FilterGroupOperator.And;
				
				ReferenceFilter subjectFilter = DataAccess.Data.CreateReferenceFilter();
				subjectFilter.Operator = FilterOperator.Equal;
				subjectFilter.PropertyName = "Subject";
				subjectFilter.ReferenceType = subjectType;
				subjectFilter.ReferencedEntityID = subjectID;
				subjectFilter.AddType(typeof(Vote));
				
				LogWriter.Debug("Subject type: " + subjectType.FullName);
				LogWriter.Debug("Subject ID: " + subjectID.ToString());
				
				group.Add(subjectFilter);
				
				ReferenceFilter voterFilter = DataAccess.Data.CreateReferenceFilter();
				voterFilter.Operator = FilterOperator.Equal;
				voterFilter.PropertyName = "Voter";
				voterFilter.ReferenceType = typeof(User);
				voterFilter.ReferencedEntityID = voter.ID;
				voterFilter.AddType(typeof(Vote));
				
				LogWriter.Debug("Voter ID: " + voter.ID.ToString());
				
				group.Add(voterFilter);
				
				PropertyFilter balancePropertyFilter = DataAccess.Data.CreatePropertyFilter();
				balancePropertyFilter.Operator = FilterOperator.Equal;
				balancePropertyFilter.PropertyName = "BalanceProperty";
				balancePropertyFilter.PropertyValue = balanceProperty;
				balancePropertyFilter.AddType(typeof(Vote));
				
				group.Add(balancePropertyFilter);
				
				PropertyFilter totalPropertyFilter = DataAccess.Data.CreatePropertyFilter();
				totalPropertyFilter.Operator = FilterOperator.Equal;
				totalPropertyFilter.PropertyName = "TotalProperty";
				totalPropertyFilter.PropertyValue = totalProperty;
				totalPropertyFilter.AddType(typeof(Vote));
				
				group.Add(totalPropertyFilter);
				
				PropertyFilter isForPropertyFilter = DataAccess.Data.CreatePropertyFilter();
				isForPropertyFilter.Operator = FilterOperator.Equal;
				isForPropertyFilter.PropertyName = "IsFor";
				isForPropertyFilter.PropertyValue = isFor;
				isForPropertyFilter.AddType(typeof(Vote));
				
				group.Add(isForPropertyFilter);
				
				total = DataAccess.Data.Counter.CountEntities(group);
				
				LogWriter.Debug("Total: " + total.ToString());
			}
			return total > 0;
		}
		
		/// <summary>
		/// Checks whether the current user has already made a vote equivalent to the details provided.
		/// </summary>
		/// <param name="subject"></param>
		/// <param name="balanceProperty"></param>
		/// <param name="totalProperty"></param>
		/// <param name="isFor"></param>
		/// <returns></returns>
		public bool UserHasVoted(IEntity subject, string balanceProperty, string totalProperty, bool isFor)
		{			
			return UserHasVoted(subject.GetType(), subject.ID, balanceProperty, totalProperty, isFor);
		}
		
		/// <summary>
		/// Checks whether the current user has already made a vote equivalent to the one provided.
		/// </summary>
		/// <param name="pendingVote"></param>
		/// <returns></returns>
		public bool UserHasVoted(Vote pendingVote)
		{
			return VoteExists(pendingVote.Voter, pendingVote.Subject.GetType(), pendingVote.Subject.ID, pendingVote.BalanceProperty, pendingVote.TotalProperty, pendingVote.IsFor);
		}
		
		static public CheckVoteStrategy New()
		{
			return new CheckVoteStrategy();
		}
	}
}
