<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="lc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (QueryStrings.Action)
        {
          
            case "CreateScenario":
    			if (!IsPostBack)
                	CreateScenario();
                break;
            case "ViewScenario":
                ViewScenario(Utilities.GetQueryStringID("ScenarioID"));
                break;
            case "View":
				if (QueryStrings.GetID("Scenario") != Guid.Empty)
		            ViewScenario(QueryStrings.GetID("Scenario"));
				break;
		    case "Create":
		        if (!IsPostBack)
		        {
			    	if (QueryStrings.Type == "Scenario")
			    	{
				        CreateScenario();
					}
					else
					{
				        CreateScenarioStep(RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", QueryStrings.GetID("Scenario")));
					}
				}
				break;
		    case "Edit":
		        if (!IsPostBack)
		        {
			    	if (QueryStrings.Type == "Scenario")
			    	{
						if (QueryStrings.GetID("Scenario") != Guid.Empty)
				            EditScenario(QueryStrings.GetID("Scenario"));
					}
				}
				break;
		    case "Delete":
		    	if (!IsPostBack)
		    	{
			    	if (QueryStrings.Type == "Scenario")
			    	{
						if (QueryStrings.GetID("Scenario") != Guid.Empty)
				            DeleteScenario(QueryStrings.GetID("Scenario"));
					}

				}
				break;
            default:
                ManageScenarios();
                break;
        }
        
    }

    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        
        IndexGrid.AddSortItem(Language.Name + " " + Language.Asc, "NameAscending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Desc, "NameDescending");

        IndexGrid.AddDualSortItem(Language.VotesBalance, "VotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalVotes, "TotalVotes");
    }

    private void Projects_ProjectIDChanged(object sender, EventArgs e)
    {
        ManageScenarios();
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing scenarios.
    /// </summary>
    public void ManageScenarios(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
        
        OperationManager.StartOperation("ManageScenarios", IndexView);

        Scenario[] scenarios = null;
        int total = 0;

        if (ProjectsState.EnsureProjectSelected())
        {
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
            scenarios = IndexStrategy.New<Scenario>(location, IndexGrid.CurrentSort).IndexWithReference<Scenario>("Project", "Project", ProjectsState.ProjectID);            

	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        IndexGrid.DataSource = scenarios;
	
	        Authorisation.EnsureUserCan("View", scenarios);
	        
        	WindowTitle = Language.Scenarios + ": " + ProjectsState.ProjectName;
	
	        IndexView.DataBind();
        }
    }
    
    /// <summary>
    /// Displays the index on the first page for managing scenarios.
    /// </summary>
    public void ManageScenarios()
    {
        ManageScenarios(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new scenario.
    /// </summary>
    public void CreateScenario()
    {
        // Ensure that the user can create a new scenario
        Authorisation.EnsureUserCan("Create", typeof(Scenario));

        if (ProjectsState.EnsureProjectSelected())
        {
            // Declare the current operation
            OperationManager.StartOperation("CreateScenario", FormView);

            // Create the default scenario
            Scenario scenario = new Scenario();
            scenario.ID = Guid.NewGuid();
            scenario.Project = ProjectsState.Project;
	    // TODO: Add default values    

            // Assign the default scenario to the form
            DataForm.DataSource = scenario;
            
        	WindowTitle = Language.CreateScenario;

            // Bind the form
            FormView.DataBind();
        }
    }
    
    /// <summary>
    /// Displays the form for editing the specified scenario.
    /// </summary>
    /// <param name="scenarioID"></param>
    public void EditScenario(Guid scenarioID)
    {
        Scenario scenario = RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", scenarioID);
        
        EditScenario(scenario);
    }
    /// <summary>
    /// Displays the form for editing the specified scenario.
    /// </summary>
    /// <param name="scenario"></param>
    public void EditScenario(Scenario scenario)
    {
        // Declare the current operation
        OperationManager.StartOperation("EditScenario", FormView);
        
        ActivateStrategy.New<Scenario>().Activate(scenario);
        
        DataForm.DataSource = scenario;

        // Ensure that the user can edit the specified scenario
        Authorisation.EnsureUserCan("Edit", (Scenario)DataForm.DataSource);
        
        WindowTitle = Language.EditScenario + ": " + scenario.Name;

        // Bind the form
        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created scenario.
    /// </summary>
    private void SaveScenario()
    {
        // Reverse bind the data back to the object
        DataForm.ReverseBind();
        
        Scenario scenario = (Scenario)DataForm.DataSource;

        // Save the new scenario
        if (SaveStrategy.New<Scenario>().Save(scenario))
        {
            // Display the result to the scenario
            Result.Display(Language.ScenarioSaved);

            Navigator.Go("View", scenario);
        }
        else
            Result.Display(Language.ScenarioNameTaken);
    }

    /// <summary>
    /// Updates the scenario.
    /// </summary>
    private void UpdateScenario()
    {
        // Get a fresh copy of the scenario object
        Scenario scenario = RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", DataForm.EntityID);
      
      	ActivateStrategy.New<Scenario>().Activate(scenario);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(scenario);

        // Update the new scenario
        if (UpdateStrategy.New<Scenario>().Update(scenario))
        {
            // Display the result to the scenario
            Result.Display(Language.ScenarioUpdated);

            Navigator.Go("View", scenario);
        }
        else
            Result.Display(Language.ScenarioNameTaken);

    }

    /// <summary>
    /// Deletes the scenario with the provided ID.
    /// </summary>
    /// <param name="scenarioID">The ID of the scenario to delete.</param>
    private void DeleteScenario(Guid scenarioID)
    {
        DeleteScenario(RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", scenarioID));
    }
        private void DeleteScenario(Scenario scenario)
    {
        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("Delete", scenario);

        // Delete the scenario
        DeleteStrategy.New<Scenario>().Delete(scenario);
        
        // Display the result
        Result.Display(Language.ScenarioDeleted);

        // Go back to the index
        ManageScenarios();
    }

    /// <summary>
    /// Displays the details of the scenario with the specified ID.
    /// </summary>
    /// <param name="scenarioID"></param>
    private void ViewScenario(Guid scenarioID)
    {
        ViewScenario(RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", scenarioID));
    }
    
    /// <summary>
    /// Displays the details of the scenario with the specified ID.
    /// </summary>
    /// <param name="scenario"></param>
    private void ViewScenario(Scenario scenario)
    {
    	if (scenario == null)
    		Navigator.Go("Index", "Scenario");
    	else
    	{
	        // Declare the current operation
	        OperationManager.StartOperation("ViewScenario", DetailsView);
	
	        // Load the specified scenario for the form
	        //Scenario scenario = RetrieveStrategy.New<Scenario>().Retrieve<Scenario>("ID", scenarioID);
	        
	        ActivateStrategy.New<Scenario>().Activate(scenario, "Steps");
	        ActivateStrategy.New<ScenarioStep>().Activate(scenario.Steps, "Action");
	
	        // Sort the steps by the step numbers
	        scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
	        
	        // Refresh the step numbers in case any steps have been removed
	        //scenario.RefreshStepNumbers();
	
	        DetailsForm.DataSource = scenario;
	
	        // Ensure that the user is authorised to view the data
	        Authorisation.EnsureUserCan("View", (Scenario)DetailsForm.DataSource); 
	        
	        WindowTitle = Language.Scenario + ": " + scenario.Name;
	
	        // Bind the form
	        DetailsView.DataBind();
        }
    }
    

    public void CreateScenarioStep(Scenario scenario)
    {
        Navigator.Go("Create", "ScenarioStep", "Parent-ID", scenario.ID.ToString());
    }
    
    /// <summary>
    /// Moves the scenario step with the provided ID up one position.
    /// </summary>
    /// <param name="stepID">The ID of the step to move.</param>
    private void MoveScenarioStepUp(Guid stepID)
    {
    	using (LogGroup logGroup = LogGroup.Start("Moving the specified scenario step up one position in the list.", NLog.LogLevel.Debug))
    	{
	        // Load the step
	        ScenarioStep step = RetrieveStrategy.New<ScenarioStep>().Retrieve<ScenarioStep>("ID", stepID);
	        
	        // TODO: Check if there is a more efficient way to do this
	        ActivateStrategy.New<ScenarioStep>().Activate(step, "Scenario");
	
	        Scenario parent = step.Scenario;
	        
	        // Ensure that the user is authorised to delete the data
	        Authorisation.EnsureUserCan("Edit", step);
	
	        // Move the step
	        MoveScenarioStepStrategy.New().MoveUp(step.ID);
	
	        // Display the result
	        Result.Display(Language.ScenarioStepUpdated);
	
	        // Go back to the view page
	        Navigator.Go("View", parent);
        }
    }

    /// <summary>
    /// Moves the scenario step with the provided ID down one position.
    /// </summary>
    /// <param name="stepID">The ID of the step to move.</param>
    private void MoveScenarioStepDown(Guid stepID)
    {
    	using (LogGroup logGroup = LogGroup.Start("Moving the specified scenario step down one position in the list.", NLog.LogLevel.Debug))
    	{
	        // Load the step
	        ScenarioStep step = RetrieveStrategy.New<ScenarioStep>().Retrieve<ScenarioStep>("ID", stepID);
	
	        // TODO: Check if there is a more efficient way to do this
	        ActivateStrategy.New<ScenarioStep>().Activate(step, "Scenario");
	        
	        Scenario parent = step.Scenario;
	        
	        // Ensure that the user is authorised to delete the data
	        Authorisation.EnsureUserCan("Edit", step);
	
	        // Move the step
		        MoveScenarioStepStrategy.New().MoveDown(step.ID);
	
	        // Display the result
	        Result.Display(Language.ScenarioStepUpdated);
		        Navigator.Go("View", parent);
        }
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new scenario
        Navigator.Go("Create", "Scenario");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditScenario(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteScenario(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewScenario(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveScenario();
        }
        else if (e.CommandName == "Update")
        {
            UpdateScenario();
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageScenarios();
    }                     
                 

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageScenarios(e.NewPageIndex);
    }

    private void CancelButton_Click(object sender, EventArgs e)
    {
        if (OperationManager.PreviousOperation == "ViewScenario")
            Navigator.Go("View", (Scenario)DetailsForm.DataSource);
        else
            Navigator.Go("Index", "Scenario");
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Navigator.Go("Edit", (Scenario)DetailsForm.DataSource);
    }
    
    private void ScenarioStepsGrid_SortChanged(object sender, EventArgs e)
    {
        ViewScenario(DetailsForm.EntityID);
    }

    protected void ScenarioStepsGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Navigator.Go("Edit", "ScenarioStep", "ID", e.CommandArgument.ToString());
        }
        else if (e.CommandName == "Delete")
        {
            Navigator.Go("Delete", "ScenarioStep", "ID", e.CommandArgument.ToString());
        }
        else if (e.CommandName == "MoveUp")
        {
            MoveScenarioStepUp(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveDown")
        {
            MoveScenarioStepDown(new Guid(e.CommandArgument.ToString()));
        }
    }

    private void CreateScenarioStepButton_Click(object sender, EventArgs e)
    {
        CreateScenarioStep(((Scenario)DetailsForm.DataSource));
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">


            <H1>
                        <%= Language.ManageScenarios %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageScenariosIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateScenario %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = Navigator.GetLink("XmlLinks", "Scenario") %>'><%= Language.Xml %></a>
                        </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Scenarios %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoScenariosForProject %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
                              
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Eval("Name") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <div class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Description") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Description") : "&nbsp;", 200) %></div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                               
                                                                  <asp:TemplateColumn>
                                                                  <ItemStyle />
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# (string)Eval("ProjectVersion") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' /></div>
</itemtemplate>
                                </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditScenarioToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
                                <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteScenario %>' ToolTip='<%# Language.DeleteScenarioToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateScenario" ? Language.CreateScenario : Language.EditScenario %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateScenario" ? Language.CreateScenarioIntro : Language.EditScenarioIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateScenario" ? Language.NewScenarioDetails : Language.ScenarioDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControlID="ScenarioName" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.ScenarioNameRequired %>'></ss:EntityFormTextBoxItem>
				
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="8"></ss:EntityFormTextBoxItem>
				 <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateScenario" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditScenario" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
				   
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <H1>
                           <%# Language.Scenario + ": " + ((Scenario)DetailsForm.DataSource).Name %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p>
                                    <%# ((Scenario)DetailsForm.DataSource).Description %></p>  
<p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditScenario %>' OnClick="ViewEditButton_Click" CssClass="Button" />
                                    <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' />
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# Language.ScenarioDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
								<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				
							</ss:EntityForm>
				<h2><%= Language.ScenarioSteps %></h2>
			<p><%= Language.ScenarioStepsIntro %></p>
                        <div id="ActionsContainer">
					<div id="ActionButtons"><asp:Button runat="server" ID="CreateScenarioStepButton" text='<%# Language.CreateScenarioStep %>' OnClick="CreateScenarioStepButton_Click" /></div>
						</div>
				
				<ss:IndexGrid ID="ScenarioStepsGrid" runat="server" DefaultSort="TextAscending" DataSource='<%# ((Scenario)DetailsForm.DataSource).Steps %>' OnSortChanged="ScenarioStepsGrid_SortChanged" AllowPaging="false"
                            DataKeyNames="ID" HeaderText='<%# Language.Steps %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="false" ShowHeader="false" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoStepsForScenario %>' OnItemCommand="ScenarioStepsGrid_ItemCommand">
                            <Columns>
                                                          <asp:TemplateColumn>
                                                          <ItemStyle verticalalign="top" height="100%" width="30px" />
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("StepNumber") %>'></asp:Label>)
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                                            <asp:TemplateColumn>
                            <ItemStyle />
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Label runat="server" text='<%# Eval("Text") %>'></asp:Label>
                                    </div>
                                    
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                            <ItemStyle/>
                                    <ItemTemplate>
                                    <asp:PlaceHolder runat="server"  Visible='<%# Eval("Action") != null %>'>
                                    <div class="Details">
                                    <%# Language.Action %>:&nbsp;<asp:Hyperlink runat="server" text='<%# Eval("Action") != null ? Eval("Action.Name") : String.Empty %>'  NavigateUrl='<%# ((ScenarioStep)Container.DataItem).Action == null ? String.Empty : Navigator.GetLink("View", ((ScenarioStep)Container.DataItem).Action) %>'></asp:Hyperlink>
                                    </div>
                                    </asp:PlaceHolder>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              <asp:TemplateColumn>
                            <ItemStyle width="60px" wrap="false" horizontalalign="center" />
                            <itemtemplate>
                            
                                <asp:LinkButton ID="MoveUpButton" CommandArgument='<%# Eval("ID") %>' runat="server" enabled='<%# (int)Eval("StepNumber") > 1 %>' text='<%# Language.Up %>' ToolTip='<%# Language.MoveScenarioStepUpToolTip %>' CommandName="MoveUp"></asp:LinkButton>
                                <br/><asp:LinkButton ID="MoveDownButton" CommandArgument='<%# Eval("ID") %>' ToolTip='<%# Language.MoveScenarioStepDownToolTip %>' runat="server" enabled='<%# (int)Eval("StepNumber") < ((Scenario)DetailsForm.DataSource).Steps.Length %>' text='<%# Language.Down %>' CommandName="MoveDown"></asp:LinkButton>
                            </itemtemplate>
                        </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="60px" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                             <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditScenarioStepToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", "ScenarioStep", "ID", Eval("ID").ToString()) %>'>
																	</ASP:Hyperlink><br/>
                                <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteScenarioStep %>' ToolTip='<%# Language.DeleteScenarioStepToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", "ScenarioStep", "ID", Eval("ID").ToString()) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>

    </asp:MultiView>