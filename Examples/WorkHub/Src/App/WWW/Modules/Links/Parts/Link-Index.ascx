<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
		Link[] links = new Link[]{};
		
		if (ProjectsState.ProjectSelected)
			links = IndexStrategy.New<Link>().IndexWithReference<Link>("Projects", "Project", ProjectsState.ProjectID);
		else
			links = IndexStrategy.New<Link>().Index<Link>();

		if (Authorisation.UserCan("Index", links))
		{
			LinkList.DataSource = links;
			DataBind();
			Visible = true;
		}
		else
			Visible = false;
		
		SetDefaultHeight(links.Length, 100);
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Links;
      	MenuCategory = Language.Links;
        ShowOnMenu = true;
    }
</script>
			<asp:Repeater id="LinkList" Runat="server">
				<ItemTemplate>
						<h3>
							<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>'/>
						</h3>
						<p class="Details">
							<a href='<%# Eval("Url") %>' target="_blank">
							<%# Utilities.Summarize((string)Eval("Url"), 100) %>
							</a>
							
						</p>
						<p>
							<%# Utilities.Summarize((string)Eval("Summary"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoLinksPanel cssclass="NotFound" Runat="server" visible='<%# LinkList.DataSource == null || ((Link[])LinkList.DataSource).Length == 0 %>'>
				<p>
				<%= Language.NoLinks %>
				</p>
			</asp:Panel>
			<div align="center"><a href='<%= new UrlCreator().CreateUrl("Index", "Link") %>'><%= Language.Links %> &raquo;</a> - <a href='<%= new UrlCreator().CreateUrl("Create", "Link") %>'><%= Language.CreateLink %> &raquo;</a></div>
						