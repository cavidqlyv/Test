using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.State;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Reaction("Create", "IMultiProjectItem")]
	public class CreateMultiProjectItemReaction : BaseCreateReaction
	{
		public CreateMultiProjectItemReaction()
		{
		}
		
		public override void React(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			IMultiProjectItem item = (IMultiProjectItem)entity;
			
			item.Projects = new IProject[] {ProjectsState.Project};
			//item.Author = AuthenticationState.User;
			
			base.React(entity);
		}
	}
}
