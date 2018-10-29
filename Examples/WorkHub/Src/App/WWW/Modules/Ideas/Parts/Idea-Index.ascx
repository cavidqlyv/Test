<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
		Idea[] files = IndexStrategy.New<Idea>().IndexWithReference<Idea>("Projects", "Project", ProjectsState.ProjectID);

		if (Authorisation.UserCan("Index", files))
		{
			IdeaList.DataSource = files;
			DataBind();
			Visible = true;
		}
		else
			Visible = false;
		
		SetDefaultHeight(files.Length, 100);
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Ideas;
      	MenuCategory = Language.Ideas;
        ShowOnMenu = true;
    }
</script>
			<asp:Repeater id="IdeaList" Runat="server">
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
			<asp:Panel id=NoIdeasPanel cssclass="NotFound" Runat="server" visible='<%# IdeaList.DataSource == null || ((Idea[])IdeaList.DataSource).Length == 0 %>'>
				<p>
				<%= Language.NoIdeas %>
				</p>
			</asp:Panel>