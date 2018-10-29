using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Projects.Web.Validation;
using SoftwareMonkeys.WorkHub.Web.Navigation;
using SoftwareMonkeys.WorkHub.Web.Security;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;
using SoftwareMonkeys.WorkHub.Web.State;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.Controllers
{
	/// <summary>
	/// 
	/// </summary>
	[Controller("Create", "Project")]
	public class CreateProjectController : CreateController
	{
		public CreateProjectController()
		{
			Validation = new ProjectValidation();
		}
		
		public override bool ExecuteSave(IEntity entity)
		{
			bool success = false;
			using (LogGroup logGroup = LogGroup.Start("Executing the save of the provided entity.", NLog.LogLevel.Debug))
			{
				if (entity is Project)
				{
					success = ExecuteSave((Project)entity);
				}
				else
					throw new ArgumentException("The provided entity type '" + entity.GetType().FullName + "' is not supported. The entity must be of type 'Project'.");
			}
			
			return success;
		}
		
		public bool ExecuteSave(Project project)
		{
			bool success = false;
			
			using (LogGroup logGroup = LogGroup.Start("Executing the save of the provided project.", NLog.LogLevel.Debug))
			{
				//if (project.IsValid)
				//{
					success = base.ExecuteSave(project);
					
					if (success)
						ProjectsState.ProjectID = project.ID;
				//}
				//else
				//	Validation.DisplayError(project);
			}
			return success;
		}
	}
}
