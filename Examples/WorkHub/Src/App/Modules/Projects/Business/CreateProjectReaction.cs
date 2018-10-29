using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Reaction("Create", "Project")]
	public class CreateProjectReaction : BaseCreateReaction
	{
		public CreateProjectReaction()
		{
		}
		
		public override void React(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			Project project = (Project)entity;
			
			project.ID = Guid.NewGuid();
			project.CurrentVersion = "0.1";
			project.Managers = new User[]{AuthenticationState.User};
			
			base.React(entity);
		}
	}
}
