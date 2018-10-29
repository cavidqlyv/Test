using System;
using SoftwareMonkeys.WorkHub.Modules.Projects.Properties;
using SoftwareMonkeys.WorkHub.Web.Validation;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.Validation
{
	/// <summary>
	/// 
	/// </summary>
	public class ProjectValidation : ValidationFacade
	{
		public ProjectValidation()
		{
			AddError("Name", "Required", Language.ProjectNameRequired);
			AddError("Name", "Unique", Language.ProjectNameTaken);
		}
	}
}
