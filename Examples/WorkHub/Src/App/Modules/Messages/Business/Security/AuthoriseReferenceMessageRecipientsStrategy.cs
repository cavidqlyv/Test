using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseReferenceStrategy("Message", "Recipients", "User")]
	public class AuthoriseReferenceMessageRecipientsStrategy : AuthoriseReferenceStrategy
	{
		public AuthoriseReferenceMessageRecipientsStrategy()
		{
		}
		
		public override bool IsAuthorised(string typeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			return AuthenticationState.IsAuthenticated;
		}
	}
}
