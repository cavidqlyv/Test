<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="lc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
    	CreateGoal();
    }   
    
    private void CreateGoal()
    {
    	Goal goal = CreateStrategy.New<Goal>().Create<Goal>();
    	goal.ID = Guid.NewGuid();
    	goal.Title = "Test goal";
    	goal.Project = GetFirstProject();
    	
    	SaveStrategy.New(goal).Save(goal);
    	
    }
    
    
    private IProject GetFirstProject()
    {
    	IProject[] projects = Collection<IProject>.ConvertAll(IndexStrategy.New("Project").Index());
    	
    	if (projects == null || projects.Length == 0)
    		throw new InvalidOperationException("No projects have been added yet.");
    		
    	return projects[0];
    }
</script>
Done<br/>
1 goal created