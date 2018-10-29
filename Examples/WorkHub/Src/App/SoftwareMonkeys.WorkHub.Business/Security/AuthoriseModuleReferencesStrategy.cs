using System;

namespace SoftwareMonkeys.WorkHub.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseStrategy("References", "Module")]
	public class AuthoriseModuleReferencesStrategy : AuthoriseReferencesStrategy
	{
		public AuthoriseModuleReferencesStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			return AuthenticationState.UserIsInRole("Administrator");
		}
		
		public override bool IsAuthorised(string typeName)
		{
			return AuthenticationState.UserIsInRole("Administrator");
		}
	}
}
