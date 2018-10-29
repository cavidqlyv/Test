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
	[Strategy("Notify", "Issue")]
	public class IssueNotificationStrategy : NotifyStrategy
	{
		public IssueNotificationStrategy()
		{
		}
		
		protected override string PrepareNotificationText(string original, IEntity entity)
		{
			return PrepareNotificationText(original, (Issue)entity);
		}
		
		protected string PrepareNotificationText(string original, Issue issue)
		{
			string text = original;
			
			text = text.Replace("${Application.Title}", Configuration.Config.Application.Title);
			
			text = text.Replace("${Issue.Subject}", issue.Subject);
			text = text.Replace("${Issue.Description}", issue.Description);
			text = text.Replace("${Issue.Status}", issue.Status.ToString());
			text = text.Replace("${Issue.ReporterName}", issue.ReporterName);
			text = text.Replace("${Issue.ReporterEmail}", issue.ReporterEmail);
			text = text.Replace("${Issue.ReporterPhone}", issue.ReporterPhone);
			text = text.Replace("${Issue.NeedsReply}", issue.NeedsReply.ToString());
			text = text.Replace("${Issue.HowToRecreate}", issue.HowToRecreate);
			
			//  Activate the project property if necessary
			if (issue.Project == null)
				ActivateStrategy.New<Issue>().Activate(issue, "Project");
			
			// Insert the project name
			text = text.Replace("${Issue.Project.Name}", EntitiesUtilities.GetPropertyValue(issue.Project, "Name").ToString());
			
			return text;
		}
		
		
		static public IssueNotificationStrategy New()
		{
			return new IssueNotificationStrategy();
		}
	}
}
