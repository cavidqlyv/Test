using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Ideas.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseReferenceStrategy("Idea", "*", "Idea", "*")]
	public class AuthoriseReferenceIdeaToIdeasStrategy : BaseAuthoriseReferenceStrategy
	{
		public AuthoriseReferenceIdeaToIdeasStrategy()
		{}
		
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
