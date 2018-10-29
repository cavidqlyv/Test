using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Authorises reference between project items.
	/// </summary>
	[AuthoriseReferenceStrategy("IProjectItem", "*", "IProjectItem", "")]
	public class AuthoriseReferenceProjectItemToProjectItemsStrategy : BaseAuthoriseReferenceStrategy
	{
		public AuthoriseReferenceProjectItemToProjectItemsStrategy()
		{
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			IProjectItem projectItem = (IProjectItem)entity;
			
			IProject project = projectItem.Project;
			
			// If the current user is a contributor or manager of the project
			if (project.HasContributor(AuthenticationState.User.ID)
			    || project.HasManager(AuthenticationState.User.ID))
				return true;
			else
				return false;
		}
	}
}
