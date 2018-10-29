using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[AuthoriseReferenceStrategy("Project", "Managers", "User")]
	public class AuthoriseReferenceProjectManagersStrategy : AuthoriseReferenceStrategy
	{
		public AuthoriseReferenceProjectManagersStrategy()
		{
		}
		
		public override bool IsAuthorised(string typeName)
		{			
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(IEntity entity)
		{
			bool isAuthorised = false;

			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the current user is authorised to create references on the provided property."))
			{				
				if (AuthenticationState.IsAuthenticated)
				{
					LogWriter.Debug("Current user is authenticated.");
					
					IProject project = (IProject)SourceEntity;
					
					// If the current user is the manager of the project
					if (project.HasManager(AuthenticationState.User.ID))
					{
						LogWriter.Debug("Current user is a manager of the project. Therefore is authorised.");
						
					  	isAuthorised = true;
					}
					else
						LogWriter.Debug("Current user is NOT a manager of the project. Therefore is NOT authorised.");
				}
				else
					LogWriter.Debug("Not authenticated. Therefore not authorised.");
				
				LogWriter.Debug("Is authorised: " + isAuthorised.ToString());
			}
			
			return isAuthorised;
		}
	}
}
