using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the retrieval of a project.
	/// </summary>
	[AuthoriseStrategy("Retrieve", "Project")]
	public class AuthoriseRetrieveProjectStrategy : AuthoriseRetrieveStrategy
	{
		public AuthoriseRetrieveProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			if (entity is Project)
			{
				Project project = (Project)entity;
				
				if (ProjectIsPublic(project))
					return true;
				
				if (UserIsAdministrator())
					return true;
				
				
				if (UserIsInvolved(project))
					return true;
				
				return false;
			}
			else
				throw new ArgumentException("Invalid type '" + entity.GetType().ToString() + "'. Expecting 'Project' type.");
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return true;
		}
		
		
		private bool UserIsAdministrator()
		{
			return AuthenticationState.IsAuthenticated && AuthenticationState.UserIsInRole("Administrator");
		}
		
		private bool ProjectIsPublic(Project project)
		{
			if (project == null)
				throw new ArgumentNullException("project");
			
			return project.Visibility == ProjectVisibility.Public;
		}
		
		private bool UserIsInvolved(Project project)
		{
			if (project == null)
				throw new ArgumentNullException("project");
			
			if (!AuthenticationState.IsAuthenticated || AuthenticationState.User == null)
				return false;
			
			ActivateStrategy.New<Project>().Activate(project, "Contributors");
			ActivateStrategy.New<Project>().Activate(project, "Managers");
			
			return project.HasContributor(AuthenticationState.User.ID)
				|| project.HasManager(AuthenticationState.User.ID);
		}
	}
}
