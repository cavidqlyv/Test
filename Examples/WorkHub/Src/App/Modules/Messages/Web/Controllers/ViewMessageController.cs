using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Messages.Business;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Web.Controllers;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Web.Controllers
{
	/// <summary>
	/// 
	/// </summary>
	[Controller("View", "Message")]
	public class ViewMessageController : ViewController
	{
		public ViewMessageController()
		{
		}
		
		public override void View(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			MarkMessageAsReadStrategy.New().MarkAsRead((Message)entity);
			
			ActivateStrategy.New(entity).Activate(entity, "Subject");
			
			base.View(entity);
		}
	}
}
