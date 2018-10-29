using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the save of a multi project item.
	/// </summary>
	[AuthoriseStrategy("Save", "IMultiProjectItem")]
	public class AuthoriseSaveMultiProjectItemStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveMultiProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			bool isAuthorised = false;
			using (LogGroup logGroup = LogGroup.Start("Checking whether the current user is authorised to update the provided project item.", LogLevel.Debug))
			{
				IMultiProjectItem item = (IMultiProjectItem)entity;
				
				if (UserIsAdministrator())
				{
					LogWriter.Debug("User is administrator, therefore authorised.");
					
					isAuthorised = true;
				}
				
				// Authorise the association with the projects
				AuthoriseProjects(item);
				
				isAuthorised = true;
				
				LogWriter.Debug("Is authorised: " + isAuthorised.ToString());
			}
			return isAuthorised;
		}
		
		/// <summary>
		/// Checks that the user is authorised to create items for the assigned projects.
		/// </summary>
		/// <param name="item"></param>
		public virtual void AuthoriseProjects(IMultiProjectItem item)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Checking that the user is authorised to create items for the assigned projects."))
			{
				if (item.Projects != null && item.Projects.Length > 0)
				{
					LogWriter.Debug("Projects assigned: " + item.Projects.Length.ToString());
					
					Collection<Project> projects = new Collection<Project>(item.Projects);
					
					for (int i = 0; i < projects.Count; i++)
					{
						if (!AuthoriseUpdateStrategy.New<Project>().IsAuthorised(projects[i]))
						{
							LogWriter.Debug("Unauthorised project '" + projects[i].Name + "'. Removing from the list of references.");
							projects.RemoveAt(i);
							i--;
						}
					}
				}
			}
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
