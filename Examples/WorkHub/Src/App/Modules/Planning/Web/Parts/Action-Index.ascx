<%@ Control Language="C#" ClassName="ActionsIndex" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
	        SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[] actions = null;
			
			if (ProjectsState.ProjectID != Guid.Empty)
			{
				Visible = true;
				//actions = ActionFactory.Current.GetActions(filter);
				actions = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
				
				SetDefaultHeight(actions.Length);
			}
	
			if (Authorisation.UserCan("View", actions))
			{
				ActionList.DataSource = actions;
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
      	MenuTitle = Language.Actions;
      	MenuCategory = Language.Planning;
        ShowOnMenu = true;
    }
                    
</script>
																		<asp:Repeater id="ActionList" Runat="server">
																			<ItemTemplate>
																				<h3>
																						<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Name"), 50) %>'/>
																					</h3>
																					<p>
																						<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Summary"), 100) %>
																					</p>
																					<hr/>
																			</ItemTemplate>
																		</asp:Repeater>
																		<asp:Panel id=NoActionsPanel cssclass="NotFound" Runat="server" visible='<%# ActionList.DataSource == null || ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[])ActionList.DataSource).Length == 0 %>'>
																			<p>
																			<%= ProjectsState.ProjectSelected ? Language.NoProjectActions : Language.SelectProjectToViewActions %>
																			</p>
																		</asp:Panel>