<%@ Control Language="C#" ClassName="ScenariosSummary" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
    
	        Scenario[] scenarios = null;
			if (ProjectsState.ProjectID != Guid.Empty)
			{
				Visible = true;
				
				scenarios = IndexStrategy.New<Scenario>().IndexWithReference<Scenario>("Project", "Project", ProjectsState.ProjectID);
			
				SetDefaultHeight(scenarios.Length);
			}
	
			if (Authorisation.UserCan("View", scenarios))
			{
				ScenarioList.DataSource = scenarios;
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
      	MenuTitle = Language.Scenarios;
      	MenuCategory = Language.Planning;
        ShowOnMenu = true;
    }
                    
</script>
		<asp:Repeater id="ScenarioList" Runat="server">
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
		<asp:Panel id=NoScenariosPanel cssclass="NotFound" Runat="server" visible='<%# ScenarioList.DataSource == null || ((Scenario[])ScenarioList.DataSource).Length == 0 %>'>
		<p>
			<%= ProjectsState.ProjectSelected ? Language.NoProjectScenarios : Language.SelectProjectToViewScenarios %>
		</p>
		</asp:Panel>