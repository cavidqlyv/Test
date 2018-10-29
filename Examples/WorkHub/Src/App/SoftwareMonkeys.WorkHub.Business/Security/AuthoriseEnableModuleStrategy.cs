using System;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Business.Security
{
	[Strategy("AuthoriseEnable", "Module")]
	[Strategy("AuthoriseEnable", "IModuleContext")]
	public class AuthoriseEnableModuleStrategy : BaseAuthoriseStrategy
	{
		public AuthoriseEnableModuleStrategy()
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
