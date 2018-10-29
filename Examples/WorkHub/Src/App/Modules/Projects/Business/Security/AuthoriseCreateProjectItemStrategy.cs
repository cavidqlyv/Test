using System;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the creation of a project item.
	/// </summary>
	[AuthoriseStrategy("Create", "IProjectItem")]
	public class AuthoriseCreateProjectItemStrategy : AuthoriseCreateStrategy
	{
		public AuthoriseCreateProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the current user is authorised to create the provided project item."))
			{
				isAuthorised = AuthoriseSaveStrategy.New(entity.ShortTypeName).IsAuthorised(entity);
			}
			return isAuthorised;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
	}
}
