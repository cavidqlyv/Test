<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
    	Guid milestoneID = QueryStrings.GetID("Milestone");
    	Guid fromMilestoneID = QueryStrings.GetID("FromMilestone");
    	Guid taskID = QueryStrings.GetID("Task");
    	
    	if (milestoneID == Guid.Empty)
    		throw new InvalidOperationException("No milestone ID was specified in the query string.");
    		
    	if (fromMilestoneID == Guid.Empty)
    		throw new InvalidOperationException("No from milestone ID was specified in the query string.");
    		
    	if (taskID == Guid.Empty)
    		throw new InvalidOperationException("No task specified by the query string.");
    	
    	MoveTaskToMilestoneStrategy.New().Move(taskID, fromMilestoneID, milestoneID);
    	
    	Result.Display(Language.TaskMoved);
    	
    	Navigator.Go("Roadmap");
    }
</script>