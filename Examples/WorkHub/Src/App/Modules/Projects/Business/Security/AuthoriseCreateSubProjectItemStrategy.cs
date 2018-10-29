using System;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the creation of a sub project item.
	/// </summary>
	[AuthoriseStrategy("Create", "ISubProjectItem")]
	public class AuthoriseCreateSubProjectItemStrategy : AuthoriseCreateStrategy
	{
		public AuthoriseCreateSubProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the current user is authorised to create the provided project item."))
			{
				// As long as the user is authenticated they can create sub project items
				// More authorisation checks are made on save
				isAuthorised = AuthenticationState.IsAuthenticated;
			}
			return isAuthorised;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
	}
}
