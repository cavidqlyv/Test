using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Business;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Web.Controllers;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Web.Controllers
{
	/// <summary>
	/// 
	/// </summary>
	[Controller("Index", "Message")]
	public class IndexMessageController : IndexController
	{
		public MessageIndexMode IndexMode = MessageIndexMode.Inbox;
		
		protected override SoftwareMonkeys.WorkHub.Entities.IEntity[] Load()
		{
			Message[] messages = new Message[]{};
			
			if (IndexMode == MessageIndexMode.Inbox)
				messages = IndexMessageStrategy.New().IndexInbox();
			else if (IndexMode == MessageIndexMode.Sent)
				messages = IndexMessageStrategy.New().IndexSent();
			else if (IndexMode == MessageIndexMode.Discussions)
				messages = IndexMessageStrategy.New().IndexDiscussions();
			
			return Collection<IEntity>.ConvertAll(messages);
		}
		
	}
}
