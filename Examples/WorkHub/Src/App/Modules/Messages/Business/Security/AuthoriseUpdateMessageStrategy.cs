using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Update", "Message")]
	public class AuthoriseUpdateMessageStrategy : AuthoriseUpdateStrategy
	{
		public AuthoriseUpdateMessageStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			if (!AuthenticationState.IsAuthenticated)
				return false;
			
			if (AuthenticationState.UserIsInRole("Administrator"))
				return true;
			
			Message message = (Message)entity;
			
			ActivateStrategy.New(message).Activate(message, "Sender");
			
			// The use can edit the message if they are the sender
			return message.Sender != null
				&& AuthenticationState.User != null
				&& message.Sender.ID == AuthenticationState.User.ID;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
	}
}
