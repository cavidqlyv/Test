<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    
    /// <summary>
    /// Gets/sets the current milestone being viewed. It's persisted via viewstate.
    /// </summary>
    protected Milestone CurrentMilestone
    {
        get { return (Milestone)ViewState["CurrentMilestone"]; }
        set { ViewState["CurrentMilestone"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (ProjectsState.EnsureProjectSelected())
            {
                switch (QueryStrings.Action)
                {
                    case "CreateMilestone":
                        CreateMilestone();
                        break;
                    case "Create":
                        CreateMilestone();
                        break;
                    case "ViewMilestone":
                        ViewMilestone(Utilities.GetQueryStringID("MilestoneID"));
                        break;
	                case "View":
	                	if (QueryStrings.GetID("Milestone") != Guid.Empty)
	                		ViewMilestone(QueryStrings.GetID("Milestone"));
	                	break;
	                case "Edit":
	                	if (QueryStrings.GetID("Milestone") != Guid.Empty)
	                		EditMilestone(QueryStrings.GetID("Milestone"));
	                	break;
	                case "Delete":
	                	if (QueryStrings.GetID("Milestone") != Guid.Empty)
	                		DeleteMilestone(QueryStrings.GetID("Milestone"));
	                	break;
	                case "MoveUp":
	                	if (QueryStrings.GetID("Milestone") != Guid.Empty)
	                		MoveMilestoneUp(QueryStrings.GetID("Milestone"));
	                	break;
	                case "MoveDown":
	                	if (QueryStrings.GetID("Milestone") != Guid.Empty)
	                		MoveMilestoneDown(QueryStrings.GetID("Milestone"));
	                	break;
                    default:
                        ManageMilestones();
                        break;
                }
            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        IndexGrid.AddSortItem(Language.Deadline + " " + Language.Asc, "DeadlineAscending");
        IndexGrid.AddSortItem(Language.Deadline + " " + Language.Desc, "DeadlineDescending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        IndexGrid.AddDualSortItem(Language.TotalTasks, "TotalTasks");
                
        base.OnInit(e);
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing milestones.
    /// </summary>
    public void ManageMilestones()
	{
		ManageMilestones(QueryStrings.PageIndex);
	}

    /// <summary>
    /// Displays the index for managing milestones.
    /// </summary>
    public void ManageMilestones(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;

        OperationManager.StartOperation("ManageMilestones", IndexView);

		int total = 0;
        Milestone[] milestones = null;

		if (ProjectsState.EnsureProjectSelected())
        {
			PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
			
			milestones = IndexStrategy.New<Milestone>(location, IndexGrid.CurrentSort).IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
		
			IndexGrid.VirtualItemCount = location.AbsoluteTotal;
			IndexGrid.DataSource = milestones;
	
	        Authorisation.EnsureUserCan("View", milestones);
	        
    		WindowTitle = Language.Milestones;
    		if (ProjectsState.ProjectSelected)
    			WindowTitle = Language.Milestones + ": " + ProjectsState.ProjectName;
	
	        IndexView.DataBind();
		}
    }

    /// <summary>
    /// Displays the form for creating a new milestone.
    /// </summary>
    public void CreateMilestone()
    {
		using (LogGroup logGroup = LogGroup.Start("Displays a form for creating a milestone.", NLog.LogLevel.Debug))
		{
	            Authorisation.EnsureUserCan("Create", typeof(Milestone));
	
	            OperationManager.StartOperation("CreateMilestone", FormView);
	
	            Milestone milestone = new Milestone();
	            milestone.ID = Guid.NewGuid();
	            milestone.Project = ProjectsState.Project;
				milestone.Deadline = DateTime.Now.AddMonths(2);
		
			    LogWriter.Debug("New milestone ID: " + milestone.ID);
	
	      	    DataForm.DataSource = milestone;
	      	    
        		WindowTitle = Language.CreateMilestone;
	
	            FormView.DataBind();
		}
    }

    /// <summary>
    /// Displays the form for editing the specified milestone.
    /// </summary>
    /// <param name="milestoneID"></param>
    private void EditMilestone(Guid milestoneID)
    {
    	EditMilestone(RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID));
    }
    
    private void EditMilestone(Milestone milestone)
    {
		using (LogGroup logGroup = LogGroup.Start("Displays a form for editing a milestone.", NLog.LogLevel.Debug))
		{
	            OperationManager.StartOperation("EditMilestone", FormView);
	
	            
	            ActivateStrategy.New<Milestone>().Activate(milestone);
	            
	           // milestone.Prerequisites = MilestoneFactory.Current.GetMilestones(milestone.PrerequisiteIDs);
	            DataForm.DataSource = milestone;
	
	            Authorisation.EnsureUserCan("Edit", milestone);
	            
        		WindowTitle = Language.EditMilestone + ": " + milestone.Title;
	
	            FormView.DataBind();
		}
    }

    /// <summary>
    /// Saves the newly created milestone.
    /// </summary>
    private void SaveMilestone()
    {
    	Milestone milestone = (Milestone)DataForm.DataSource;
    
        // Save the new milestone
        DataForm.ReverseBind(milestone);
        
        Milestone[] milestones = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
        
        milestone.MilestoneNumber = milestones.Length + 1;
        
        if (SaveStrategy.New<Milestone>().Save(milestone))
        {
            // Display the result to the milestone
            Result.Display(Language.MilestoneSaved);

            // Show the index again
        	Navigator.Go("View", milestone);
        }
        else
            Result.DisplayError(Language.MilestoneTitleTaken);
    }

    private void UpdateMilestone()
    {
        // Get a fresh copy of the milestone object
        Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>(((Milestone)DataForm.DataSource).ID);

		ActivateStrategy.New<Milestone>().Activate(milestone);

        // Get the original title of the milestone before binding the new data
        string originalTitle = milestone.Title;
        
        // Transfer data from the form to the object
        DataForm.ReverseBind(milestone);

        // Update the milestone
        if (UpdateStrategy.New<Milestone>().Update(milestone))
        {
            // Display the result to the milestone
            Result.Display(Language.MilestoneUpdated);

            // Show the index again
        	Navigator.Go("Index", "Milestone");
        }
        else
        {
            Result.DisplayError(Language.MilestoneTitleTaken);
        }
    }

    /// <summary>
    /// Deletes the milestone with the provided ID.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to delete.</param>
    private void DeleteMilestone(Guid milestoneID)
    {
    	DeleteMilestone(RetrieveStrategy.New<Milestone>().Retrieve<Milestone>(
    			"ID", milestoneID));
    }
        
    private void DeleteMilestone(Milestone milestone)
    {

		Authorisation.EnsureUserCan("Delete", milestone);

        // Delete the milestone
        DeleteStrategy.New<Milestone>().Delete(milestone);
        
        // Display the result
        Result.Display(Language.MilestoneDeleted);

        // Go back to the index
        	Navigator.Go("Index", "Milestone");
    }

    /// <summary>
    /// Displays the details of the milestone with the specified ID.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to display.</param>
    private void ViewMilestone(Guid milestoneID)
    {
    	ViewMilestone(RetrieveStrategy.New<Milestone>().Retrieve<Milestone>(
    			"ID", milestoneID));
    }
    
    private void ViewMilestone(Milestone milestone)
    {
        OperationManager.StartOperation("ViewMilestone", DetailsView);

        CurrentMilestone = milestone;
        DetailsForm.DataSource = milestone;
        
        // TODO: Check if needed
        //ActivateStrategy.New<Milestone>().Activate(milestone, 2);
        ActivateStrategy.New<Milestone>().Activate(milestone);
        
        // TODO: Check if activate function takes care of this
        //ViewMilestonePrerequisites.DataSource = MilestoneFactory.Current.GetMilestones(milestone.PrerequisiteIDs); // TODO: Remove code
        /*CurrentMilestone.Prerequisites = MilestoneFactory.Current.GetMilestones(CurrentMilestone.PrerequisiteIDs);
        CurrentMilestone.Tasks = TaskFactory.Current.GetTasks(CurrentMilestone.TaskIDs);
        MilestoneFactory.Current.LoadPrerequisitesTree(CurrentMilestone);
        MilestoneFactory.Current.LoadSubMilestonesTree(CurrentMilestone);*/
        ViewMilestonePrerequisites.DataSource = CurrentMilestone.Prerequisites;
        ViewMilestoneSubMilestones.DataSource = CurrentMilestone.SubMilestones;
        ViewMilestoneTasks.DataSource = CurrentMilestone.Tasks;
        
        WindowTitle = Language.Milestone + ": " + CurrentMilestone.Title;
        
        
		Authorisation.EnsureUserCan("View", milestone);
        
        DetailsView.DataBind();
    }
    
    

    /// <summary>
    /// Moves the milestone with the provided ID up one position.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to move.</param>
    private void MoveMilestoneUp(Guid milestoneID)
    {
    	using (LogGroup logGroup = LogGroup.Start("Moving the specified milestone up one position in the list.", NLog.LogLevel.Debug))
    	{
        // Load the milestone
        Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);
        
        // TODO: Check if there is a more efficient way to do this
        ActivateStrategy.New<Milestone>().Activate(milestone, "Project");

        Guid projectID = milestone.Project.ID;
        
        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", milestone);

        // Move the milestone
        MoveMilestoneStrategy.New().MoveUp(milestone.ID);

        // Display the result
        Result.Display(Language.MilestoneUpdated);

        // Go back to the index
        	Navigator.Go("Index", "Milestone");
        }
    }

    /// <summary>
    /// Moves the milestone with the provided ID down one position.
    /// </summary>
    /// <param name="milestoneID">The ID of the milestone to move.</param>
    private void MoveMilestoneDown(Guid milestoneID)
    {
    	using (LogGroup logGroup = LogGroup.Start("Moving the specified milestone down one position in the list.", NLog.LogLevel.Debug))
    	{
        // Load the milestone
        Milestone milestone = RetrieveStrategy.New<Milestone>().Retrieve<Milestone>("ID", milestoneID);

        // TODO: Check if there is a more efficient way to do this
        ActivateStrategy.New<Milestone>().Activate(milestone, "Project");
        
        Guid projectID = milestone.Project.ID;
        
        // Ensure that the user is authorised to delete the data
        Authorisation.EnsureUserCan("Edit", milestone);

        // Move the milestone
        MoveMilestoneStrategy.New().MoveDown(milestone.ID);

        // Display the result
        Result.Display(Language.MilestoneUpdated);

        // Go back to the index
        	Navigator.Go("Index", "Milestone");
        }
    }

    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Create", "Milestone");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveUp")
        {
            MoveMilestoneUp(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "MoveDown")
        {
            MoveMilestoneDown(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveMilestone();
        }
        else if (e.CommandName == "Update")
        {
            UpdateMilestone();
        }
    }

    protected void PrerequisitesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
    }
    
    protected void SubMilestonesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
    }
    
    protected void TasksSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().IndexWithReference<Task>("Project", "Project", ProjectsState.ProjectID);
    }


    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    protected void ViewPrerequisitesGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteMilestone(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewMilestone(new Guid(e.CommandArgument.ToString()));
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageMilestones(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageMilestones(e.NewPageIndex);
    }
    
    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Navigator.GetLink("Edit", (Milestone)DetailsForm.DataSource));
    }    
    
    private void ViewRoadmapButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(Navigator.GetLink("Roadmap"));
    }
    
    bool IsFirst(Milestone milestone)
    {
    	return Array.IndexOf(IndexGrid.DataSource, milestone) == 0;
    }
    
    bool IsLast(Milestone milestone)
    {
    	return Array.IndexOf(IndexGrid.DataSource, milestone) == ((Milestone[])IndexGrid.DataSource).Length-1;
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageMilestones %>
                    </div>
              
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageMilestonesIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateMilestone %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                 <asp:Button ID="ViewRoadmapButton" runat="server" Text='<%# Language.ViewRoadmap + " &raquo;" %>'
                                CssClass="Button" OnClick="ViewRoadmapButton_Click"></asp:Button>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="TitleAscending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Milestones %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="False" Width="100%"
                            EmptyDataText='<%# Language.NoMilestonesForProject %>' OnItemCommand="IndexGrid_ItemCommand" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged">
                            <Columns>
                            <asp:TemplateColumn>
                                    <itemstyle width="20px"></itemstyle>
                                    <itemtemplate>
                                    <div><%# (int)Eval("MilestoneNumber") %>.</div>
                                    <asp:placeholder runat="server" visible='<%# Eval("Description") != String.Empty %>'>
                                    <div>&nbsp;</div>
                                    </asp:placeholder>
                                    
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    <div>
                                    <asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink><%# (bool)Eval("EnableDeadline") ? " - " + Utilities.GetRelativeDate((DateTime)Eval("Deadline")) : String.Empty %>
                                    </div>
                                    <asp:placeholder runat="server" visible='<%# Eval("Description") != String.Empty %>'>
                                    <div><%# Utilities.Summarize((String)Eval("Description"), 100) %></div>
                                    </asp:placeholder>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    <%= Language.Tasks %>: <%# Eval("TotalTasks") %>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    <%# Eval("ProjectVersion") %>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                            
                                <asp:LinkButton ID="MoveUpButton" CommandArgument='<%# Eval("ID") %>' runat="server" text='<%# Language.Up %>' ToolTip='<%# Language.MoveMilestoneUpToolTip %>' enabled='<%# !IsFirst((Milestone)Container.DataItem) %>' CommandName="MoveUp"></asp:LinkButton>&nbsp;<asp:LinkButton ID="MoveDownButton" CommandArgument='<%# Eval("ID") %>' ToolTip='<%# Language.MoveMilestoneDownToolTip %>' enabled='<%# !IsLast((Milestone)Container.DataItem) %>' runat="server" text='<%# Language.Down %>' CommandName="MoveDown"></asp:LinkButton>
                            </itemtemplate>
                        </asp:TemplateColumn>
                                                    
                                <asp:TemplateColumn>
                                    <itemstyle width="80px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	<ASP:LINKBUTTON id=EditButton runat="server" CommandArgument='<%# Eval("ID") %>' enabled='<%# Authorisation.UserCan("Edit", (Milestone)Container.DataItem) %>' CommandName="Edit" causesvalidation="false" ToolTip='<%# Language.EditMilestoneToolTip %>' text='<%# Language.Edit %>'>
																	</ASP:LINKBUTTON>
																	<asp:LinkButton id=DeleteButton CommandName="Delete" CommandArgument='<%# Eval("ID") %>' runat="server" text='<%# Language.Delete %>' onclientclick='<%# "return confirm(\"" + Language.ConfirmDeleteMilestone + "\")" %>' enabled='<%# Authorisation.UserCan("Delete", (Milestone)Container.DataItem) %>' ToolTip='<%# Language.DeleteMilestoneToolTip %>'>
																	</asp:LinkButton>	
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateMilestone" ? Language.CreateMilestone : Language.EditMilestone %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateMilestone" ? Language.CreateMilestoneIntro : Language.EditMilestoneIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateMilestone" ? Language.NewMilestoneDetails : Language.MilestoneDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" FieldControlID="Title" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.MilestoneTitleRequired %>'></ss:EntityFormTextBoxItem>
				      <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="8"></ss:EntityFormTextBoxItem>
				       <ss:EntityFormItem runat="server"
						visible='<%# ((IEntity[])((EntitySelect)FindControl("Prerequisites")).DataSource).Length > 0 %>'
				       PropertyName="Prerequisites" FieldControlID="Prerequisites" ControlValuePropertyName="SelectedEntities" text='<%# Language.Prerequisites + ":" %>'><FieldTemplate>
					       <ss:EntitySelect
					       ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Prerequisites"
					       width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" TextPropertyName="Title" id="Prerequisites" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectMilestones + " --" %>' OnDataLoading='PrerequisitesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					
					<ss:EntityFormItem runat="server"
					visible='<%# ((IEntity[])((EntitySelect)FindControl("SubMilestones")).DataSource).Length > 0 %>'
					PropertyName="SubMilestones" FieldControlID="SubMilestones" ControlValuePropertyName="SelectedEntities" text='<%# Language.SubMilestones + ":" %>'><FieldTemplate>
						<ss:EntitySelect
						ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="SubMilestones"
						width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" TextPropertyName="Title" id="SubMilestones" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectMilestones + " --" %>' OnDataLoading='SubMilestonesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>			
					
					<ss:EntityFormItem runat="server"
					visible='<%# ((IEntity[])((EntitySelect)FindControl("Tasks")).DataSource).Length > 0 %>'
					PropertyName="Tasks" FieldControlID="Tasks" ControlValuePropertyName="SelectedEntities" text='<%# Language.Tasks + ":" %>'><FieldTemplate>
						<ss:EntitySelect
						ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Tasks"
						width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" TextPropertyName="Title" id="Tasks" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectTasks + " --" %>' OnDataLoading='TasksSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormCheckBoxItem runat="server" PropertyName="EnableDeadline" FieldControlID="EnableDeadline" text='<%# Language.EnableDeadline + ":" %>' checkbox-text='<%# Language.EnableDeadlineNote %>'></ss:EntityFormCheckBoxItem>
				      <ss:EntityFormItem runat="server" PropertyName="Deadline" FieldControlID="Deadline" ControlValuePropertyName="SelectedDate" text='<%# Language.Deadline + ":" %>'><FieldTemplate><ss:DateSelect CssClass="Field" runat="server" id="Deadline"/></FieldTemplate></ss:EntityFormItem>
							<ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
							  <ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateMilestone" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditMilestone" %>'></asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                            
        </asp:View>
                <asp:View runat="server" ID="DetailsView">
                   <h1>
                                <%# Language.Milestone + ": " + ((Milestone)DetailsForm.DataSource).Title %>
                            </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((Milestone)DetailsForm.DataSource).Description %></p> 
                                    <p><asp:Button runat="server" ID="ViewEditButton" CssClass="Button" Text='<%# Language.EditMilestone %>' OnClick="ViewEditButton_Click" /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateMilestone" ? Language.NewMilestoneDetails : Language.MilestoneDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				   <ss:EntityFormLabelItem runat="server" PropertyName="Title" FieldControlID="TitleLabel" text='<%# Language.Title + ":" %>'></ss:EntityFormLabelItem>
				   <ss:EntityFormLabelItem runat="server" PropertyName="Description" FieldControlID="DescriptionLabel" text='<%# Language.Description + ":" %>'></ss:EntityFormLabelItem>
				   <ss:EntityFormLabelItem runat="server" PropertyName="EnableDeadline" FieldControlID="EnableDeadlineLabel" text='<%# Language.EnableDeadline + ":" %>'></ss:EntityFormLabelItem>
				   <ss:EntityFormLabelItem runat="server" PropertyName="Deadline" FieldControlID="DeadlineLabel" text='<%# Language.Deadline + ":" %>'></ss:EntityFormLabelItem>
				   </ss:EntityForm>
               	<asp:placeholder runat="server" visible='<%# ((Milestone)DetailsForm.DataSource).Prerequisites.Length > 0 %>'>
				   <h2><%= Language.Prerequisites %></h2>
                        <ss:EntityTree runat="server" id="ViewMilestonePrerequisites" NoDataText='<%# Language.NoPrerequisitesForMilestone %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="Prerequisites">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Milestone)DetailsForm.DataSource).SubMilestones.Length > 0 %>'>
					<h2><%= Language.SubMilestones %></h2>
                        <ss:EntityTree runat="server" id="ViewMilestoneSubMilestones" NoDataText='<%# Language.NoSubMilestonesForMilestone %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="SubMilestones">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Milestone)DetailsForm.DataSource).Tasks.Length > 0 %>'>
						<h2><%= Language.Tasks %></h2>
                        <ss:EntityTree runat="server" id="ViewMilestoneTasks" NoDataText='<%# Language.NoTasksForMilestone %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="SubTasks">
                        </ss:EntityTree>
                   </asp:placeholder>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
    </asp:MultiView>