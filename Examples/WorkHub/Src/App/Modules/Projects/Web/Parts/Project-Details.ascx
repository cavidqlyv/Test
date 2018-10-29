<%@ Control Language="C#" ClassName="ViewProject" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
    	DataBind();

		SetDefaultHeight();
    }
    
    private void SetDefaultHeight()
    {
		if (ProjectsState.Project != null)
    		DefaultHeight = Unit.Pixel(160);
    	else
    		DefaultHeight = Unit.Pixel(30);
    }

    public override void InitializeInfo()
    {
      	MenuTitle = Language.ProjectDetails;
      	MenuCategory = Language.Projects;
        ShowOnMenu = true;
    }
    
                    
</script>
<asp:Panel runat="server" id="ProjectSummaryPanel" visible='<%# ProjectsState.Project != null %>'>
<h3>
<a href='<%= ProjectsState.Project != null ? Navigator.GetLink("View", ProjectsState.Project) : String.Empty %>'><%= ProjectsState.Project != null ? ProjectsState.Project.Name : String.Empty %></a>
</h3>
<asp:placeholder runat="server" visible='<%# ProjectsState.Project != null && ProjectsState.Project.CurrentVersion != null && ProjectsState.Project.CurrentVersion != String.Empty %>'>
<p class="Details">
<%= TextSpacer.Space(ProjectsState.Project.CompanyName, "v" + ProjectsState.Project.CurrentVersion) %>
</p>
</asp:placeholder>
<p>
<%= ProjectsState.Project != null ? ProjectsState.Project.Summary : String.Empty %>
<%= (ProjectsState.Project != null && ProjectsState.Project.Summary == String.Empty) ? Language.NoSummary : String.Empty %>
</p>
<asp:placeholder runat="server" visible='<%# ProjectsState.Project != null && ProjectsState.Project.MoreInfo != null && ProjectsState.Project.MoreInfo != String.Empty %>'>
<p>
<%= ProjectsState.Project != null && ProjectsState.Project.MoreInfo != null ? ProjectsState.Project.MoreInfo.Replace("\n", "<br/>") : String.Empty %>
</p>
</asp:placeholder>

<p class="Links"><a href='<%# ProjectsState.Project != null ? Navigator.GetLink("Edit", ProjectsState.Project) : String.Empty %>'><%# Language.Edit %> &raquo;</a></p>
</asp:Panel>

<asp:Panel runat="server" id="NoProjectSelectedPanel" visible='<%# ProjectsState.Project == null %>'>
<p>
<%= Language.NoProjectSelected %>
</p>
</asp:Panel>