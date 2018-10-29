using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Count", "Vote")]
	public class CountVotesStrategy : BaseStrategy
	{
		public CountVotesStrategy()
		{
		}
		
		/// <summary>
		/// Counts the votes and calculates the balance. (balance=positive-negative)
		/// </summary>
		/// <param name="subject"></param>
		/// <returns></returns>
		public int CountBalance(IEntity subject, string balancePropertyName)
		{
			return CountBalance(subject.ShortTypeName, subject.ID, balancePropertyName);
		}
		
		/// <summary>
		/// Counts the votes and calculates the balance. (balance=positive-negative)
		/// </summary>
		/// <param name="subjectTypeName"></param>
		/// <param name="subjectID"></param>
		/// <param name="balancePropertyName"></param>
		/// <returns></returns>
		public int CountBalance(string subjectTypeName, Guid subjectID, string balancePropertyName)
		{
			if (subjectTypeName == null || subjectTypeName == String.Empty)
				throw new ArgumentException("A subjectTypeName parameter must be provided.");
			
			if (!EntityState.IsType(subjectTypeName))
				throw new ArgumentException("No entity found '" + subjectTypeName + "'.", "subjectTypeName");
			
			Type subjectType = EntityState.GetType(subjectTypeName);
			
			FilterGroup group = DataAccess.Data.CreateFilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			ReferenceFilter subjectFilter = DataAccess.Data.CreateReferenceFilter();
			subjectFilter.Operator = FilterOperator.Equal;
			subjectFilter.PropertyName = "Subject";
			subjectFilter.ReferenceType = subjectType;
			subjectFilter.ReferencedEntityID = subjectID;
			subjectFilter.AddType(typeof(Vote));
			
			LogWriter.Debug("Subject type: " + subjectTypeName);
			LogWriter.Debug("Subject ID: " + subjectID.ToString());
			
			group.Add(subjectFilter);
			
			PropertyFilter balancePropertyFilter = DataAccess.Data.CreatePropertyFilter();
			balancePropertyFilter.Operator = FilterOperator.Equal;
			balancePropertyFilter.PropertyName = "BalanceProperty";
			balancePropertyFilter.PropertyValue = balancePropertyName;
			balancePropertyFilter.AddType(typeof(Vote));
			
			group.Add(balancePropertyFilter);
			
			Vote[] votes = Collection<Vote>.ConvertAll(DataAccess.Data.Indexer.GetEntities(group));
			
			int i = 0;
			
			foreach (Vote vote in votes)
			{
				if (vote.IsFor)
					i++;
				else
					i--;
			}
			
			return i;
		}
		
		/// <summary>
		/// Counts the total number of votes.
		/// </summary>
		/// <param name="subject"></param>
		/// <returns></returns>
		public int CountTotal(IEntity subject, string totalPropertyName)
		{
			return CountTotal(subject.ShortTypeName, subject.ID, totalPropertyName);
		}
		
		/// <summary>
		/// Counts the total number of votes.
		/// </summary>
		/// <param name="subjectTypeName"></param>
		/// <param name="subjectID"></param>
		/// <returns></returns>
		public int CountTotal(string subjectTypeName, Guid subjectID, string totalPropertyName)
		{
			if (subjectTypeName == null || subjectTypeName == String.Empty)
				throw new ArgumentException("A subjectTypeName parameter must be provided.");
			
			if (!EntityState.IsType(subjectTypeName))
				throw new ArgumentException("No entity found '" + subjectTypeName + "'.", "subjectTypeName");
			
			Type subjectType = EntityState.GetType(subjectTypeName);
			
			FilterGroup group = DataAccess.Data.CreateFilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			ReferenceFilter subjectFilter = DataAccess.Data.CreateReferenceFilter();
			subjectFilter.Operator = FilterOperator.Equal;
			subjectFilter.PropertyName = "Subject";
			subjectFilter.ReferenceType = subjectType;
			subjectFilter.ReferencedEntityID = subjectID;
			subjectFilter.AddType(typeof(Vote));
			
			LogWriter.Debug("Subject type: " + subjectTypeName);
			LogWriter.Debug("Subject ID: " + subjectID.ToString());
			
			group.Add(subjectFilter);
			
			PropertyFilter totalPropertyFilter = DataAccess.Data.CreatePropertyFilter();
			totalPropertyFilter.Operator = FilterOperator.Equal;
			totalPropertyFilter.PropertyName = "TotalProperty";
			totalPropertyFilter.PropertyValue = totalPropertyName;
			totalPropertyFilter.AddType(typeof(Vote));
			
			group.Add(totalPropertyFilter);
			
			int total = DataAccess.Data.Counter.CountEntities(group);
			
			return total;
		}
		
		public int CountTotal(Type subjectType, Guid subjectID, string balanceProperty, string totalProperty, bool isFor)
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
				
				PropertyFilter isForPropertyFilter = DataAccess.Data.CreatePropertyFilter();
				isForPropertyFilter.Operator = FilterOperator.Equal;
				isForPropertyFilter.PropertyName = "IsFor";
				isForPropertyFilter.PropertyValue = isFor;
				isForPropertyFilter.AddType(typeof(Vote));
				
				group.Add(isForPropertyFilter);
				
				total = DataAccess.Data.Counter.CountEntities(group);
				
				LogWriter.Debug("Total: " + total.ToString());
			}
			return total;
		}
		
		public static CountVotesStrategy New()
		{
			return new CountVotesStrategy();
		}
	}
}
