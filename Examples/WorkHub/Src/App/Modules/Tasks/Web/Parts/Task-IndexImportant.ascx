<%@ Control Language="C#" ClassName="IndexImportantTasks" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web" %>
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

            Task[] tasks;
            
				tasks = IndexTaskStrategy.New().IndexImportantTasks(ProjectsState.ProjectID, limit);
	
			if (Authorisation.UserCan("View", tasks))
			{
				TaskList.DataSource = tasks;
				DataBind();
			}
			else
				Visible = false;
			
			SetDefaultHeight(tasks.Length);
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
     
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.ImportantTasks;
      	MenuCategory = Language.Tasks;
        ShowOnMenu = true;
    }
                    
</script>
			<asp:Repeater id="TaskList" Runat="server">
				<ItemTemplate>
						<h3>
							<a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'>
								<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Title"), 50) %>
							</a>
						</h3>
						<p class="Details">
							<%# Utilities.GetRelativeDate((DateTime)DataBinder.Eval(Container.DataItem, "DateCreated"))%>
							<asp:PlaceHolder ID="PlaceHolder1" Runat=server Visible='<%# DataBinder.Eval(Container.DataItem, "Creator") != null %>'>| <a href="mailto:<%# DataBinder.Eval(Container.DataItem, "Creator.Email") %>">
									<%# DataBinder.Eval(Container.DataItem, "Creator.Name") %>
								</a></asp:PlaceHolder>
							<asp:PlaceHolder Runat=server Visible='<%# !ProjectsState.ProjectSelected && DataBinder.Eval(Container.DataItem, "Project") != null %>' ID="Placeholder2">
								<span class="ProjectLabel">- <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)DataBinder.Eval(Container.DataItem, "Project")) : String.Empty %>'>
										<%# DataBinder.Eval(Container.DataItem, "Project.Name") %>
									</a></span>
							</asp:PlaceHolder>
						</p>
						<p class="Details">
							<%= Language.Priority %>: <%# PriorityUtilities.GetPriorityText((Priority)Eval("Priority")) %> - <%= Language.Status %>: <%# TaskStatusUtilities.GetStatusText((TaskStatus)Eval("Status")) %> - <%= Language.Difficulty %>: <%# DifficultyUtilities.GetDifficultyText((Difficulty)Eval("Difficulty")) %>
						</p>
						<p>
							<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoTasksPanel cssclass="NotFound" Runat="server" visible='<%# TaskList.DataSource == null || ((Task[])TaskList.DataSource).Length == 0 %>'>
				<p>
					<%= ProjectsState.ProjectID == Guid.Empty ? Language.NoImportantTasks : Language.NoImportantProjectTasks %>
				</p>
			</asp:Panel>