using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.State;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Reaction("Create", "IProjectItem")]
	public class CreateProjectItemReaction : BaseCreateReaction
	{
		public CreateProjectItemReaction()
		{
		}
		
		public override void React(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			IProjectItem item = (IProjectItem)entity;
			
			item.Project = ProjectsState.Project;
			
			base.React(entity);
		}
	}
}
