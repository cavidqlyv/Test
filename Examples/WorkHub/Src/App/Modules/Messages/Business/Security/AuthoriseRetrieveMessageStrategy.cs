using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("AuthoriseRetrieve", "Message")]
	public class AuthoriseRetrieveMessageStrategy : AuthoriseRetrieveStrategy
	{
		public AuthoriseRetrieveMessageStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			if (entity is Message)
			{				
				Message message = (Message)entity;
				
				ActivateStrategy.New(message).Activate(message, "Recipients");
				ActivateStrategy.New(message).Activate(message, "Sender");
				
				bool isRecipient = AuthenticationState.IsAuthenticated
					&& message.Recipients != null
					&& AuthenticationState.User != null
					&& Array.IndexOf(Collection<User>.GetIDs(message.Recipients), AuthenticationState.User.ID) > -1;

				bool isSender = AuthenticationState.IsAuthenticated
					&& message.Sender != null
					&& message.Sender.ID == AuthenticationState.User.ID;
				
				bool isPublic = message.IsPublic;
				
				bool isAdministrator = AuthenticationState.UserIsInRole("Administrator");
				
				return isRecipient || isSender || isPublic || isAdministrator;
			}
			else
				throw new ArgumentException("Invalid type: " + entity.GetType().ToString(), "entity");
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// All users can access messages feature, even anonymous ones
			return true;
		}
	}
}
