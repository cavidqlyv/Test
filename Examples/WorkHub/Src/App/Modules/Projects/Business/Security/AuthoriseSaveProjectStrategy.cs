using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the saving of a project.
	/// </summary>
	[AuthoriseStrategy("Save", "Project")]
	public class AuthoriseSaveProjectStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveProjectStrategy()
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
