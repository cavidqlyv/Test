using System;
using SoftwareMonkeys.WorkHub.Web.Controllers;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.Controllers
{
	/// <summary>
	/// Description of IndexActivePublicProjectsController.
	/// </summary>
	[Controller("IndexActivePublic", "Project")]
	public class IndexActivePublicProjectsController : IndexController
	{
		public IndexActivePublicProjectsController()
		{
		}
		
		public override SoftwareMonkeys.WorkHub.Entities.IEntity[] PrepareIndex()
		{
			return base.PrepareIndex();
		}
		
		protected override void ExecuteIndex(SoftwareMonkeys.WorkHub.Entities.IEntity[] entities)
		{
			base.ExecuteIndex(entities);
		}
	}
}
