using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the update of a project.
	/// </summary>
	[AuthoriseStrategy("Update", "Project")]
	public class AuthoriseUpdateProjectStrategy : AuthoriseUpdateAuthoredEntityStrategy
	{
		public AuthoriseUpdateProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is authorised to update the provided project.", NLog.LogLevel.Debug))
			{
				Project project = (Project)entity;
				
				if (UserIsAdministrator())
				{
					LogWriter.Debug("User is administrator.");
					isAuthorised = true;
				}
				
				if (UserIsAuthor((IAuthored)project))
				{
					LogWriter.Debug("User is author.");
					isAuthorised = true;
				}
				
				if (UserIsManager(project))
				{
					LogWriter.Debug("User is manager.");
					isAuthorised = true;
				}
				
				LogWriter.Debug("Is authorised: " + isAuthorised.ToString());
			}
			return isAuthorised;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			bool isAuthorised = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is authorised to update entities of the type '" + shortTypeName + "'.",NLog.LogLevel.Debug))
			{
				isAuthorised = true;
				
				LogWriter.Debug("Is authorised: " + isAuthorised.ToString());
			}
			return isAuthorised;
		}
		
		
		private bool UserIsAdministrator()
		{
			bool isAdministrator = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is an administrator.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Username: " + AuthenticationState.Username);
				
				LogWriter.Debug("Is authenticated: " + AuthenticationState.IsAuthenticated);
				
				isAdministrator = AuthenticationState.IsAuthenticated && AuthenticationState.UserIsInRole("Administrator");
				
				LogWriter.Debug("Is administrator: " + isAdministrator);
			}
			return isAdministrator;
		}
		
		private bool UserIsManager(Project project)
		{
			bool isManager = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is a manager of the project.", NLog.LogLevel.Debug))
			{
				if (!AuthenticationState.IsAuthenticated)
					isManager = false;
				else
				{
					ActivateStrategy.New<Project>().Activate(project, "Managers");
					
					isManager = project.HasManager(AuthenticationState.User.ID);
				}
			}
			
			return isManager;
		}
	}
}
