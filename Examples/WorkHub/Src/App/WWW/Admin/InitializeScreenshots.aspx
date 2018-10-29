
<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="Initialize Screenshots" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
	// Ensure the current application is not a live installation
	EnsureNotLive();

    	// This page initializes a session for the screenshot program to be able to view the program in action
    	
    	User[] users = IndexStrategy.New<User>(false).Index<User>();
    	
    	if (users.Length == 0)
    		throw new Exception("No users found. Can't take screenshots.");
    	
    	// Load the administrator user
		User administrator = users[0];
	
		if (administrator == null)
			throw new Exception("administrator wasn't found.");

		// Sign the screenshot program in
        Authentication.SetAuthenticatedUsername(administrator.Username);
        
		ProjectsState.Project = GetProject();
        
        // Send the screenshot program to the page it's taking the screenshot of
        Response.Redirect(Request.ApplicationPath + "/" + Request.QueryString["SendTo"]);
    }

	private void EnsureNotLive()
	{
		// If the path variation is String.Empty then its likely a live installation (ie. it's not local and it's not staging)
		if (Config.Application.PathVariation == String.Empty)
		{
			Result.DisplayError("Can't initialize screenshots in a live installation.");
			Response.Redirect(Request.ApplicationPath);
		}
	}
    
    private IProject GetProject()
    {
    	// Get project name (if specified)
    	string projectName = Request.QueryString["Project"];
    
    	object project = null;
    	
    	if (projectName != null && projectName != String.Empty)
    	{
    		if (projectName == "*")
    		{
	    		object[] projects = IndexStrategy.New("Project", false).Index();
		        
		        if (projects.Length == 0)
		        	throw new InvalidOperationException("No projects found. Can't take screenshots.");
		        
		        // Set the first project in the list as the current project
				project = projects[0];
			}
			else
			{
	    		project = RetrieveStrategy.New("Project", false).Retrieve(
	    			"Name",
	    			projectName);
    		}
		}
		
		return (IProject)project;
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">

</asp:Content>

