<%@ Control Language="C#" ClassName="RestraintsSummary" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
	        Restraint[] restraints = null;
			if (ProjectsState.ProjectID != Guid.Empty)
			{
				Visible = true;
				
				restraints = IndexStrategy.New<Restraint>().IndexWithReference<Restraint>("Project", "Project", ProjectsState.ProjectID);
				
				SetDefaultHeight(restraints.Length);
			}
	
			if (Authorisation.UserCan("View", restraints))
			{
				RestraintList.DataSource = restraints;
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
      	MenuTitle = Language.Restraints;
      	MenuCategory = Language.Planning;
        ShowOnMenu = true;
    }
                    
</script>
		<asp:Repeater id="RestraintList" Runat="server">
			<ItemTemplate>
				<h3>
						<asp:Hyperlink runat="server" navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>' text='<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>'/>
					</h3>
					<p>
						<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Details"), 100) %>
					</p>
					<hr/>
			</ItemTemplate>
		</asp:Repeater>
		<asp:Panel id=NoRestraintsPanel cssclass="NotFound" Runat="server" visible='<%# RestraintList.DataSource == null || ((Restraint[])RestraintList.DataSource).Length == 0 %>'>
			<p>
			<%= ProjectsState.ProjectSelected ? Language.NoProjectRestraints : Language.SelectProjectToViewRestraints %>
			</p>
		</asp:Panel>