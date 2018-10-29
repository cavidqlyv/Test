using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Data;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Index", "Suggestion")]
	public class IndexSuggestionStrategy : IndexStrategy
	{
		public IndexSuggestionStrategy()
		{
		}
		
		
		public Suggestion[] Index(Guid projectID, bool includePending, bool includeAccepted, bool includeImplemented)
		{
			// Outer filter group
			FilterGroup group = new FilterGroup();
			group.Operator = FilterGroupOperator.And;
			
			
			// Filter by project
			if (projectID != Guid.Empty)
				group.Add(new ReferenceFilter(typeof(Suggestion), "Project", "Project", projectID));
			
			
			// Status filter group
			FilterGroup statusGroup = new FilterGroup();
			group.Add(statusGroup);
			statusGroup.Operator = FilterGroupOperator.Or;
			
			
			// Filter by flags
			if (includePending)
				statusGroup.Add(new PropertyFilter(typeof(Suggestion), "Status", SuggestionStatus.Pending));
			
			if (includeAccepted)
				statusGroup.Add(new PropertyFilter(typeof(Suggestion), "Status", SuggestionStatus.Accepted));
			
			if (includeImplemented)
				statusGroup.Add(new PropertyFilter(typeof(Suggestion), "Status", SuggestionStatus.Implemented));
						
			Suggestion[] suggestions = Index<Suggestion>(group);
			
			
			
			return suggestions;
		}
		
		public Suggestion[] IndexImportantSuggestions(Guid projectID, int maximumQuantity)
		{
			Collection<Suggestion> suggestions = new Collection<Suggestion>(Index(projectID, true, true, false));
			Collection<Suggestion> topSuggestions = new Collection<Suggestion>();
			
			// Order the suggestions by priority
			suggestions.Sort("SubjectAscending");
			suggestions.Sort("DatePostedDescending");
			
			for (int i = 0; i < suggestions.Count; i++)
			{
				if (i < maximumQuantity)
				{
					topSuggestions.Add(suggestions[i]);
				}
			}
			
			return topSuggestions.ToArray();
		}
		
		static public IndexSuggestionStrategy New()
		{
			return new IndexSuggestionStrategy();
		}
		
		static public IndexSuggestionStrategy New(PagingLocation location, string sortExpression)
		{
			IndexSuggestionStrategy strategy = new IndexSuggestionStrategy();
			strategy.Location = location;
			strategy.EnablePaging = true;
			strategy.SortExpression = sortExpression;
			return strategy;
		}
	}
}
