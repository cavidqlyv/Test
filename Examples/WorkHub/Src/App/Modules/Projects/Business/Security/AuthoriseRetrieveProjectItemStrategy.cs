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
	[AuthoriseStrategy("Retrieve", "IProjectItem")]
	public class AuthoriseRetrieveProjectItemStrategy : AuthoriseRetrieveStrategy
	{
		public AuthoriseRetrieveProjectItemStrategy()
		{
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			IProjectItem item = (IProjectItem)entity;
			
			if (item.Project == null)
				ActivateStrategy.New(entity.ShortTypeName).Activate(item, "Project");
			
			if (item.Project == null)
			{
				// TODO: SECURITY: Check if this is adequate
				return IsAuthorised(item.ShortTypeName);
			}
			else
			{
				// Use the authorise retrieve project strategy, as the item is dependent upon the project
				IAuthoriseStrategy strategy = AuthoriseRetrieveStrategy.New(item.Project);
				
				return strategy.IsAuthorised(item.Project);
			}
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			return true;
		}
		
	}
}
