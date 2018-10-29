<%@ Control Language="C#" ClassName="SelectProject" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
	// TODO: Move code into a controller

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	Select();
        }
    }


    #region Main functions
    public void Select()
    {
    	Guid projectID = QueryStrings.GetID("Project");
    	
    	if (projectID != Guid.Empty)
    	{
    		Select(projectID);
    	}
    	else
    		throw new Exception("No project ID provided in the query string.");
    }
    
    /// <summary>
    /// Sets the selected project as the current working project and redirects back to the overview.
    /// </summary>
    public void Select(Guid projectID)
    {
        Select(RetrieveStrategy.New<Project>().Retrieve<Project>("ID", projectID));
    }

    public void Select(Project project)
    {
        if (project == null)
            throw new ArgumentNullException("project");
        
        ProjectsState.SelectProject(project);

		Navigator.Go("View", project);
    }
    #endregion

                    
</script>