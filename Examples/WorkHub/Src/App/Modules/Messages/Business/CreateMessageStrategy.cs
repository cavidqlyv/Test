using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Web.State;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Create", "Message")]
	public class CreateMessageStrategy : CreateStrategy
	{
		public CreateMessageStrategy()
		{
		}
		
		public override SoftwareMonkeys.WorkHub.Entities.IEntity Create()
		{
			Message message = new Message();
			message.ID = Guid.NewGuid();
			message.Sender = AuthenticationState.User;
			message.Projects = new IProject[] { ProjectsState.Project };
			message.Date = DateTime.Now;
			
			AssignActivator(message);
			
			AssignValidator(message);
			
			return message;
		}
	}
}
