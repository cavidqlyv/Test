<%@ Control Language="C#" ClassName="IndexImportantBugs" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
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

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	// Set the maximum number of items displayed
        	int limit = 10;

            Bug[] bugs;
            
			bugs = IndexBugStrategy.New().IndexImportantBugs(ProjectsState.ProjectID, limit);
			
			SetDefaultHeight(bugs.Length);
	
			if (Authorisation.UserCan("View", bugs))
			{
				BugList.DataSource = bugs;
				DataBind();
			}
			else
				Visible = false;
			
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
     
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.ImportantBugs;
      	MenuCategory = Language.Bugs;
        ShowOnMenu = true;
    }
                    
</script>
			<asp:Repeater id="BugList" Runat="server">
				<ItemTemplate>
						<h3>
							<a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'>
								<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>
							</a>
						</h3>
						<p class="Details">
							<%# Utilities.GetRelativeDate((DateTime)DataBinder.Eval(Container.DataItem, "DateReported"))%>
							<asp:PlaceHolder ID="PlaceHolder1" Runat=server Visible='<%# DataBinder.Eval(Container.DataItem, "Reporter") != null %>'>| <a href="mailto:<%# DataBinder.Eval(Container.DataItem, "Reporter.Email") %>">
									<%# DataBinder.Eval(Container.DataItem, "Reporter.Name") %>
								</a></asp:PlaceHolder>
							<asp:PlaceHolder Runat=server Visible='<%# ProjectsState.Project == null && DataBinder.Eval(Container.DataItem, "Project") != null %>' ID="Placeholder2">
								<span class="ProjectLabel">- <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)DataBinder.Eval(Container.DataItem, "Project")) : String.Empty %>'>
										<%# DataBinder.Eval(Container.DataItem, "Project.Name") %>
									</a></span>
							</asp:PlaceHolder>
						</p>
						<p class="Details">
							<%= Language.Priority %>: <%# PriorityUtilities.GetPriorityText((Priority)Eval("Priority")) %> - <%= Language.Status %>: <%# BugStatusUtilities.GetStatusText((BugStatus)Eval("Status")) %>
						</p>
						<p>
							<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoBugsPanel cssclass="NotFound" Runat="server" visible='<%# BugList.DataSource == null || ((Bug[])BugList.DataSource).Length == 0 %>'>
			<p>
				<%= ProjectsState.ProjectID == Guid.Empty ? Language.NoImportantBugs : Language.NoImportantProjectBugs %>
			</p>
			</asp:Panel>