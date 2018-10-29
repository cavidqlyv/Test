<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
		Component[] files = IndexStrategy.New<Component>().IndexWithReference<Component>("Projects", "Project", ProjectsState.ProjectID);

		if (Authorisation.UserCan("Index", files))
		{
			ComponentList.DataSource = files;
			DataBind();
			Visible = true;
		}
		else
			Visible = false;
		
		SetDefaultHeight(files.Length, 100);
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Components;
      	MenuCategory = Language.Components;
        ShowOnMenu = true;
    }
</script>
			<asp:Repeater id="ComponentList" Runat="server">
				<ItemTemplate>
						<h3>
							<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>'/>
						</h3>
						<p>
							<%# Utilities.Summarize((string)Eval("Summary"), 100) %>
						</p>
						<p>
							<a href='<%# Eval("Url") %>' target="_blank">
							<%# Utilities.Summarize((string)Eval("Url"), 100) %>
							</a>
							
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoComponentsPanel cssclass="NotFound" Runat="server" visible='<%# ComponentList.DataSource == null || ((Component[])ComponentList.DataSource).Length == 0 %>'>
				<p>
				<%= Language.NoComponents %>
				</p>
			</asp:Panel>