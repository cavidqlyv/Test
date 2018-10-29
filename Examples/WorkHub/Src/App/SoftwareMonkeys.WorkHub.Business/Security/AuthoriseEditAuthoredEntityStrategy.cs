using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("Edit", "IAuthored")]
	public class AuthoriseEditAuthoredEntityStrategy : BaseAuthoriseStrategy
	{
		public AuthoriseEditAuthoredEntityStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			IAuthored authoredEntity = (IAuthored)entity;
			
			if (authoredEntity.Author.ID == AuthenticationState.User.ID)
				return true;
			else
				return false;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
	}
}
