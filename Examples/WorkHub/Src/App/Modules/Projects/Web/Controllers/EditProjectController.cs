using System;
using SoftwareMonkeys.WorkHub.Modules.Projects.Web.State;
using SoftwareMonkeys.WorkHub.Modules.Projects.Web.Validation;
using SoftwareMonkeys.WorkHub.Web.Controllers;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.Controllers
{
	/// <summary>
	/// 
	/// </summary>
	[Controller("Edit", "Project")]
	public class EditProjectController : EditController
	{
		public EditProjectController()
		{
			Validation = new ProjectValidation();
		}
		
		public override bool ExecuteUpdate(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			ProjectsState.ProjectID = entity.ID;
			
			bool success = base.ExecuteUpdate(entity);
				
			return success;
		}
	}
}
