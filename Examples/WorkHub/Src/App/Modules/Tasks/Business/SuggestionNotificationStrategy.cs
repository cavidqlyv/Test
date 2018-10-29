using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Notify", "Suggestion")]
	public class SuggestionNotificationStrategy : NotifyStrategy
	{
		public SuggestionNotificationStrategy()
		{
		}
		
		protected override string PrepareNotificationText(string original, IEntity entity)
		{
			return PrepareNotificationText(original, (Suggestion)entity);
		}
		
		protected string PrepareNotificationText(string original, Suggestion suggestion)
		{
			string text = original;
			
			text = text.Replace("${Application.Title}", Configuration.Config.Application.Title);
			
			text = text.Replace("${Suggestion.Subject}", suggestion.Subject);
			text = text.Replace("${Suggestion.Description}", suggestion.Description);
			text = text.Replace("${Suggestion.Status}", suggestion.Status.ToString());
			text = text.Replace("${Suggestion.AuthorName}", suggestion.AuthorName);
			text = text.Replace("${Suggestion.AuthorEmail}", suggestion.AuthorEmail);
			text = text.Replace("${Suggestion.NeedsReply}", suggestion.NeedsReply.ToString());
			
			//  Activate the project property if necessary
			if (suggestion.Project == null)
				ActivateStrategy.New<Suggestion>().Activate(suggestion, "Project");
			
			// Insert the project name
			text = text.Replace("${Suggestion.Project.Name}", EntitiesUtilities.GetPropertyValue(suggestion.Project, "Name").ToString());
			
			return text;
		}
		
		
		static public SuggestionNotificationStrategy New()
		{
			return new SuggestionNotificationStrategy();
		}
	}
}
