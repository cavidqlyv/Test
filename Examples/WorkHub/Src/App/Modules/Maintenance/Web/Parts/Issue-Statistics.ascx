<%@ Control Language="C#" ClassName="IssueStatistics" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Maintenance" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
	public IssueStatus[] AvailableStatuses = new IssueStatus[] {};
	public Priority[] AvailablePriorities = new Priority[] {};

    protected void Page_Init(object sender, EventArgs e)
    {
        	
        	AvailableStatuses = new IssueStatus[]
        	{
        		IssueStatus.Pending,
        		IssueStatus.Resolved,
        		IssueStatus.Closed
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
      	MenuTitle = Language.IssuesStatistics;
      	MenuCategory = Language.Issues;
        ShowOnMenu = true;
    }
    
    public int GetStatsCount(IssueStatus status, Priority priority)
    {
    	// TODO: See if a more efficient way can be found to do this
    	// Currently all issues are being loaded just to count them. It's possible to count objects in
    	// a query without loading the actual object so that should be used to speed things up
    	
    	Issue[] issues = LoadIssues(status, priority);
    	
    	return issues.Length;
    }
    
    public Issue[] LoadIssues(IssueStatus status, Priority priority)
    {
    	
    	FilterGroup filterGroup = DataAccess.Data.CreateFilterGroup();
    	
    	PropertyFilter statusFilter = DataAccess.Data.CreatePropertyFilter();
    	statusFilter.PropertyName = "Status";
    	statusFilter.PropertyValue = status;
    	statusFilter.AddType(typeof(Issue));
    	
    	filterGroup.Add(statusFilter);
    	
    	PropertyFilter priorityFilter = DataAccess.Data.CreatePropertyFilter();
    	priorityFilter.PropertyName = "Priority";
    	priorityFilter.PropertyValue = priority;
    	priorityFilter.AddType(typeof(Issue));
    	
    	filterGroup.Add(priorityFilter);
    	
    	if (ProjectsState.ProjectSelected)
    	{
	    	ReferenceFilter referenceFilter = DataAccess.Data.CreateReferenceFilter();
	    	referenceFilter.PropertyName = "Project";
	    	referenceFilter.ReferenceType = EntityState.GetType("Project");
	    	referenceFilter.ReferencedEntityID = ProjectsState.ProjectID;
    		referenceFilter.AddType(typeof(Issue));
	    	
	    	filterGroup.Add(referenceFilter);
    	}
    	return IndexStrategy.New<Issue>().Index<Issue>(filterGroup);
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
		<% foreach (IssueStatus status in AvailableStatuses){ %>
		<tr> 
			<td class="LeftStatsTitle" nowrap>
			 	<%= IssueStatusUtilities.GetStatusText(status) %><br/>
			</td>
			<% foreach (Priority priority in AvailablePriorities){ %>
				<td class="StatsPartValue">
					<%= GetStatsCount(status, priority) %>
				</td>
			<% } %>
		</tr>
		<% } %>
	</table>