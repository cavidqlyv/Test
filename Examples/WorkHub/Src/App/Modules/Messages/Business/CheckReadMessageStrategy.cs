using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business
{
	/// <summary>
	/// Check whether a user has read a particular message.
	/// </summary>
	public class CheckReadMessageStrategy : BaseStrategy
	{
		public CheckReadMessageStrategy()
		{
		}
		
		/// <summary>
		/// Checks whether the currently authenticated user has read the provided message.
		/// </summary>
		/// <param name="message"></param>
		/// <returns></returns>
		public bool IsRead(Message message)
		{
			// If the user isn't signed in then treat all messages as unread
			if (!AuthenticationState.IsAuthenticated)
				return false;
			
			IDataFilterGroup group = DataAccess.Data.CreateFilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			ReferenceFilter messageFilter = DataAccess.Data.CreateReferenceFilter();
			messageFilter.AddType(typeof(ReadMessageMarker));
			messageFilter.PropertyName = "Message";
			messageFilter.ReferenceType = typeof(Message);
			messageFilter.ReferencedEntityID = message.ID;
			group.Add(messageFilter);
			
			ReferenceFilter userFilter = DataAccess.Data.CreateReferenceFilter();
			userFilter.AddType(typeof(ReadMessageMarker));
			userFilter.PropertyName = "User";
			userFilter.ReferenceType = typeof(User);
			userFilter.ReferencedEntityID = AuthenticationState.User.ID;
			group.Add(userFilter);
			
			return DataAccess.Data.Counter.CountEntities(group) > 0;
		}
		
		public ReadMessageMarker GetExistingMarker(Message message)
		{
			if (RequireAuthorisation)
				AuthoriseRetrieveStrategy.New<ReadMessageMarker>().EnsureAuthorised(typeof(ReadMessageMarker).Name);
			
			FilterGroup group = DataAccess.Data.CreateFilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			ReferenceFilter messageFilter = DataAccess.Data.CreateReferenceFilter();
			messageFilter.AddType(typeof(ReadMessageMarker));
			messageFilter.PropertyName = "Message";
			messageFilter.ReferenceType = typeof(Message);
			messageFilter.ReferencedEntityID = message.ID;
			group.Add(messageFilter);
			
			ReferenceFilter userFilter = DataAccess.Data.CreateReferenceFilter();
			userFilter.AddType(typeof(ReadMessageMarker));
			userFilter.PropertyName = "User";
			userFilter.ReferenceType = typeof(User);
			userFilter.ReferencedEntityID = AuthenticationState.User.ID;
			group.Add(userFilter);
			
			return (ReadMessageMarker)DataAccess.Data.Reader.GetEntity(group);
		}
		
		static public CheckReadMessageStrategy New()
		{
			return new CheckReadMessageStrategy();
		}
	}
}
