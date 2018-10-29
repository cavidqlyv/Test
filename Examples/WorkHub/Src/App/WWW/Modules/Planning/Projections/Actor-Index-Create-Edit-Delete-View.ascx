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
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    /// <summary>
    /// Gets/sets the current actor being viewed. It's persisted via viewstate.
    /// </summary>
    protected Actor CurrentActor
    {
        get { return (Actor)ViewState["CurrentActor"]; }
        set { ViewState["CurrentActor"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
    	switch (QueryStrings.Action)
        {
          
            case "CreateActor":
        		if (!IsPostBack)
                	CreateActor();
                break;
            case "ViewActor":
                ViewActor(Utilities.GetQueryStringID("ActorID"));
                break;
            case "Create":
        		if (!IsPostBack)
            		CreateActor();
            	break;
            case "View":
            	if (QueryStrings.GetID("Actor") != Guid.Empty)
            		ViewActor(QueryStrings.GetID("Actor"));
            	break;
            case "Edit":
        		if (!IsPostBack)
        		{
	            	if (QueryStrings.GetID("Actor") != Guid.Empty)
	            		EditActor(QueryStrings.GetID("Actor"));
            	}
            	break;
            case "Delete":
        		if (!IsPostBack)
        		{
	            	if (QueryStrings.GetID("Actor") != Guid.Empty)
	            		DeleteActor(QueryStrings.GetID("Actor"));
            	}
            	break;
            default:
                ManageActors();
                break;
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        IndexGrid.AddSortItem(Language.Name + " " + Language.Asc, "NameAscending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Desc, "NameDescending");
        IndexGrid.AddSortItem(Language.Description + " " + Language.Asc, "DescriptionAscending");
        IndexGrid.AddSortItem(Language.Description + " " + Language.Desc, "DescriptionDescending");
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Asc, "ProjectVersionAscending");
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Desc, "ProjectVersionDescending");

        IndexGrid.AddDualSortItem(Language.VotesBalance, "VotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalVotes, "TotalVotes");
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing actors.
    /// </summary>
    public void ManageActors(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
        
        OperationManager.StartOperation("ManageActors", IndexView);

        Actor[] actors = new Actor[] { };
        
        PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
        if (ProjectsState.EnsureProjectSelected())
        {
            actors = IndexStrategy.New<Actor>(location, IndexGrid.CurrentSort).IndexWithReference<Actor>("Project", "Project", ProjectsState.ProjectID);
                	
	    	IndexGrid.DataSource = actors;
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	
	        Authorisation.EnsureUserCan("View", actors);
	
			WindowTitle = Language.Actors + ": " + ProjectsState.ProjectName;
	
	        IndexView.DataBind();
                	
        }
        
        
    }

    /// <summary>
    /// Displays the index on the first page for managing actors.
    /// </summary>
    public void ManageActors()
    {
        ManageActors(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new actor.
    /// </summary>
    public void CreateActor()
    {
        SoftwareMonkeys.WorkHub.Web.Security.Authorisation.EnsureUserCan("Create", typeof(Actor));

        OperationManager.StartOperation("CreateActor", FormView);

        Actor actor = new Actor();
        actor.ID = Guid.NewGuid();
	    actor.Project = ProjectsState.Project;
       
      	DataForm.DataSource = actor;
      	
      	WindowTitle = Language.CreateActor;

        FormView.DataBind();
    }

    /// <summary>
    /// Displays the form for editing the specified actor.
    /// </summary>
    /// <param name="actorID"></param>
    public void EditActor(Guid actorID)
    {
    	EditActor(RetrieveStrategy.New<Actor>().Retrieve<Actor>("ID", actorID));
    }
    public void EditActor(Actor actor)
    {
        OperationManager.StartOperation("EditActor", FormView);

        
        ActivateStrategy.New<Actor>().Activate(actor);
        
        // TODO: Ensure that these are no longer needed. The IDs should be sufficient
        //actor.Goals = GoalFactory.Current.GetGoals(actor.GoalIDs);
       // actor.Actions = ActionFactory.Current.GetActions(actor.ActionIDs);
        
        DataForm.DataSource = actor;
        
	    Authorisation.EnsureUserCan("Edit", actor);
	
		WindowTitle = Language.EditActor + ": " + actor.Name;

        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created actor.
    /// </summary>
    private void SaveActor()
    {
        Actor actor = (Actor)DataForm.DataSource;
        
        // Save the new actor
        DataForm.ReverseBind(actor);
        
        actor.Project = ProjectsState.Project;
      
        if (SaveStrategy.New<Actor>().Save(actor))
        {    
            // Display the result to the actor
            Result.Display(Language.ActorSaved);

            // Show the index again
            Navigator.Go("View", actor);
        }
        else
            Result.DisplayError(Language.ActorNameTaken);
    }

    private void UpdateActor()
    {
        // Get a fresh copy of the actor object
        Actor actor = RetrieveStrategy.New<Actor>().Retrieve<Actor>("ID", DataForm.EntityID);
      
      	ActivateStrategy.New<Actor>().Activate(actor);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(actor);
        
        // Update the actor
        if (UpdateStrategy.New<Actor>().Update(actor))
        {
            // Display the result to the actor
            Result.Display(Language.ActorUpdated);

            // Show the index again
            Navigator.Go("Index", "Actor");
        }
        else
        {
            Result.DisplayError(Language.ActorNameTaken);
        }
    }

    /// <summary>
    /// Deletes the actor with the provided ID.
    /// </summary>
    /// <param name="actorID">The ID of the actor to delete.</param>
    private void DeleteActor(Guid actorID)
    {
    	DeleteActor(RetrieveStrategy.New<Actor>().Retrieve<Actor>("ID", actorID));
    }
    
    private void DeleteActor(Actor actor)
    {
	    Authorisation.EnsureUserCan("Delete", actor);
	
        // Delete the actor
        DeleteStrategy.New<Actor>().Delete(actor);
        
        // Display the result
        Result.Display(Language.ActorDeleted);

        // Go back to the index
        Navigator.Go("Index", "Actor");
    }

    /// <summary>
    /// Displays the details of the actor with the specified ID.
    /// </summary>
    /// <param name="actorID">The ID of the actor to display.</param>
    private void ViewActor(Guid actorID)
    {
    	ViewActor(RetrieveStrategy.New<Actor>().Retrieve<Actor>("ID", actorID));
    }
    

    private void ViewActor(Actor actor)
    {
        OperationManager.StartOperation("ViewActor", DetailsView);

	    Authorisation.EnsureUserCan("View", actor);
	    
        ActivateStrategy.New<Actor>().Activate(actor);
        
        DetailsForm.DataSource = actor;
        ViewActorGoals.DataSource = actor.Goals;
        ViewActorActions.DataSource = actor.Actions;
        ViewActorRestraints.DataSource = actor.Restraints;
        
		WindowTitle = Language.Actor + ": " + actor.Name;
        
        DetailsView.DataBind();
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new actor
        Navigator.Go("Create", "Actor");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditActor(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteActor(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewActor(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveActor();
        }
        else if (e.CommandName == "Update")
        {
            UpdateActor();
        }
    }

    protected void GoalsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    protected void RestraintsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Restraint>().IndexWithReference<Restraint>("Project", "Project", ProjectsState.ProjectID);
    }
    
    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageActors(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageActors(e.NewPageIndex);
    }
    
    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Navigator.GetLink("Edit", (Actor)DetailsForm.DataSource));
    }    
    
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageActors %>
                    </div>
              
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageActorsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateActor %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Actor") %>'><%= Language.Xml %></a>
                        </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Actors %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# ProjectsState.ProjectSelected ? Language.NoActorsForProject : Language.NoActorsFound %>' OnItemCommand="IndexGrid_ItemCommand" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged">
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Eval("Name") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <asp:Panel runat="server" cssClass="Content" visible='<%# Eval("Description") != null && Eval("Description") != String.Empty %>'>
                                    <%# Utilities.Summarize((String)Eval("Description"), 200) %>
                                    </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("ProjectVersion") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# Container.DataItem %>' PropertyValuesString="BalanceProperty=VotesBalance&TotalProperty=TotalVotes" />
																	</div>
</itemtemplate>
                                </asp:TemplateColumn>
                                  			<asp:TemplateColumn>
                                  			<ItemStyle width="80" wrap="false" horizontalalign="right" />
                            <itemtemplate>
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditActorToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteActor %>' ToolTip='<%# Language.DeleteActorToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateActor" ? Language.CreateActor : Language.EditActor %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateActor" ? Language.CreateActorIntro : Language.EditActorIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateActor" ? Language.NewActorDetails : Language.ActorDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControlID="ActorName" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.ActorNameRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
			
						  <ss:EntityFormItem runat="server" PropertyName="Goals" FieldControlID="Goals" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Goals + ":" %>' visible='<%# ((IEntity[])((EntitySelect)FindControl("Goals")).DataSource).Length > 0 %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" width="400px" runat="server"
                                      TextPropertyName="Title" id="Goals" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectGoals + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Goals"
                                      NoDataText='<%# "-- " + Language.NoGoals + " --" %>' OnDataLoading='GoalsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          	  <ss:EntityFormItem runat="server" PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actions + ":" %>' visible='<%# ((IEntity[])((EntitySelect)FindControl("Actions")).DataSource).Length > 0 %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" width="400px" runat="server"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectActions + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions"
                                      NoDataText='<%# "-- " + Language.NoActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
						  <ss:EntityFormItem runat="server" PropertyName="Restraints" FieldControlID="Restraints" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Restraints + ":" %>' visible='<%# ((IEntity[])((EntitySelect)FindControl("Restraints")).DataSource).Length > 0 %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Restraint, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Title" id="Restraints" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectRestraints + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Restraints"
                                      NoDataText='<%# "-- " + Language.NoRestraints + " --" %>' OnDataLoading='RestraintsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                         
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateActor" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditActor" %>'></asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <h1>
                           <%# Language.Actor + ": " + ((Actor)DetailsForm.DataSource).Name %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((Actor)DetailsForm.DataSource).Description %></p>  
                                   <p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditActor %>' CssClass="Button" OnClick="ViewEditButton_Click" />
                                     <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString="BalanceProperty=VotesBalance&TotalProperty=TotalVotes" /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateActor" ? Language.NewActorDetails : Language.ActorDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="ActorNameLabel" text='<%# Language.Name + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Description" FieldControlID="ActorDescriptionLabel" text='<%# Language.Description + ":" %>'></ss:EntityFormLabelItem>
				<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ActorProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				
				</ss:EntityForm>
				<asp:placeholder runat="server" visible='<%# ((Actor)DetailsForm.DataSource).Goals.Length > 0 %>'>
				            <h2><%= Language.Goals %></h2>
                <ss:EntityTree runat="server" id="ViewActorGoals" NoDataText='<%# Language.NoGoalsForActor %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning" BranchesProperty="Prerequisites">
                </ss:EntityTree>
               	</asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Actor)DetailsForm.DataSource).Actions.Length > 0 %>'>
                		            <h2><%= Language.Actions %></h2>
               <ss:EntityTree runat="server" id="ViewActorActions" NoDataText='<%# Language.NoActionsForActor %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
               	</asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Actor)DetailsForm.DataSource).Restraints.Length > 0 %>'>
                   <h2><%= Language.Restraints %></h2>
               <ss:EntityTree runat="server" id="ViewActorRestraints" NoDataText='<%# Language.NoRestraintsForActor %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Restraint, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                </asp:placeholder>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
    </asp:MultiView>