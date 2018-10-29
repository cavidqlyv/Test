using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the creation of a project.
	/// </summary>
	[AuthoriseStrategy("Create", "Project")]
	public class AuthoriseCreateProjectStrategy : AuthoriseCreateStrategy
	{
		public AuthoriseCreateProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			// Any authenticated user can create a project
			return AuthenticationState.IsAuthenticated;
			
			// TODO: Add a config setting to enable/disable project creation by new users
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// Any authenticated user can create a project
			return AuthenticationState.IsAuthenticated;
			
			// TODO: Add a config setting to enable/disable project creation by new users
		}
	}
}
