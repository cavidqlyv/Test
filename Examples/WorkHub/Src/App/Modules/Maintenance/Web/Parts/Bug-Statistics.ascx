<%@ Control Language="C#" ClassName="BugStatistics" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
	public BugStatus[] AvailableStatuses = new BugStatus[] {};
	public Priority[] AvailablePriorities = new Priority[] {};

    protected void Page_Init(object sender, EventArgs e)
    {
        	
        	AvailableStatuses = new BugStatus[]
        	{
        		BugStatus.Pending,
        		BugStatus.InProgress,
        		BugStatus.OnHold,
        		BugStatus.Fixed,
        		BugStatus.Tested
        	};
        	
        	AvailablePriorities = new Priority[]
        	{
        		Priority.VeryLow,
        		Priority.Low,
        		Priority.Moderate,
        		Priority.High,
        		Priority.Extreme
        	};

		DefaultHeight=125;
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.BugsStatistics;
      	MenuCategory = Language.Bugs;
        ShowOnMenu = true;
    }
    
    public int GetStatsCount(BugStatus status, Priority priority)
    {
    	// TODO: See if a more efficient way can be found to do this
    	// Currently all bugs are being loaded just to count them. It's possible to count objects in
    	// a query without loading the actual object so that should be used to speed things up
    	
    	Bug[] bugs = LoadBugs(status, priority);
    	
    	return bugs.Length;
    }
    
    public Bug[] LoadBugs(BugStatus status, Priority priority)
    {
    	
    	FilterGroup filterGroup = DataAccess.Data.CreateFilterGroup();
    	
    	PropertyFilter statusFilter = DataAccess.Data.CreatePropertyFilter();
    	statusFilter.PropertyName = "Status";
    	statusFilter.PropertyValue = status;
    	statusFilter.AddType(typeof(Bug));
    	
    	filterGroup.Add(statusFilter);
    	
    	PropertyFilter priorityFilter = DataAccess.Data.CreatePropertyFilter();
    	priorityFilter.PropertyName = "Priority";
    	priorityFilter.PropertyValue = priority;
    	priorityFilter.AddType(typeof(Bug));
    	
    	filterGroup.Add(priorityFilter);
    	
    	if (ProjectsState.ProjectSelected)
    	{
	    	ReferenceFilter referenceFilter = DataAccess.Data.CreateReferenceFilter();
	    	referenceFilter.PropertyName = "Project";
	    	referenceFilter.ReferenceType = EntityState.GetType("Project");
	    	referenceFilter.ReferencedEntityID = ProjectsState.ProjectID;
    		referenceFilter.AddType(typeof(Bug));
	    	
	    	filterGroup.Add(referenceFilter);
    	}
    	return IndexStrategy.New<Bug>().Index<Bug>(filterGroup);
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
		<% foreach (BugStatus status in AvailableStatuses){ %>
		<tr> 
			<td class="LeftStatsTitle" nowrap>
			 	<%= BugStatusUtilities.GetStatusText(status) %><br/>
			</td>
			<% foreach (Priority priority in AvailablePriorities){ %>
				<td class="StatsPartValue">
					<%= GetStatsCount(status, priority) %>
				</td>
			<% } %>
		</tr>
		<% } %>
	</table>