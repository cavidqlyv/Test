using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Notify", "Bug")]
	public class BugNotificationStrategy : NotifyStrategy
	{
		public BugNotificationStrategy()
		{
		}
		
		
		/// <summary>
		/// Sends the provided notification message to all notifiable users.
		/// </summary>
		/// <param name="bug">The entity involved in the event that users are being notified about.</param>
		/// <param name="subject">The subject of the email to send to all notifiable users.</param>
		/// <param name="message">The message of the email to send to all notifiable users.</param>
		public void SendNotification(Bug bug, string subject, string message)
		{
			if (bug.Reporter == null)
				ActivateStrategy.New<Bug>().Activate(bug, "Reporter");
			
			base.SendNotification(bug, subject, message);
		}
		
		protected override string PrepareNotificationText(string original, IEntity entity)
		{
			Bug bug = (Bug)entity;
			
			string text = original;
			
			text = text.Replace("${Application.Title}", Configuration.Config.Application.Title);
			
			text = text.Replace("${Bug.Title}", bug.Title);
			text = text.Replace("${Bug.Description}", bug.Description);
			text = text.Replace("${Bug.Priority}", bug.Priority.ToString());
			//text = text.Replace("${Bug.ReporterName}", bug.ReporterName);
			//text = text.Replace("${Bug.ReporterEmail}", bug.ReporterEmail);
			//text = text.Replace("${Bug.ReporterPhone}", bug.ReporterPhone);
			//text = text.Replace("${Bug.NeedsReply}", bug.NeedsReply.ToString());
			//text = text.Replace("${Bug.HowToRecreate}", bug.HowToRecreate);
			
			//  Activate the project property if necessary
			if (bug.Project == null)
				ActivateStrategy.New<Bug>().Activate(bug, "Project");
			
			// Insert the project name
			text = text.Replace("${Bug.Project.Name}", EntitiesUtilities.GetPropertyValue(bug.Project, "Name").ToString());
			
			return text;
		}
		
		
		static public BugNotificationStrategy New()
		{
			return new BugNotificationStrategy();
		}
	}
}
