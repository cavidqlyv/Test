using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("UpdateStatus", "Suggestion")]
	public class UpdateSuggestionStatusStrategy : UpdateStrategy
	{
		public UpdateSuggestionStatusStrategy()
		{
		}
		
		public void UpdateSuggestionStatus(Guid suggestionID, SuggestionStatus status)
		{
			if (suggestionID == Guid.Empty)
				throw new ArgumentException("The provided suggestion ID cannot be Guid.Empty.", "suggestionID");
			
			Suggestion suggestion = RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>("ID", suggestionID);
			
			if (suggestion == null)
				throw new ArgumentException("No suggestion found with the ID: " + suggestion);
			
			ActivateStrategy.New(suggestion).Activate(suggestion);
			
			suggestion.Status = status;
			
			UpdateStrategy.New(suggestion).Update(suggestion);
		}
		
		static public UpdateSuggestionStatusStrategy New()
		{
			return new UpdateSuggestionStatusStrategy();
		}
	}
}
