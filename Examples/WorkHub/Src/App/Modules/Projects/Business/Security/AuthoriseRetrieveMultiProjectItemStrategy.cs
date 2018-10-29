using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business.Security
{
	/// <summary>
	/// Used to authorise the retrieval of a project item.
	/// </summary>
	[AuthoriseStrategy("Retrieve", "IMultiProjectItem")]
	public class AuthoriseRetrieveMultiProjectItemStrategy : AuthoriseRetrieveStrategy
	{
		public AuthoriseRetrieveMultiProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			IMultiProjectItem item = (IMultiProjectItem)entity;
			
			if (item.Projects == null)
				ActivateStrategy.New(entity).Activate(item, "Projects");
			
			bool isAuthorised = false;
			
			// If no projects are assigned then allow anyone to view the data
			if (item.Projects == null || item.Projects.Length == 0)
			{
				// TODO: SECURITY: Check if this is adequate
				isAuthorised = IsAuthorised(item.ShortTypeName);
			}
			// Otherwise if projects are assigned
			else
			{
				// Loop through the projects
				foreach (IProject project in item.Projects)
				{
					// Use the authorise retrieve project strategy, as the item is dependent upon the project
					IAuthoriseStrategy strategy = AuthoriseRetrieveStrategy.New(project);
					
					if (strategy.IsAuthorised(project))
						isAuthorised = true;
				}
			}
			
			return isAuthorised;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return true;
		}
		
	}
}
