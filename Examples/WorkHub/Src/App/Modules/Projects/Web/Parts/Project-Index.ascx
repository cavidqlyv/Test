<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
		Project[] projects = IndexStrategy.New<Project>().Index<Project>();

		if (Authorisation.UserCan("Index", projects))
		{
			ProjectList.DataSource = projects;
			DataBind();
			Visible = true;
		}
		else
			Visible = false;
		
		SetDefaultHeight(projects.Length, 100);
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Projects;
      	MenuCategory = Language.Projects;
        ShowOnMenu = true;
    }
</script>
			<asp:Repeater id="ProjectList" Runat="server">
				<ItemTemplate>
						<h3>
							<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("Select", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Name"), 50) %>'/>
						</h3>
						<p class="Details">
							<%# TextSpacer.Space((string)DataBinder.Eval(Container.DataItem, "CompanyName"), "v" + DataBinder.Eval(Container.DataItem, "CurrentVersion")) %>
						</p>
						<p>
							<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Summary"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoProjectsPanel cssclass="NotFound" Runat="server" visible='<%# ProjectList.DataSource == null || ((Project[])ProjectList.DataSource).Length == 0 %>'>
				<p>
				<%= Language.NoProjects %>
				</p>
			</asp:Panel>