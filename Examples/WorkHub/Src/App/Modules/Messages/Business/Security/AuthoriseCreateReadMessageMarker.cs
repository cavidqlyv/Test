using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// Description of AuthoriseCreateReadMessageMarker.
	/// </summary>
	[AuthoriseStrategy("Create", "ReadMessageMarker")]
	public class AuthoriseCreateReadMessageMarker : AuthoriseCreateStrategy
	{
		public AuthoriseCreateReadMessageMarker()
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
