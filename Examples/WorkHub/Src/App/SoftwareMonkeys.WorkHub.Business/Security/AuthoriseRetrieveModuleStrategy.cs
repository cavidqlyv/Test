using System;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Business.Security
{
	[Strategy("AuthoriseRetrieve", "IModuleContext")]
	[Strategy("AuthoriseRetrieve", "Module")]
	public class AuthoriseRetrieveModuleStrategy : AuthoriseRetrieveStrategy
	{
		public AuthoriseRetrieveModuleStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			return AuthenticationState.UserIsInRole("Administrator");
		
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.UserIsInRole("Administrator");
		}
	}
}
