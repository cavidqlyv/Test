<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<script runat="server">
    private SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action currentAction;
    /// <summary>
    /// Gets/sets the action currently being worked on in the form.
    /// </summary>
    public SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action CurrentAction
    {
        get { return currentAction; }
        set { currentAction = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading the actions projection."))
    	{
	        switch (QueryStrings.Action)
	        {
	            case "CreateAction":
	    			if (!IsPostBack)
	                	CreateAction();
	                break;
	            case "ViewAction":
	                ViewAction(Utilities.GetQueryStringID("ActionID"));
	                break;
	            case "View":
	            	if (QueryStrings.GetID("Action") != Guid.Empty)
	            		ViewAction(QueryStrings.GetID("Action"));
	            	break;
	            case "Create":
	    			if (!IsPostBack)
	        		{
	                	if (QueryStrings.Type.ToLower() == "action")
	                		CreateAction();
	                	else
	                		throw new NotSupportedException("Type not supported: " + QueryStrings.Type);
					}
	            	break;
	            case "Edit":
	    			if (!IsPostBack)
	    			{
	                	if (QueryStrings.Type.ToLower() == "action")
	                	{
		                	if (QueryStrings.GetID("Action") != Guid.Empty)
		                		EditAction(QueryStrings.GetID("Action"));
	                	}
	                }
	            	break;
	            case "Delete":
	            	if (QueryStrings.Type.ToLower() == "action")
	            	{
	                	if (QueryStrings.GetID("Action") != Guid.Empty)
	                		DeleteAction(QueryStrings.GetID("Action"));
	            	}
	            	break;
	            default:
	            	if (!IsPostBack)
	                	ManageActions();
	                break;
	            
	        }
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        IndexGrid.AddSortItem(Language.Name + " " + Language.Asc, "NameAscending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Desc, "NameDescending");
        IndexGrid.AddSortItem(Language.Summary + " " + Language.Asc, "SummaryAscending");
        IndexGrid.AddSortItem(Language.Summary + " " + Language.Desc, "SummaryDescending");

        IndexGrid.AddDualSortItem(Language.VotesBalance, "VotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalVotes, "TotalVotes");
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing actions.
    /// </summary>
    public void ManageActions(int pageIndex)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Displaying the manage actions page."))
    	{
	        IndexGrid.CurrentPageIndex = pageIndex;
	
	        OperationManager.StartOperation("ManageActions", IndexView);
	
	        SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[] actions = null;
	
	        if (ProjectsState.EnsureProjectSelected())
	        {
	        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
	        
	            actions = IndexStrategy.New<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>(location, IndexGrid.CurrentSort).IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
		            
		        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
		        IndexGrid.DataSource = actions;
		
		        Authorisation.EnsureUserCan("View", actions);
		        
		        WindowTitle = Language.Actions + ": " + ProjectsState.ProjectName;
		
		        IndexView.DataBind();
	        }
		}
    }

    /// <summary>
    /// Displays the index on the first page for managing actions.
    /// </summary>
    public void ManageActions()
    {
        ManageActions(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new action.
    /// </summary>
    public void CreateAction()
    {
        SoftwareMonkeys.WorkHub.Web.Security.Authorisation.EnsureUserCan("Create", typeof(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action));

        OperationManager.StartOperation("CreateAction", FormView);
        
        ProjectsState.EnsureProjectSelected();

        SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action = new SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action();
        action.ID = Guid.NewGuid(); 
	    action.Project = ProjectsState.Project;
      
      	DataForm.DataSource = action;
      	
      	WindowTitle = Language.CreateAction;

        FormView.DataBind();
    }

    /// <summary>
    /// Displays the form for editing the specified action.
    /// </summary>
    /// <param name="actionID"></param>
    public void EditAction(Guid actionID)
    {
    	EditAction(RetrieveStrategy.New<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>().Retrieve<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("ID", actionID));
    }
    public void EditAction(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action)
    {
        OperationManager.StartOperation("EditAction", FormView);

        CurrentAction = action;
       
        
        DataForm.DataSource = action;
        
	        Authorisation.EnsureUserCan("Edit", action);
	
		WindowTitle = Language.EditAction + ": " + action.Name;

        FormView.DataBind();
    }  

    /// <summary>
    /// Saves the newly created action.
    /// </summary>
    private void SaveAction()
    {
        SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action = (SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DataForm.DataSource;
        
        DataForm.ReverseBind(action);

        action.Project = ProjectsState.Project;
        
        if (SaveStrategy.New<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>().Save(action))
        {
            
            // Display the result to the action
            Result.Display(Language.ActionSaved);

			if (Request.QueryString["AutoReturn"] != null && Request.QueryString["AutoReturn"].ToLower() == "true")
            	Close();
            else
            	Navigator.Go("View", action);
        }
        else
            Result.DisplayError(Language.ActionNameTaken);
    }

    private void UpdateAction()
    {
        // Get a fresh copy of the action object
        SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action = RetrieveStrategy.New<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>()
				.Retrieve<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("ID",
					((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DataForm.DataSource).ID);
      
      	ActivateStrategy.New(action).Activate(action);
      	
        // Transfer data from the form to the object
        DataForm.ReverseBind(action);

        // Update the action
        if (UpdateStrategy.New(action).Update(action))
        {
            // Display the result to the action
            Result.Display(Language.ActionUpdated);

            // Show the index again
            Navigator.Go("View", action);
        }
        else
        {
            Result.DisplayError(Language.ActionNameTaken);
        }
    }

    /// <summary>
    /// Deletes the action with the provided ID.
    /// </summary>
    /// <param name="actionID">The ID of the action to delete.</param>
    private void DeleteAction(Guid actionID)
    {
    	DeleteAction(RetrieveStrategy.New("Action").Retrieve<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("ID", actionID));
    }
    
    private void DeleteAction(string uniqueKey)
    {
    	DeleteAction(RetrieveStrategy.New("Action").Retrieve<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("ID", uniqueKey));
    }
    
    private void DeleteAction(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action)
    {
	    Authorisation.EnsureUserCan("Delete", action);
	
        // Delete the action
        DeleteStrategy.New(action).Delete(action);
        
        // Display the result
        Result.Display(Language.ActionDeleted);

        // Go back to the index
            Navigator.Go("Index", "Action");
    }

    /// <summary>
    /// Displays the details of the action with the specified ID.
    /// </summary>
    /// <param name="actionID">The ID of the action to display.</param>
    private void ViewAction(Guid actionID)
    {
    	ViewAction(RetrieveStrategy.New("Action").Retrieve<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("ID", actionID));
    }
    private void ViewAction(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action)
    {
    	if (action == null)
    		throw new ArgumentNullException("action");
    
        OperationManager.StartOperation("ViewAction", DetailsView);
        
        ActivateStrategy.New(action).Activate(action);

        action.Steps = Collection<ActionStep>.Sort(action.Steps, "StepNumberAscending");
        
        ActivateStrategy.New("Action").Activate(action.Steps, "Action");
        
        ActionStepsGrid.DataSource = action.Steps;

        // Assign the actors data
        ViewActionActors.DataSource = action.Actors;
        
        // Assign the features data
        ViewActionFeatures.DataSource = action.Features;
        
        ViewActionGoals.DataSource = action.Goals;
        
        ViewActionRestraints.DataSource = action.Restraints;


        ViewActionEntities.DataSource = action.Entities;

        DetailsForm.DataSource = action;
        
        WindowTitle = Language.Action + ": " + action.Name;
        
        DetailsView.DataBind();
    }

    /// <summary>
    /// Displays the form for creating a new action.
    /// </summary>
    public void CreateActionStep(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action parent)
    {
    	using (LogGroup logGroup = LogGroup.Start("Creating an action step.", NLog.LogLevel.Debug))
    	{
    		LogWriter.Debug("Parent ID: " + parent.ID.ToString());
    	
    		Navigator.Go("Create", "ActionStep", "Parent-ID", parent.ID.ToString());
    	}
    }


    /// <summary>
    /// Displays the form for editing the specified step.
    /// </summary>
    /// <param name="stepID"></param>
    public void EditActionStep(Guid stepID)
    {
    	Navigator.Go("Create", "ActionStep", stepID.ToString());
    }

    /// <summary>
    /// Moves the action step with the provided ID up one position.
    /// </summary>
    /// <param name="stepID">The ID of the step to move.</param>
    private void MoveActionStepUp(Guid stepID)
    {
        // Load the step
        ActionStep step = RetrieveStrategy.New<ActionStep>().Retrieve<ActionStep>("ID", stepID);

		ActivateStrategy.New<ActionStep>().Activate(step, "Parent");
		
		SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action parent = step.Parent;

        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", step);

        // Move the step
        MoveActionStepStrategy.New().MoveUp(step.ID);

        // Display the result
        Result.Display(Language.ActionStepUpdated);

		Navigator.Go("View", parent);
    }

    /// <summary>
    /// Moves the action step with the provided ID down one position.
    /// </summary>
    /// <param name="stepID">The ID of the step to move.</param>
    private void MoveActionStepDown(Guid stepID)
    {
        // Load the step
        ActionStep step = RetrieveStrategy.New<ActionStep>().Retrieve<ActionStep>("ID", stepID);

		ActivateStrategy.New<ActionStep>().Activate(step, "Parent");

		SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action parent = step.Parent;

        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", step);

        // Move the step
        MoveActionStepStrategy.New().MoveDown(step.ID);

        // Display the result
        Result.Display(Language.ActionStepUpdated);

		Navigator.Go("View", parent);
    }
    
    private void Close()
    {
    	PageView.SetActiveView(CloseView);
    }
    #endregion

    private void ActionStepsGrid_SortChanged(object sender, EventArgs e)
    {
        ViewAction(((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).ID);
    }

    protected void ActionStepsGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
       	if (e.CommandName == "MoveUp")
        {
            MoveActionStepUp(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveDown")
        {
            MoveActionStepDown(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new action
        Navigator.Go("Create", "Action");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditAction(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteAction(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewAction(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveAction();
        }
        else if (e.CommandName == "Update")
        {
            UpdateAction();
        }
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }

    protected void ActorSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Actor>().IndexWithReference<Actor>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void FeatureSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }
                     
    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageActions(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageActions(e.NewPageIndex);
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Navigator.Go("Edit", (IEntity)DetailsForm.DataSource);
    }

    private string FormatSteps(string[] steps)
    {
        if (steps == null)
            return String.Empty;
        
        string output = String.Empty;

        for (int i = 1; i <= steps.Length; i++)
        {
            if (steps[i-1] != String.Empty)
                output += i + ": " + steps[i-1] + "<br/>";
        }

        return output;
    }


    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<IEntity>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void EntitiesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<ProjectEntity>().IndexWithReference<ProjectEntity>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void GoalsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);
    }
    
    protected void RestraintsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Restraint>().IndexWithReference<Restraint>("Project", "Project", ProjectsState.ProjectID);
    }
    
    private void CreateActionStepButton_Click(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Clicked create action step button.", NLog.LogLevel.Debug))
    	{
        	CreateActionStep((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource);
        }
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">
            <div class="Heading1">
                        <%= Language.ManageActions %>
                    </div>
             
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageActionsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateAction %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = Navigator.GetLink("XmlLinks", "Action") %>'><%= Language.Xml %></a>
                        </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Actions %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoActionsForProject %>' OnItemCommand="IndexGrid_ItemCommand" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged">
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Eval("Name") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <asp:Panel runat="server" cssClass="Content" visible='<%# Eval("Summary") != null && Eval("Summary") != String.Empty %>'>
                                    <%# Utilities.Summarize((String)Eval("Summary"), 200) %>
                                    </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	 <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' />
									</itemtemplate>
                                </asp:TemplateColumn>
                              
                                <asp:TemplateColumn>
                                <ItemStyle width="80" wrap="false" horizontalalign="right" />
                            	<itemtemplate>
                                
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditActionToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'/>
                                &nbsp;<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteAction %>' ToolTip='<%# Language.DeleteActionToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateAction" ? Language.CreateAction : Language.EditAction %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateAction" ? Language.CreateActionIntro : Language.EditActionIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateAction" ? Language.NewActionDetails : Language.ActionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControlID="Name" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.ActionNameRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Summary" FieldControlID="Summary" text='<%# Language.Summary + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
			<ss:EntityFormItem runat="server" PropertyName="Goals" FieldControlID="Goals" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Goals + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Title" id="Goals" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Goals"
                                      NoSelectionText='<%# "-- " + Language.NoGoals + " --" %>' OnDataLoading='GoalsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
									  <ss:EntityFormItem runat="server" PropertyName="Features" FieldControlID="Features" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Features + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Name" id="Features" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.NoFeatures + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Features"
                                      OnDataLoading='FeatureSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
			
						  <ss:EntityFormItem runat="server" PropertyName="Actors" FieldControlID="Actors" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actors + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Name" id="Actors" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.NoActors + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actors"
                                      NoDataText='<%# "-- " + Language.NoActors + " --" %>' OnDataLoading='ActorSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
						  <ss:EntityFormItem runat="server" PropertyName="Restraints" FieldControlID="Restraints" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Restraints + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Restraint, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Title" id="Restraints" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.NoRestraints + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Restraints"
                                      NoDataText='<%# "-- " + Language.NoRestraints + " --" %>' OnDataLoading='RestraintsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
						  <ss:EntityFormItem runat="server" PropertyName="Entities" FieldControlID="Entities" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Entities + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.ProjectEntity, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Name" id="Entities" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.NoEntities + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Entities"
                                      NoDataText='<%# "-- " + Language.NoEntities + " --" %>' OnDataLoading='EntitiesSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateAction" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditAction" %>'></asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
	
			 	
                   <div class="Heading1">
                           <%# Language.Action + ": " + ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).Name %>
                   </div>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).Summary %></p>
                                   <p><asp:Button runat="Server" ID="ViewEditButton" Text='<%# Language.EditAction %>' CssClass="Button" OnClick="ViewEditButton_Click" />
                                    
                                     <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
									<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' />
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateAction" ? Language.NewActionDetails : Language.ActionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="ActionNameLabel" text='<%# Language.Name + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Summary" FieldControlID="SummaryLabel" text='<%# Language.Summary + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Project" FieldControlID="ProjectLabel" text='<%# Language.Project + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				</ss:EntityForm>
				<h2><%= Language.ActionSteps %></h2>
				<p class="Intro"><%= Language.ActionStepsIntro %></p>
				<p><input type='button' id="CreateActionStepButton" value='<%# Language.CreateActionStep %>' class="Button" onclick='<%# "location.href=\"" + Navigator.GetLink("Create", "ActionStep", "Parent-ID", ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).ID.ToString()) + "\"" %>' /></p>
				<p>
				<ss:IndexGrid ID="ActionStepsGrid" runat="server" DefaultSort="TextAscending" DataSource='<%# ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).Steps %>' OnSortChanged="ActionStepsGrid_SortChanged" AllowPaging="false"
                            DataKeyNames="ID" HeaderText='<%# Language.Steps %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="false" ShowHeader="false" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoActionStepsFound %>' OnItemCommand="ActionStepsGrid_ItemCommand">
                            <Columns>
                                                          <asp:TemplateColumn>
                                                          <ItemStyle width="5%"/>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("StepNumber") %>'></asp:Label>)
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                                            <asp:TemplateColumn>
                            <ItemStyle />
                                    <ItemTemplate>                                    
                                    <asp:Label runat="server" text='<%# Eval("Text") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                 <asp:TemplateColumn>
                            <ItemStyle/>
                                    <ItemTemplate>
                                    <asp:PlaceHolder runat="server"  Visible='<%# Eval("Action") != null %>'>
                                    <div class="Details">
                                    <%# Language.Action %>:&nbsp;<asp:Hyperlink runat="server" text='<%# Eval("Action") != null ? Eval("Action.Name") : String.Empty %>'  NavigateUrl='<%# ((ActionStep)Container.DataItem).Action == null ? String.Empty : Navigator.GetLink("View", ((ActionStep)Container.DataItem).Action) %>'></asp:Hyperlink>
                                    </div>
                                    </asp:PlaceHolder>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                            
                                <asp:LinkButton ID="MoveUpButton" CommandArgument='<%# Eval("ID") %>' runat="server" enabled='<%# (int)Eval("StepNumber") > 1 %>' text='<%# Language.Up %>' ToolTip='<%# Language.MoveActionStepUpToolTip %>' CommandName="MoveUp"></asp:LinkButton>&nbsp;<asp:LinkButton ID="MoveDownButton" CommandArgument='<%# Eval("ID") %>' ToolTip='<%# Language.MoveActionStepDownToolTip %>' runat="server" enabled='<%# (int)Eval("StepNumber") < ((SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action)DetailsForm.DataSource).Steps.Length %>' text='<%# Language.Down %>' CommandName="MoveDown"></asp:LinkButton>
                            </itemtemplate>
                        </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                            
                                
                             <ASP:Hyperlink id=EditButton runat="server" enabled='<%# Authorisation.UserCan("Edit", (ActionStep)Container.DataItem) %>' ToolTip='<%# Language.EditActionStepToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", "ActionStep", "ID", Eval("ID").ToString()) %>'>
																	</ASP:Hyperlink>
                                <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteActionStep %>' enabled='<%# Authorisation.UserCan("Delete", (ActionStep)Container.DataItem) %>' ToolTip='<%# Language.DeleteActionStepToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", "ActionStep", "ID", Eval("ID").ToString()) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
                        </p>
                 
				<h2><%= Language.Goals %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoGoalsForAction %>' id="ViewActionGoals" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                               							            <h2><%= Language.Features %></h2>
               <ss:EntityTree runat="server" NoDataText='<%# Language.NoFeaturesForAction %>' id="ViewActionFeatures" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
								            <h2><%= Language.Actors %></h2>
              <ss:EntityTree runat="server" NoDataText='<%# Language.NoActorsForAction %>' id="ViewActionActors" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                
                   <h2><%= Language.Restraints %></h2>
               <ss:EntityTree runat="server" NoDataText='<%# Language.NoRestraintsForAction %>' id="ViewActionRestraints" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Restraint, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                							                      <h2><%= Language.Entities %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoEntitiesForAction %>' id="ViewActionEntities" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.ProjectEntity, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
        <asp:View id="CloseView" runat="server">
                           <ss:EntitySelectDeliverer runat="server" id="DelivererToScenarioStep" TransferFields="Name"
			 	TextControlID="Name" EntityID='<%# DataForm.EntityID %>' SourceEntityType="ScenarioStep"/>
                            <ss:EntitySelectDeliverer runat="server" id="DelivererToActionStep" TransferFields="Name"
			 	TextControlID="Name" EntityID='<%# DataForm.EntityID %>' SourceEntityType="ActionStep"/>
        </asp:View>
    </asp:MultiView>
    