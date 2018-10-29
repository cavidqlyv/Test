<%@ Control Language="C#" ClassName="GoalIndex" autoeventwireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
	       	Goal[] goals = null;
			if (ProjectsState.ProjectID != Guid.Empty)
			{
				Visible = true;
				goals = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);//.GetImportantGoals(My.Project, My.User, 10);
				
				if (Authorisation.UserCan("View", goals))
				{
					GoalList.DataSource = goals;
					
				}
				
				
				SetDefaultHeight(goals.Length);
					
			}			
			
			DataBind();
			
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
     
    }

    public override void InitializeInfo()
    {
      	MenuTitle = Language.Goals;
      	MenuCategory = Language.Planning;
        ShowOnMenu = true;
    }
    
                    
</script>
		<asp:Repeater id="GoalList" Runat="server">
			<ItemTemplate>
				<h3>
								<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>'/>
					</h3>
					<p>
						<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
					</p>
					<hr/>
			</ItemTemplate>
		</asp:Repeater>
		<asp:Panel id=NoGoalsPanel cssclass="NotFound" Runat="server" visible='<%# GoalList.DataSource == null || ((Goal[])GoalList.DataSource).Length == 0 %>'>
		<p>
			<%= ProjectsState.ProjectSelected ? Language.NoProjectGoals : Language.SelectProjectToViewGoals %>
		</p>
		</asp:Panel>