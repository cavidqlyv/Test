<%@ Control Language="C#" ClassName="SuggestionStatistics" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
	public SuggestionStatus[] AvailableStatuses = new SuggestionStatus[] {};
	public Priority[] AvailablePriorities = new Priority[] {};

    protected void Page_Init(object sender, EventArgs e)
    {
        	
        	AvailableStatuses = new SuggestionStatus[]
        	{
        		SuggestionStatus.Pending,
        		SuggestionStatus.Accepted,
        		SuggestionStatus.Implemented
        	};
        	
        	AvailablePriorities = new Priority[]
        	{
        		Priority.VeryLow,
        		Priority.Low,
        		Priority.Moderate,
        		Priority.High,
        		Priority.Extreme
        	};

        DefaultHeight = 85;
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.SuggestionsStatistics;
      	MenuCategory = Language.Suggestions;
        ShowOnMenu = true;
    }
    
    public int GetStatsCount(SuggestionStatus status, Priority priority)
    {
    	// TODO: See if a more efficient way can be found to do this
    	// Currently all tasks are being loaded just to count them. It's possible to count objects in
    	// a query without loading the actual object so that should be used to speed things up
    	
    	Suggestion[] tasks = LoadSuggestions(status, priority);
    	
    	return tasks.Length;
    }
    
    public Suggestion[] LoadSuggestions(SuggestionStatus status, Priority priority)
    {
    	
    	FilterGroup filterGroup = DataAccess.Data.CreateFilterGroup();
    	
    	PropertyFilter statusFilter = DataAccess.Data.CreatePropertyFilter();
    	statusFilter.PropertyName = "Status";
    	statusFilter.PropertyValue = status;
    	statusFilter.AddType(typeof(Suggestion));
    	
    	filterGroup.Add(statusFilter);
    	
    	PropertyFilter priorityFilter = DataAccess.Data.CreatePropertyFilter();
    	priorityFilter.PropertyName = "Priority";
    	priorityFilter.PropertyValue = priority;
    	priorityFilter.AddType(typeof(Suggestion));
    	
    	filterGroup.Add(priorityFilter);
    	
    	if (ProjectsState.ProjectSelected)
    	{
	    	ReferenceFilter referenceFilter = DataAccess.Data.CreateReferenceFilter();
	    	referenceFilter.PropertyName = "Project";
	    	referenceFilter.ReferenceType = EntityState.GetType("Project");
	    	referenceFilter.ReferencedEntityID = ProjectsState.ProjectID;
    		referenceFilter.AddType(typeof(Suggestion));
	    	
	    	filterGroup.Add(referenceFilter);
    	}
    	return IndexStrategy.New<Suggestion>().Index<Suggestion>(filterGroup);
    }
                    
</script>
	<table class="StatsPartTable">
		<tr>
			<td>&nbsp;</td>
			<% foreach (Priority priority in AvailablePriorities){ %>
			<td class="TopStatsTitle" nowrap>
				<%= PriorityUtilities.GetPriorityText(priority) %>
			</td>
			<% } %>
		</tr>
		<% foreach (SuggestionStatus status in AvailableStatuses){ %>
		<tr> 
			<td class="LeftStatsTitle" nowrap>
			 	<%= SuggestionStatusUtilities.GetStatusText(status) %><br/>
			</td>
			<% foreach (Priority priority in AvailablePriorities){ %>
				<td class="StatsPartValue">
					<%= GetStatsCount(status, priority) %>
				</td>
			<% } %>
		</tr>
		<% } %>
	</table>