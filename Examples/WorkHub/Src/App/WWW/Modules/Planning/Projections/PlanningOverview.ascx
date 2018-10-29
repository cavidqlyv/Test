<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection"
    AutoEventWireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web"
    TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>

<script runat="server">
    
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewPlans();
        }
    }


    private void Projects_ProjectIDChanged(object sender, EventArgs e)
    {
        ViewPlans();
    }

    #region Main functions
    /// <summary>
    /// Displays the plans for the current project.
    /// </summary>
    public void ViewPlans()
    {
        OperationManager.StartOperation("ViewPlans", IndexView);

        Goal[] goals = null;
        Feature[] features = null;
        Scenario[] scenarios = null;
        Restraint[] restraints = null;
        int total = 0;

        if (ProjectsState.EnsureProjectSelected())
        {
                Guid projectID = ProjectsState.ProjectID;
                
                // Load goals
                goals = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", projectID);
                //GoalFactory.Current.Activate(goals);
                
                // Load features
                features = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", projectID);
                
                features = Collection<Feature>.Sort(features, "NameAscending");
                
                ActivateStrategy.New<Feature>().Activate(features, "Actions");
                ActivateStrategy.New<Feature>().Activate(features, "Entities");
                              
                // Load scenarios
                scenarios = IndexStrategy.New<Scenario>().IndexWithReference<Scenario>("Project", "Project", projectID);
                
                ActivateStrategy.New<Scenario>().Activate(scenarios);
				
				foreach (Scenario scenario in scenarios)
				{
					foreach (ScenarioStep step in scenario.Steps)
					{
						ActivateStrategy.New<ScenarioStep>().Activate(step, "Action");
					}
				}
				
				
                
                // Load restraints
                restraints = IndexStrategy.New<Restraint>().IndexWithReference<Restraint>("Project", "Project", projectID);
        }

        GoalsIndex.DataSource = goals;
        FeaturesIndex.DataSource = features;
        ScenariosIndex.DataSource = scenarios;
        RestraintsIndex.DataSource = restraints;

        Authorisation.EnsureUserCan("View", goals);
        Authorisation.EnsureUserCan("View", features);
        Authorisation.EnsureUserCan("View", scenarios);
        Authorisation.EnsureUserCan("View", restraints);

        IndexView.DataBind();
    }

    #endregion


    private string GetIntroduction()
    {
		string summary = String.Empty;
        if (ModuleState.IsEnabled("Projects"))
        {
            summary = ProjectsState.Project.Summary;
		}
        if (summary == null || summary.Length == 0)
            summary = "<span class='NoDataText'>" + Language.NoIntroductionForProject + "</span>";
        return summary;
    }
    
    public override void InitializeInfo()
    {
    	MenuTitle = Language.Overview;
    	MenuCategory = Language.Planning + "/" + Language.Requirements;
    }

</script>

<asp:MultiView runat="server" ID="PageView">
    <asp:View runat="server" ID="IndexView">

        <H1>
            <%= ProjectsState.ProjectName + " " + Language.Overview %>
        </H1>
        
            <ss:Result ID="Result1" runat="server">
            </ss:Result>
            <p>
                <%= Language.PlanningOverviewIntro %>
            </p>
            <H2>
                <%= Language.Introduction %>
            </H2>
            <p><%# GetIntroduction() %></p>
            <H2>
                <%= Language.Contents %>
            </H2>
            
            	<p>
                	&#8226; <a href="#Goals"><%= Language.Goals %></a>
                </p>
                <p>
	                &#8226; <a href="#Scenarios"><%= Language.Scenarios%></a>
                </p>
                <p>
	                &#8226; <a href="#Features">
	                    <%= Language.Features %>
	                </a>
                </p>
                <p>
	                &#8226; <a href="#Restraints">
	                    <%= Language.Restraints %>
	                </a>
                </p>
            <a name="Goals"></a>
            <h2><%# Language.Goals %>&nbsp;
            <span class="HeadingLinks"><a href='<%= Navigator.GetLink("Index", "Goal") %>'><%= Language.Index %></a>&nbsp;|&nbsp;<a href='<%= Navigator.GetLink("Create", "Goal") %>'><%= Language.Create %></a></span>
            </h2>
            <asp:Repeater ID="GoalsIndex" runat="server">
                                    <itemtemplate>
                                    <p class="Title"><a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'><%# Eval("Title") %></a></p>
                                    <asp:placeholder runat="server" visible='<%# Eval("Description") != null && (string)Eval("Description") != String.Empty %>'>
                                    <p><%# Utilities.Summarize((String)Eval("Description"), 200) %></p>
                                    </asp:placeholder>
                                    <hr/>
                                    </itemtemplate>
            </asp:Repeater>
            <asp:placeholder runat="server" visible='<%# ((Goal[])GoalsIndex.DataSource).Length == 0 %>'>
            <p><%= Language.NoGoalsForProject %></p>
            </asp:placeholder>
            <a name="Scenarios"></a>
            <h2><%# Language.Scenarios %>&nbsp;
            <span class="HeadingLinks"><a href='<%= Navigator.GetLink("Index", "Scenario") %>'><%= Language.Index %></a>&nbsp;|&nbsp;<a href='<%= Navigator.GetLink("Create", "Scenario") %>'><%= Language.Create %></a></span></h2>
            <asp:Repeater ID="ScenariosIndex" runat="server">
                                    <itemtemplate>
                                    <p class="Title"><a name='<%# "Scenarios_" + HttpUtility.UrlEncode((string)Eval("Name")) %>' href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'><%# Eval("Name") %></a>
                                    </p>
                                    <asp:placeholder runat="server" visible='<%# Eval("Description") != null && (string)Eval("Description") != String.Empty %>'>
                                    <p><%# Utilities.Summarize((String)Eval("Description"), 200) %></p>
                                    </asp:placeholder>
                                    <asp:Repeater runat="server" datasource='<%# Eval("Steps") %>'>
                                     <ItemTemplate>
                                     	<div style="margin: 1px 6px 1px 6px;">
                                     <%# Eval("StepNumber") %>.
                                     
                                     <%# Eval("Text") != String.Empty ? Eval("Text") : String.Empty %>
                                     <asp:PlaceHolder runat="Server" visible='<%# Eval("Action") != null && Eval("Text") != null && Eval("Text") != String.Empty %>'>
                                      - 
                                     </asp:PlaceHolder>
                                     <asp:PlaceHolder runat="Server" visible='<%# Eval("Action") != null %>'>
                                     <a href='<%# (Eval("Action") != null ? Navigator.GetLink("View", (IEntity)Eval("Action")) : String.Empty) %>'><%# Eval("Action") != null ? Eval("Action.Name") : String.Empty %></a>
                                     </asp:PlaceHolder>
                                     </div>
                                     </ItemTemplate>
                                                                          </asp:Repeater>
                                                                          <asp:placeholder runat="server" visible='<%# ((ScenarioStep[])Eval("Steps")).Length == 0 %>'>
																            <p><%= Language.NoStepsForScenario %></p>
																            </asp:placeholder>
                                                                          <hr/>
                                    </itemtemplate>
            </asp:Repeater>
            
            <asp:placeholder runat="server" visible='<%# ((Scenario[])ScenariosIndex.DataSource).Length == 0 %>'>
            <p><%= Language.NoScenariosForProject %></p>
            </asp:placeholder>
            <a name="Features"></a>
            <h2><%= Language.Features %>&nbsp;
            <span class="HeadingLinks"><a href='<%= Navigator.GetLink("Index", "Feature") %>'><%= Language.Index %></a>&nbsp;|&nbsp;<a href='<%= Navigator.GetLink("Create", "Feature") %>'><%= Language.Create %></a></span></h2>
            <asp:Repeater ID="FeaturesIndex" runat="server">
                			
                					<HeaderTemplate>
                                    	<table style="width: 100%;" cssclass="BodyPanel">
                					</HeaderTemplate>
                                    <ItemTemplate>
                                    	<tr>
                                    	<td colspan="2">
                                    	<h3>
                                    	<a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>' name='<%# "Features_" + HttpUtility.UrlEncode((string)Eval("Name")) %>'><%# Eval("Name") %></a>
                                    	</h3>
                                    	</td>
                                    	</tr>
                                    	<tr>
                                    	<td valign="top" style="width: 50%">
	                                    <p>
	                                    	<a href='<%# Navigator.GetLink("Index", "Action") %>'><%# Language.Actions + ":" %></a>
		                                    </p>
			                                    <asp:Repeater runat="server" datasource='<%# Eval("Actions") %>'>
				                                     <ItemTemplate>
				                                     	<p>
				                                     		&#8226; <a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'>
				                                     			<%# Eval("Name") %>
				                                     		</a>
				                                     	</p>
				                                     </ItemTemplate>
			                                     </asp:Repeater>
			                                    <asp:PlaceHolder runat="server" visible='<%# Eval("Actions") == null || ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[])Eval("Actions")).Length == 0 %>'>
			                                    	<ItemTemplate>
				                                     	<p class="NoDataText">
			                                    			&#8226; <%# Language.NoActionsForFeature %>
			                                    		</p>
			                                    	</ItemTemplate>
			                                    </asp:PlaceHolder>
		                                    </td>
		                                    <td valign="top" style="width: 50%">
	                                    	<p>
	                                    		<a href='<%# Navigator.GetLink("Index", "ProjectEntity") %>'><%# Language.Entities + ":"%></a>
	                                    	</p>
	                                    	
	                                    	<asp:Repeater runat="server" datasource='<%# Eval("Entities") %>'>
	                                     		<ItemTemplate>
	                                     			<p>
	                                     				&#8226; <a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'>
	                                     					<%# Eval("Name") %>
	                                     				</a>
		                                     		</p>
	                                     		</ItemTemplate>
	                                     	</asp:Repeater>
	                                     	<asp:PlaceHolder runat="server" visible='<%# Eval("Entities") == null || ((IEntity[])Eval("Entities")).Length == 0 %>'>
	                                     		<ItemTemplate>
			                                     	<p>
	                                     			&#8226; <span class="NoDataText"><%# Language.NoEntitiesForFeature %></span>
	                                     			</p>
	                                     		</ItemTemplate>
	                                     	</asp:PlaceHolder>
	                                    </td>
	                                    </tr>
	                                    <tr>
	                                    <td colspan="2">
                                    <hr>
                                    	</td>
                                    	</tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
	                                    </table>
                                    </FooterTemplate>
            </asp:Repeater>
            <asp:placeholder runat="server" visible='<%# ((Feature[])FeaturesIndex.DataSource).Length == 0 %>'>
            <table class="BodyPanel" cellspacing="0" cellpadding="0" DataKeyNames="ID" border="0" style="width:100%;border-collapse:collapse;">
            <tr class="ListItem"><td><%= Language.NoFeaturesForProject %></td></tr></table></asp:placeholder>
            <a name="Restraints"></a>
            <h2><%= Language.Restraints %>&nbsp;
            <span class="HeadingLinks"><a href='<%= Navigator.GetLink("Index", "Restraint") %>'><%= Language.Index %></a>&nbsp;|&nbsp;<a href='<%= Navigator.GetLink("Create", "Restraint") %>'><%= Language.Create %></a></span>
            </h2>
            <asp:Repeater ID="RestraintsIndex" runat="server">
                <ItemTemplate>
                                    <p><a name='<%# "Scenarios_" + HttpUtility.UrlEncode((string)Eval("Title")) %>' href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'><%# Eval("Title") %></a></p>
                                    <asp:placeholder runat="server" visible='<%# Eval("Details") != null && (string)Eval("Details") != String.Empty %>'>
                                    <p><%# Utilities.Summarize((String)Eval("Details"), 200) %></p>
                                    </asp:placeholder>
                </ItemTemplate>
            </asp:Repeater>
    </asp:View>
</asp:MultiView>