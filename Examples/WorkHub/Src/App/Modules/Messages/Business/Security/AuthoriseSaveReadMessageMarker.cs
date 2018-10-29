using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Save", "ReadMessageMarker")]
	public class AuthoriseSaveReadMessageMarker : AuthoriseSaveStrategy
	{
		public AuthoriseSaveReadMessageMarker()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
	}
}
