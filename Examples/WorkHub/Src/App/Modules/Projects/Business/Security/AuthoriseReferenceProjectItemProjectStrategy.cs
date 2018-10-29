using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Authorises reference between a project item and associated project.
	/// </summary>
	[AuthoriseReferenceStrategy("IProjectItem", "*", "IProject", "")]
	public class AuthoriseReferenceProjectItemProjectStrategy : BaseAuthoriseReferenceStrategy
	{
		public AuthoriseReferenceProjectItemProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return AuthenticationState.IsAuthenticated;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			IProjectItem projectItem = (IProjectItem)SourceEntity;
			
			IProject project = (IProject)entity;
			
			// If the current user is a contributor or manager of the project
			if (project.HasContributor(AuthenticationState.User.ID)
			    || project.HasManager(AuthenticationState.User.ID))
				return true;
			else
				return false;
		}
	}
}
