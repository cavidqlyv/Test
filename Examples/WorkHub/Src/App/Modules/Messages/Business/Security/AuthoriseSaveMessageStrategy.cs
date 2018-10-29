using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Save", "Message")]
	public class AuthoriseSaveMessageStrategy : AuthoriseSaveStrategy
	{
		public override bool IsAuthorised(string shortTypeName)
		{
			// Everyone can create messages
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			return AuthenticationState.IsAuthenticated;
		}
	}
}
