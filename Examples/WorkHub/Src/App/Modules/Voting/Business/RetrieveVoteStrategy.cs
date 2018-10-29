using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business
{
	/// <summary>
	/// Description of RetrieveVoteStrategy.
	/// </summary>
	[Strategy("Retrieve", "Vote")]
	public class RetrieveVoteStrategy : RetrieveStrategy
	{
		public RetrieveVoteStrategy()
		{
			TypeName = "Vote";
		}
		
		/// <summary>
		/// Retrieves an existing vote (if found) for the provided subject, by the user currently signed in.
		/// </summary>
		/// <param name="subject"></param>
		/// <param name="balanceProperty"></param>
		/// <param name="totalProperty"></param>
		/// <returns></returns>
		public Vote RetrieveExisting(IEntity subject, string balanceProperty, string totalProperty)
		{
			Vote vote = null;
			using (LogGroup logGroup = LogGroup.StartDebug("Retrieving the existing vote (if any)."))
			{
				FilterGroup group = DataAccess.Data.CreateFilterGroup();
				group.Operator = FilterGroupOperator.And;
				
				ReferenceFilter subjectFilter = DataAccess.Data.CreateReferenceFilter();
				subjectFilter.Operator = FilterOperator.Equal;
				subjectFilter.PropertyName = "Subject";
				subjectFilter.ReferenceType = subject.GetType();
				subjectFilter.ReferencedEntityID = subject.ID;
				subjectFilter.AddType(typeof(Vote));
				
				LogWriter.Debug("Subject type: " + subject.GetType().ToString());
				LogWriter.Debug("Subject ID: " + subject.ID.ToString());
				
				group.Add(subjectFilter);
				
				ReferenceFilter voterFilter = DataAccess.Data.CreateReferenceFilter();
				voterFilter.Operator = FilterOperator.Equal;
				voterFilter.PropertyName = "Voter";
				voterFilter.ReferenceType = typeof(User);
				voterFilter.ReferencedEntityID = AuthenticationState.User.ID;
				voterFilter.AddType(typeof(Vote));
				
				LogWriter.Debug("Voter ID: " + AuthenticationState.User.ID.ToString());
				
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
				
				vote = Retrieve<Vote>(group);
				
				LogWriter.Debug("Vote found: " + (vote != null).ToString());
			}
			return vote;
		}
		
		public static RetrieveVoteStrategy New()
		{
			return new RetrieveVoteStrategy();
		}
	}
}
