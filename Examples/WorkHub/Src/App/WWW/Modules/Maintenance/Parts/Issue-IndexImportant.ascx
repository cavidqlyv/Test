<%@ Control Language="C#" ClassName="IndexImportantIssues" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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

            Issue[] issues;
            
			issues = IndexIssueStrategy.New().IndexImportantIssues(ProjectsState.ProjectID, limit);
	
			if (Authorisation.UserCan("View", issues))
			{
				IssueList.DataSource = issues;
				IssuesPanel.DataBind();
			}
			else
				IssuesPanel.Visible = false;
			
			SetDefaultHeight(issues.Length);
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
     
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.ImportantIssues;
      	MenuCategory = Language.Issues;
        ShowOnMenu = true;
    }
                    
</script>
<asp:Panel runat="server" ID="IssuesPanel" CssClass="Scrollable">
			<asp:Repeater id="IssueList" Runat="server">
				<ItemTemplate>
						<h3>
							<a href='<%# Navigator.GetLink("View", "Issue", "ID", DataBinder.Eval(Container.DataItem, "ID").ToString()) %>'>
								<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Subject"), 50) %>
							</a>
						</h3>
						<p class="Details">
							<%# Utilities.GetRelativeDate((DateTime)DataBinder.Eval(Container.DataItem, "DateReported"))%>
							<asp:PlaceHolder Runat=server Visible='<%# Eval("ReporterName") != null && (string)Eval("ReporterName") != String.Empty %>' ID="Placeholder1">
							- <asp:hyperlink runat="server" navigateurl='<%# Navigator.GetLink("Reply", "Issue") + "?IssueID=" + Eval("ID").ToString() %>' enabled='<%# Eval("ReporterEmail") != null && (string)Eval("ReporterEmail") != String.Empty %>' text='<%# Utilities.Summarize((string)Eval("ReporterName"), 100) %>' />
							</asp:PlaceHolder>
							<asp:PlaceHolder Runat=server Visible='<%# ProjectsState.Project == null && DataBinder.Eval(Container.DataItem, "Project") != null %>' ID="Placeholder2">
								<span class="ProjectLabel">- <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)DataBinder.Eval(Container.DataItem, "Project")) : String.Empty %>'>
										<%# DataBinder.Eval(Container.DataItem, "Project.Name") %>
									</a></span>
							</asp:PlaceHolder>
						</p>
						<p class="Details">
							<%= Language.Status %>: <%# IssueStatusUtilities.GetStatusText((IssueStatus)Eval("Status")) %>
						</p>
						<p>
							<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoIssuesPanel cssclass="NotFound" Runat="server" visible='<%# IssueList.DataSource == null || ((Issue[])IssueList.DataSource).Length == 0 %>'>
				<p>
				<%= ProjectsState.ProjectID == Guid.Empty ? Language.NoImportantIssues : Language.NoImportantProjectIssues %>
				</p>
			</asp:Panel>
</asp:Panel>