using System;
using SoftwareMonkeys.WorkHub.Business.Security;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseReferenceStrategy("Message", "Projects", "Project")]
	public class AuthoriseReferenceMessageProjectsStrategy : AuthoriseReferenceStrategy
	{
		public AuthoriseReferenceMessageProjectsStrategy()
		{
		}
		
		public override bool IsAuthorised(string typeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			// Anyone who is authorised can comment on a project
			// TODO: See if the project managers should be able to adjust this security level
			return AuthenticationState.IsAuthenticated;
		}
		
	}
}
