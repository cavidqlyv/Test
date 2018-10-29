<%@ Control Language="C#" ClassName="FeaturesSummary" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
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
	        Feature[] features = null;
			if (ProjectsState.ProjectID != Guid.Empty)
			{
				Visible = true;
				
				features = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
				
				SetDefaultHeight(features.Length);
			}
			
			if (Authorisation.UserCan("View", features))
			{
				FeatureList.DataSource = features;
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
      	MenuTitle = Language.Features;
      	MenuCategory = Language.Planning;
        ShowOnMenu = true;
    }
                    
</script>
	<asp:Repeater id="FeatureList" Runat="server">
		<ItemTemplate>
			<h3>
					<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Name"), 50) %>'/>
				</h3>
				<p>
					<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
				</p>
				<hr/>
		</ItemTemplate>
	</asp:Repeater>
	<asp:Panel id=NoFeaturesPanel cssclass="NotFound" Runat="server" visible='<%# FeatureList.DataSource == null || ((Feature[])FeatureList.DataSource).Length == 0 %>'>
		<p>
		<%= ProjectsState.ProjectSelected ? Language.NoProjectFeatures : Language.SelectProjectToViewFeatures %>
		</p>
	</asp:Panel>