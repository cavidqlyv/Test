using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the deletion of a project item.
	/// </summary>
	[AuthoriseStrategy("Delete", "IProjectItem")]
	public class AuthoriseDeleteProjectItemStrategy : AuthoriseDeleteAuthoredEntityStrategy
	{
		public AuthoriseDeleteProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is authorised to save the provided project item.", NLog.LogLevel.Debug))
			{
				IProjectItem item = (IProjectItem)entity;
				
				if (UserIsAdministrator())
					isAuthorised = true;
				
				if (UserIsAuthor((IAuthored)entity))
					isAuthorised = true;
				
				if (UserIsInvolved((Project)item.Project))
					isAuthorised = true;
				
				LogWriter.Debug("Is authorised: " + isAuthorised.ToString());
			}
			return isAuthorised;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
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
		
		private bool UserIsInvolved(Project project)
		{
			bool isInvolved = false;
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the current user is involved in the project."))
			{
				if (!AuthenticationState.IsAuthenticated)
					isInvolved = false;
				else
				{
					ActivateStrategy.New<Project>().Activate(project, "Managers");
					ActivateStrategy.New<Project>().Activate(project, "Contributors");
					
					isInvolved = AuthenticationState.User != null
						&& (project.HasManager(AuthenticationState.User.ID)
						    || project.HasContributor(AuthenticationState.User.ID));
				}
			}
			
			return isInvolved;
		}
	}
}
