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
    	CreateScenario();
    }   
    
    private void CreateScenario()
    {
    	Scenario scenario = CreateStrategy.New<Scenario>().Create<Scenario>();
    	scenario.ID = Guid.NewGuid();
    	scenario.Name = "Test scenario";
    	scenario.Project = GetFirstProject();
    	
    	SaveStrategy.New(scenario).Save(scenario);
    	
    	int totalSteps = GetTotalSteps();
    	
    	for (int i = 0; i < totalSteps; i++)
    	{
    		CreateScenarioStep(scenario, i+1); // +1 to adust index (0 based) to number (1 based)
    	}
    }
    
    private void CreateScenarioStep(Scenario parent, int stepNumber)
    {
    	ScenarioStep step = CreateStrategy.New<ScenarioStep>().Create<ScenarioStep>();
    	step.ID = Guid.NewGuid();
    	step.Text = "Step " + stepNumber;
    	step.StepNumber = stepNumber;
    	
    	step.Scenario = parent;
    	
    	SaveStrategy.New(step).Save(step);
    }
    
    private int GetTotalSteps()
    {
    	int total = 0;
    	if (Request.QueryString["TotalSteps"] != null)
    		total = Int32.Parse(Request.QueryString["TotalSteps"]);
    		
    	return total;
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
1 scenario created<br/>
<%= GetTotalSteps() %> steps created