using System;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business
{
	/// <summary>
	///
	/// </summary>
	[Strategy("Index", "Message")]
	public class IndexMessageStrategy : IndexStrategy
	{
		public IndexMessageStrategy()
		{
		}
		
		public Message[] IndexInbox()
		{
			if (!AuthenticationState.IsAuthenticated)
				return new Message[]{};
			else
			{
				IDataFilterGroup group = DataAccess.Data.CreateFilterGroup();
				group.Operator = FilterGroupOperator.And;
				
				ReferenceFilter recipientFilter = DataAccess.Data.CreateReferenceFilter();
				recipientFilter.AddType(typeof(Message));
				recipientFilter.PropertyName = "Recipients";
				recipientFilter.ReferenceType = typeof(User);
				recipientFilter.ReferencedEntityID = AuthenticationState.User.ID;
				
				group.Add(recipientFilter);
				
				return base.Index<Message>(group);
			}
		}
		
		public Message[] IndexSent()
		{
			if (!AuthenticationState.IsAuthenticated)
				return new Message[]{};
			else
			{
				// TODO: Add paging
				IDataFilterGroup group = DataAccess.Data.CreateFilterGroup();
				group.Operator = FilterGroupOperator.And;
				
				ReferenceFilter senderFilter = DataAccess.Data.CreateReferenceFilter();
				senderFilter.AddType(typeof(Message));
				senderFilter.PropertyName = "Sender";
				senderFilter.ReferenceType = typeof(User);
				senderFilter.ReferencedEntityID = AuthenticationState.User.ID;
				
				group.Add(senderFilter);
				
				return base.Index<Message>(group);
			}
		}
		
		
		public Message[] IndexDiscussions()
		{
			// TODO: Add a filter for current project
			
			Dictionary<string, object> parameters = new Dictionary<string, object>();
			parameters["IsPublic"] = true;
			
			return base.Index<Message>(parameters);
		}
		
		static public IndexMessageStrategy New()
		{
			return new IndexMessageStrategy();
		}
		
		static public IndexMessageStrategy New(PagingLocation location)
		{
			IndexMessageStrategy strategy = new IndexMessageStrategy();
			strategy.Location = location;
			return strategy;
		}
	}
}
