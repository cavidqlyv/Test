using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the save of a project item.
	/// </summary>
	[AuthoriseStrategy("Save", "IProjectItem")]
	public class AuthoriseSaveProjectItemStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is authorised to update the provided project item.", NLog.LogLevel.Debug))
			{
				IProjectItem item = (IProjectItem)entity;
				
				if (UserIsAdministrator())
				{
					LogWriter.Debug("User is administrator, therefore authorised.");
					
					isAuthorised = true;
				}
				
				Project project = (Project)item.Project;
				
				// If a project is assigned
				if (project != null)
				{
					LogWriter.Debug("A project is assigned.");
					
					// The user is authorised if they are involved in the project
					if (UserIsInvolved(project))
					{
						LogWriter.Debug("User is involved in the project, therefore authorised.");
						isAuthorised = true;
					}
				}
				// Otherwise the user is authorised to create an unassigned item
				else
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
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is involved in the project.", NLog.LogLevel.Debug))
			{
				if (project == null)
					throw new ArgumentNullException("project");
				
				if (!AuthenticationState.IsAuthenticated || AuthenticationState.User == null)
					isInvolved = false;
				else
				{
					ActivateStrategy.New<Project>().Activate(project, "Managers");
					ActivateStrategy.New<Project>().Activate(project, "Contributors");
					
					isInvolved = project.HasManager(AuthenticationState.User.ID)
						|| project.HasContributor(AuthenticationState.User.ID);
				}
			}
			
			return isInvolved;
		}
	}
}
