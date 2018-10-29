<%@ Control Language="C#" ClassName="Tasks" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Tasks" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    
    /// <summary>
    /// Gets/sets the current task being viewed. It's persisted via viewstate.
    /// </summary>
    protected Task CurrentTask
    {
        get { return (Task)ViewState["CurrentTask"]; }
        set { ViewState["CurrentTask"] = value; }
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.Start("Loading the tasks page.", NLog.LogLevel.Debug))
	    {
	      
    		LogWriter.Debug("Action: " + QueryStrings.Action);
    	
            switch (QueryStrings.Action)
            {
                case "CreateTask":
                	if (!IsPostBack)
                    	CreateTask();
                    break;
                case "ViewTask":
                    	ViewTask(QueryStrings.GetID("Task"));
                    break;
                case "View":
                    	ViewTask(QueryStrings.GetID("Task"));
                	break;
                case "Create":
                	if (!IsPostBack)
                		CreateTask();
                	break;
                case "Edit":
                	if (!IsPostBack)
                	{
	                	if (QueryStrings.GetID("Task") != Guid.Empty)
	                		EditTask(QueryStrings.GetID("Task"));
                	}
                	break;
                case "Delete":
                	if (!IsPostBack)
                	{
	                	if (QueryStrings.GetID("Task") != Guid.Empty)
	                		DeleteTask(QueryStrings.GetID("Task"));
                	}
                	break;
                default:
                	if (!IsPostBack)
                    	ManageTasks();
                    break;
            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        IndexGrid.AddSortItem(Language.DateCreated + " " + Language.Asc, "DateCreatedAscending");
        IndexGrid.AddSortItem(Language.DateCreated + " " + Language.Desc, "DateCreatedDescending");
        IndexGrid.AddSortItem(Language.Difficulty + " " + Language.Asc, "DifficultyAscending");
        IndexGrid.AddSortItem(Language.Difficulty + " " + Language.Desc, "DifficultyDescending");
        IndexGrid.AddSortItem(Language.Priority + " " + Language.Asc, "PriorityAscending");
        IndexGrid.AddSortItem(Language.Priority + " " + Language.Desc, "PriorityDescending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Asc, "StatusAscending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Desc, "StatusDescending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        IndexGrid.AddDualSortItem(Language.TotalMilestones, "TotalMilestones");
        IndexGrid.AddDualSortItem(Language.TotalSuggestions, "TotalSuggestions");
        
        IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "DemandVotesTotal");
        IndexGrid.AddDualSortItem(Language.CompleteVotesBalance, "CompleteVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalCompleteVotes, "CompleteVotesTotal");
        
        if (!TaskFilterState.FilterFlags.Keys.Contains("Pending"))
        	TaskFilterState.FilterFlags["Pending"] = true;
           
        base.OnInit(e);
    }
    
    #region Main functions
    /// <summary>
    /// Displays the index for managing tasks.
    /// </summary>
    public void ManageTasks()
    {
    	ManageTasks(QueryStrings.PageIndex);
    }
    
    /// <summary>
    /// Displays the index for managing tasks.
    /// </summary>
    public void ManageTasks(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
    
        OperationManager.StartOperation("ManageTasks", IndexView);
        
        Task[] tasks = LoadIndexData(pageIndex);

        Authorisation.EnsureUserCan("View", tasks);
        
		WindowTitle = Language.Tasks;
		if (ProjectsState.ProjectSelected)
			WindowTitle = Language.Tasks + ": " + ProjectsState.ProjectName;

        IndexView.DataBind();
    }

	private Task[] LoadIndexData(int pageIndex)
	{
		Task[] tasks = null;
		
		using (LogGroup logGroup = LogGroup.StartDebug("Loading index data."))
		{
	        PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
	
			if (ProjectsState.IsEnabled)
	        {
	            	tasks = IndexTaskStrategy.New(location, IndexGrid.CurrentSort).Index(ProjectsState.ProjectID, 
	            		TaskFilterState.ShowPending,
	            		TaskFilterState.ShowInProgress,
	            		TaskFilterState.ShowOnHold,
	            		TaskFilterState.ShowCompleted,
	            		TaskFilterState.ShowTested);
	        }
	        else
	            throw new Exception("The Projects modules is required and was not found.");
	            
	        ActivateStrategy.New<Task>().Activate(tasks, "Project");
	
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        
	        IndexGrid.DataSource = tasks;
        }
        
        return tasks;
	}

    /// <summary>
    /// Displays the form for creating a new task.
    /// </summary>
    public void CreateTask()
    {
		using (LogGroup logGroup = LogGroup.Start("Displays a form for creating a task.", NLog.LogLevel.Debug))
		{
	            Authorisation.EnsureUserCan("Create", typeof(Task));
	
	            OperationManager.StartOperation("CreateTask", FormView);
	
				if (ProjectsState.EnsureProjectSelected())
				{
		            Task task = new Task();
		            task.ID = Guid.NewGuid();
					task.DateCreated = DateTime.Now;
		            task.Project = ProjectsState.Project;
			    	task.Status = TaskStatus.Pending;
		
			    	LogWriter.Debug("New task ID: " + task.ID);
		
		      	    DataForm.DataSource = task;
		      	    
					WindowTitle = Language.CreateTask;
		
		            FormView.DataBind();
	            }
		}
    }

    /// <summary>
    /// Displays the form for editing the specified task.
    /// </summary>
    /// <param name="taskID"></param>
    public void EditTask(Guid taskID)
    {
    	EditTask(RetrieveStrategy.New<Task>().Retrieve<Task>("ID", taskID));
    }
    
    public void EditTask(Task task)
    {
		using (LogGroup logGroup = LogGroup.Start("Displays a form for editing a task.", NLog.LogLevel.Debug))
		{
	            OperationManager.StartOperation("EditTask", FormView);
	
	            
	            ActivateStrategy.New<Task>().Activate(task);
	            
	            DataForm.DataSource = task;
	
	            Authorisation.EnsureUserCan("Edit", task);
	            
				WindowTitle = Language.EditTask + ": " + task.Title;
	
	            FormView.DataBind();
		}
    }

    /// <summary>
    /// Saves the newly created task.
    /// </summary>
    private void SaveTask()
    {
        // Save the new task
        DataForm.ReverseBind();
        
        Task task = (Task)DataForm.DataSource;
        
        ActivateStrategy.New(task).Activate(task);
        
        if (SaveStrategy.New<Task>().Save(task))
        {
            // Display the result to the task
            Result.Display(Language.TaskSaved);

			if (Request.QueryString["AutoReturn"] != null && Request.QueryString["AutoReturn"].ToLower() == "true")
            	Close();
            else
        		Navigator.Go("View", task);
        }
        else
            Result.DisplayError(Language.TaskTitleTaken);
    }

    private void UpdateTask()
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Updating task from form."))
    	{
	        // Get a fresh copy of the task object
	        Task task = RetrieveStrategy.New<Task>().Retrieve<Task>("ID", ((Task)DataForm.DataSource).ID);
	        
	        ActivateStrategy.New<Task>().Activate(task);
	
	        // Get the original title of the task before binding the new data
	        string originalTitle = task.Title;
	        
	        // Transfer data from the form to the object
	        DataForm.ReverseBind(task);
	
	        // Update the task
	        if (UpdateStrategy.New<Task>().Update(task))
	        {
	        	LogWriter.Debug("Task was updated.");
	        
	            // Display the result to the task
	            Result.Display(Language.TaskUpdated);
	
	            // Show the index again
	        	Navigator.Go("Index", "Task");
	        }
	        else
	        {
	        	// TODO: This could mean any validation failed, not just unique title. Update message.
	            Result.DisplayError(Language.TaskTitleTaken);
	        }
        }
    }

    /// <summary>
    /// Deletes the task with the provided ID.
    /// </summary>
    /// <param name="taskID">The ID of the task to delete.</param>
    private void DeleteTask(Guid taskID)
    {
    	DeleteTask(RetrieveStrategy.New<Task>().Retrieve<Task>("ID", taskID));
    }
     
    private void DeleteTask(Task task)
    {
    	Authorisation.EnsureUserCan("Delete", task);
    
        // Delete the task
        DeleteStrategy.New<Task>().Delete(task);
        
        // Display the result
        Result.Display(Language.TaskDeleted);

        // Go back to the index
        Navigator.Go("Index", "Task");
    }

    /// <summary>
    /// Displays the details of the task with the specified ID.
    /// </summary>
    /// <param name="taskID">The ID of the task to display.</param>
    private void ViewTask(Guid taskID)
    {
    	ViewTask(RetrieveStrategy.New<Task>().Retrieve<Task>(
    			"ID", taskID));
    }
     
    private void ViewTask(Task task)
    {
    	using (LogGroup logGroup = LogGroup.Start("Viewing the provided task.", NLog.LogLevel.Debug))
    	{
    		if (task == null)
    		{
    			LogWriter.Debug("null task provided. Redirecting to index.");
	    		Navigator.Go("Index", "Task");
	    	}
    	
    		CurrentTask = task;
    	
    		LogWriter.Debug("Task: " + (task == null ? "[null]" : task.Title));
    	
	        OperationManager.StartOperation("ViewTask", DetailsView);
	
	        DetailsForm.DataSource = CurrentTask;
	        
	        Authorisation.EnsureUserCan("View", CurrentTask);
	        
	        ActivateStrategy.New<Task>().Activate(CurrentTask);
	          
			WindowTitle = Language.Task + ": " + CurrentTask.Title;
	        
	        DetailsView.DataBind();
        }
    }
    
    

    /// <summary>
    /// Sets the specified task's status.
    /// </summary>
    /// <param name="taskID">The ID to set the status of.</param>
    /// <param name="status">The status to set to the task.</param>
    private void SetTaskStatus(Guid taskID, TaskStatus status)
    {
    
        Authorisation.EnsureUserCan
        (
        	"Edit",
        	RetrieveStrategy.New<Task>().Retrieve<Task>(taskID)
        );
        
        UpdateTaskStatusStrategy.New().UpdateTaskStatus(taskID, status);

        Result.Display(Language.TaskStatusUpdated);

        ManageTasks(IndexGrid.CurrentPageIndex);
    }
    
    private void Close()
    {
    	PageView.SetActiveView(CloseView);
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new task
        Navigator.Go("Create", "Task");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditTask(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteTask(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewTask(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Handling the DataForm.EntityCommand event."))
    	{
	        if (e.CommandName == "Save")
	        {
	            SaveTask();
	        }
	        else if (e.CommandName == "Update")
	        {
	            UpdateTask();
	        }
        }
    }

    protected void PrerequisitesSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading tasks for prerequisites list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().IndexWithReference<Task>("Project", "Project", ProjectsState.ProjectID);
		    else
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().Index<Task>();
	    }
    }

    protected void SubTasksSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading tasks for sub tasks list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().IndexWithReference<Task>("Project", "Project", ProjectsState.ProjectID);
		    else
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().Index<Task>();
	    }
    }

    protected void MilestonesSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading milestones for milestones list."))
	    {
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", ProjectsState.ProjectID);
		    else
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Milestone>().Index<Milestone>();
	    }
    }

    protected void AssignedUsersSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading users for assigned users list."))
    	{
        	((EntitySelect)sender).DataSource = IndexStrategy.New<User>().Index<User>();
        }
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading projects for projects list."))
	    {
        	((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
        }
    }
    
    protected void BugsSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading bugs for bugs list."))
	    {
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Bug").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Bug").Index();
	    }
    }
    
    protected void SuggestionsSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading suggestions for suggestions list."))
	    {
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New<Suggestion>().IndexWithReference<Suggestion>("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new Suggestion[] {};
	    }
    }
    
    protected void IssuesSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading issues for issues list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Issue").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }
    
    protected void GoalsSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading goals for goals list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Goal").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }

    protected void ScenariosSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading scenarios for scenarios list."))
	    {
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Scenario").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
        }
    }

    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading actions for actions list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }


    protected void EntitiesSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading entities for entities list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("ProjectEntity").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }

    protected void RestraintsSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading restraints for restraints list."))
    	{
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Restraint").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }

    protected void FeaturesSelect_DataLoading(object sender, EventArgs e)
    {
	    using (LogGroup logGroup = LogGroup.StartDebug("Loading features for features list."))
	    {
	    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
		        ((EntitySelect)sender).DataSource = IndexStrategy.New("Feature").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
		    else
		    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
		        ((EntitySelect)sender).DataSource = new ISimple[] {};
	    }
    }

    protected void ViewPrerequisitesGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditTask(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteTask(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewTask(new Guid(e.CommandArgument.ToString()));
        }
    }

	private void ViewEditButton_Click(object sender, EventArgs e)
	{
		Navigator.Go("Edit", (IEntity)DetailsForm.DataSource);
	}
	
    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageTasks(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageTasks(e.NewPageIndex);
    }
    
    
    private void IndexStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIndexData(QueryStrings.PageIndex);

        IndexGrid.DataBind();

        DataGridItem item = (DataGridItem)((WebControl)sender).Parent.Parent;

        TaskStatusSelect status = (TaskStatusSelect)sender;

        int index = item.ItemIndex;

        SetTaskStatus(((Task[])IndexGrid.DataSource)[index].ID,
            status.SelectedStatus);   
    }
    
    private void FilterButton_Click(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Applying filter."))
    	{
	    	TaskFilterState.ShowPending = ShowPendingFilter.Checked;
	    	
	    	TaskFilterState.ShowInProgress = ShowInProgressFilter.Checked;
	    	
	    	TaskFilterState.ShowOnHold = ShowOnHoldFilter.Checked;
	    	
	    	TaskFilterState.ShowCompleted = ShowCompletedFilter.Checked;
	    	
	    	TaskFilterState.ShowTested = ShowTestedFilter.Checked;
	    	
	    	Response.Redirect(IndexGrid.CompileNavigateUrl());
    	}
    	
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">
			 	
            <h1>
                        <%= Language.ManageTasks %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageTasksIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateTask %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                    </div>
                    <div id="Filter">
                    	Filter:
                    	<asp:checkbox runat="server" id="ShowPendingFilter" text='<%# Language.Pending %>' checked='<%# (bool)TaskFilterState.ShowPending %>'/>
                    	<asp:checkbox runat="server" id="ShowInProgressFilter" text='<%# Language.InProgress %>' checked="<%# (bool)TaskFilterState.ShowInProgress %>"/>
                    	<asp:checkbox runat="server" id="ShowOnHoldFilter" text='<%# Language.OnHold %>' checked="<%# (bool)TaskFilterState.ShowOnHold %>"/>
                    	<asp:checkbox runat="server" id="ShowCompletedFilter" text='<%# Language.Completed %>' checked="<%# (bool)TaskFilterState.ShowCompleted %>"/>
                    	<asp:checkbox runat="server" id="ShowTestedFilter" text='<%# Language.Tested %>' checked="<%# (bool)TaskFilterState.ShowTested %>"/>
                    	<asp:button runat="server" id="FilterButton" text='<%# Language.ApplyFilter %>' onclick="FilterButton_Click"/>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="PriorityDescending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Tasks %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%" NavigateUrl='<%# Navigator.GetLink("Index", "Task") %>'
                            EmptyDataText='<%# ProjectsState.ProjectSelected ? Language.NoTasksForProject : Language.NoTasksFound %>' OnItemCommand="IndexGrid_ItemCommand" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged">
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                   <div class="Title"><asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink></div>
                                    <div class="Details">
                                    
                                   	<%= Language.Priority %>: <%# PriorityUtilities.GetPriorityText((Priority)Eval("Priority")) %>
                                   	- <%= Language.Difficulty %>: <%# DifficultyUtilities.GetDifficultyText((Difficulty)Eval("Difficulty")) %>
                                   	- <%= Language.Suggestions %>: <%# Eval("TotalSuggestions") %>
                                   	- <%= Language.Milestones %>: <%# Eval("TotalMilestones") %>
                                   	- <%= Language.AssignedUsers %>: <%# Eval("TotalAssignedUsers") %>
                                   	<asp:placeholder runat="server" visible='<%# Eval("Project") != null && !ProjectsState.ProjectSelected %>'>
                                            	- <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)Eval("Project")) : String.Empty %>'><%# ProjectsState.ProjectSelected ? String.Empty : (string)Eval("Project.Name") %></a>
                                   	</asp:placeholder>
									<asp:placeholder runat="server" visible='<%# Eval("ProjectVersion") != null && Eval("ProjectVersion") != String.Empty %>'>
                                            	- <%# Eval("ProjectVersion") %>
                                   	</asp:placeholder>
                                   	
                                   	</div>
                                   <asp:panel runat="server" visible='<%# Eval("Description") != null && Eval("Description") != String.Empty %>' class="Content"><%# Utilities.Summarize((String)Eval("Description"), 100) %></asp:panel>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Complete + "&BalanceProperty=CompleteVotesBalance&TotalProperty=TotalCompleteVotes" %>' /></div>
								</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <cc:TaskStatusSelect runat="server" id="IndexStatus" AutoPostBack="true" SelectedStatus='<%# (TaskStatus)Eval("Status") %>' OnSelectedIndexChanged='IndexStatus_SelectedIndexChanged'></cc:TaskStatusSelect>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	<ASP:LINKBUTTON id=EditButton runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="Edit" causesvalidation="false" ToolTip='<%# Language.EditTaskToolTip %>' text='<%# Language.Edit %>'>
																	</ASP:LINKBUTTON><br/>
																	<asp:LinkButton id=DeleteButton CommandName="Delete" CommandArgument='<%# Eval("ID") %>' runat="server" text='<%# Language.Delete %>' onclientclick='<%# "return confirm(\"" + Language.ConfirmDeleteTask + "\")" %>' ToolTip='<%# Language.DeleteTaskToolTip %>'>
																	</asp:LinkButton>	
									</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
         <asp:View runat="server" ID="FormView">
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateTask" ? Language.CreateTask : Language.EditTask %>
                   </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateTask" ? Language.CreateTaskIntro : Language.EditTaskIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateTask" ? Language.NewTaskDetails : Language.TaskDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" visible="true" PropertyName="Title" FieldControlID="Title" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.TaskTitleRequired %>'></ss:EntityFormTextBoxItem>
				      <ss:EntityFormTextBoxItem runat="server" visible="true" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="8"></ss:EntityFormTextBoxItem>
					<ss:EntityFormItem runat="server" visible="true" PropertyName="Priority" FieldControlID="Priority" ControlValuePropertyName="SelectedPriority"
                              text='<%# Language.Priority + ":" %>'>
                              <FieldTemplate>
                                  <cc:PrioritySelect runat="server" width="200" id="Priority">
                                  </cc:PrioritySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible="true" PropertyName="Difficulty" FieldControlID="Difficulty" ControlValuePropertyName="SelectedDifficulty"
                              text='<%# Language.Difficulty + ":" %>'>
                              <FieldTemplate>
                                  <cc:DifficultySelect runat="server" width="200" id="Difficulty">
                                  </cc:DifficultySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
						  <ss:EntityFormItem runat="server" visible="true" PropertyName="Status" FieldControlID="Status" ControlValuePropertyName="SelectedStatus"
                              text='<%# Language.Status + ":" %>'>
                              <FieldTemplate>
                                  <cc:TaskStatusSelect runat="server" width="200" id="Status">
                                  </cc:TaskStatusSelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				     
				      <ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Prerequisites")).DataSource).Length > 0 %>'
				      PropertyName="Prerequisites" FieldControlID="Prerequisites" ControlValuePropertyName="SelectedEntities" text='<%# Language.Prerequisites + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Prerequisites" TextPropertyName="Title" id="Prerequisites" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectTasks + " --" %>' OnDataLoading='PrerequisitesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("SubTasks")).DataSource).Length > 0 %>'
					PropertyName="SubTasks" FieldControlID="SubTasks" ControlValuePropertyName="SelectedEntities" text='<%# Language.SubTasks + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="SubTasks" TextPropertyName="Title" id="SubTasks" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectTasks + " --" %>' OnDataLoading='SubTasksSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Milestones")).DataSource).Length > 0 %>' PropertyName="Milestones" FieldControlID="Milestones" ControlValuePropertyName="SelectedEntities" text='<%# Language.Milestones + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" TextPropertyName="Title" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Milestones" id="Milestones" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectMilestones + " --" %>' OnDataLoading='MilestonesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("AssignedUsers")).DataSource).Length > 0 %>' PropertyName="AssignedUsers" FieldControlID="AssignedUsers" ControlValuePropertyName="SelectedEntities" text='<%# Language.AssignedUsers + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.User, SoftwareMonkeys.WorkHub.Entities" runat="server" TextPropertyName="Name" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="AssignedUsers" id="AssignedUsers" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectUsers + " --" %>' OnDataLoading='AssignedUsersSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Suggestions")).DataSource).Length > 0 %>' PropertyName="Suggestions" FieldControlID="Suggestions" ControlValuePropertyName="SelectedEntities" text='<%# Language.Suggestions + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# ProjectsState.ProjectSelected %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Suggestion, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Suggestions" TextPropertyName="Subject" id="Suggestions" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectSuggestions + " --" %>' OnDataLoading='SuggestionsSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Issues")).DataSource).Length > 0 %>' PropertyName="Issues" FieldControlID="Issues" ControlValuePropertyName="SelectedEntities" text='<%# Language.Issues + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Bug") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Subject" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Issues" id="Issues" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Issues + " --" %>' OnDataLoading='IssuesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Bugs")).DataSource).Length > 0 %>' PropertyName="Bugs" FieldControlID="Bugs" ControlValuePropertyName="SelectedEntities" text='<%# Language.Bugs + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Bug") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Title" id="Bugs" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Bugs" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Bugs + " --" %>' OnDataLoading='BugsSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Goals")).DataSource).Length > 0 %>' PropertyName="Goals" FieldControlID="Goals" ControlValuePropertyName="SelectedEntities" text='<%# Language.Goals + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Goal") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Title" id="Goals" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Goals" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Goals + " --" %>' OnDataLoading='GoalsSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Scenarios")).DataSource).Length > 0 %>' PropertyName="Scenarios" FieldControlID="Scenarios" ControlValuePropertyName="SelectedEntities" text='<%# Language.Scenarios + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Scenario") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Name" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Scenarios" id="Scenarios" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Scenarios + " --" %>' OnDataLoading='ScenariosSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Features")).DataSource).Length > 0 %>' PropertyName="Features" FieldControlID="Features" ControlValuePropertyName="SelectedEntities" text='<%# Language.Features + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Feature") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Name" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Features" id="Features" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Features + " --" %>' OnDataLoading='FeaturesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Actions")).DataSource).Length > 0 %>' PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities" text='<%# Language.Actions + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Action") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Name" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions" id="Actions" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Actions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("PlanningEntities")).DataSource).Length > 0 %>' PropertyName="PlanningEntities" FieldControlID="PlanningEntities" ControlValuePropertyName="SelectedEntities" text='<%# Language.PlanningEntities + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("ProjectEntity") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="PlanningEntities" TextPropertyName="Name" id="PlanningEntities" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.PlanningEntities + " --" %>' OnDataLoading='EntitiesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormItem runat="server" visible='<%# ((IEntity[])((EntitySelect)FindControl("Restraints")).DataSource).Length > 0 %>' PropertyName="Restraints" FieldControlID="Restraints" ControlValuePropertyName="SelectedEntities" text='<%# Language.Restraints + ":" %>'><FieldTemplate><ss:EntitySelect enabled='<%# EntityState.Entities.EntityExists("Restraint") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Restraints" TextPropertyName="Title" id="Restraints" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Restraints + " --" %>' OnDataLoading='RestraintsSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
							<ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormTextBoxItem>
							  <ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateTask" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditTask" %>'></asp:Button>&nbsp;
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                            
        </asp:View>
                <asp:View runat="server" ID="DetailsView">
                 
			 <ss:EntitySelectDeliverer runat="server" id="DelivererToSuggestion2" TransferFields="Title,Description"
			 	TextControlID="Title" EntityID='<%# DataForm.EntityID %>' SourceEntityType="Suggestion"/>
			 	
                   <div class="Heading1">
                                <%# Language.Task + ": " + HtmlTools.FormatText(((Task)DetailsForm.DataSource).Title) %>
                            </div>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# HtmlTools.FormatText(((Task)DetailsForm.DataSource).Description) %></p>
				<p><asp:Button runat="server" id="ViewEditButton" Text='<%# Language.EditTask %>' CssClass="Button" onclick="ViewEditButton_Click"/>
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Complete + "&BalanceProperty=CompleteVotesBalance&TotalProperty=TotalCompleteVotes" %>' />
				</p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateTask" ? Language.NewTaskDetails : Language.TaskDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				    <ss:EntityFormLabelItem runat="server" PropertyName="Priority" FieldControlID="PriorityLabel" text='<%# Language.Priority + ":" %>'></ss:EntityFormLabelItem>
				<ss:EntityFormLabelItem runat="server" PropertyName="Difficulty" FieldControlID="DifficultyLabel" text='<%# Language.Difficulty + ":" %>'></ss:EntityFormLabelItem>
				    <ss:EntityFormLabelItem runat="server" PropertyName="Status" FieldControlID="StatusLabel" text='<%# Language.Status + ":" %>'></ss:EntityFormLabelItem>
				   </ss:EntityForm>
				<asp:placeholder runat="server" visible='<%# ((Task)DetailsForm.DataSource).Goals.Length > 0 %>'>
				   <h2><%= Language.Prerequisites %></h2>
                      <ss:EntityTree runat="server" id="ViewTaskPrerequisites" DataSource='<%# CurrentTask.Prerequisites %>' NoDataText='<%# Language.NoPrerequisitesForTask %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="Prerequisites">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Task)DetailsForm.DataSource).SubTasks.Length > 0 %>'>
				   <div class="Heading2"><%= Language.SubTasks %></div>
                        <ss:EntityTree runat="server" id="ViewTaskSubTasks" DataSource='<%# CurrentTask.SubTasks %>' NoDataText='<%# Language.NoSubTasksForTask %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="SubTasks">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Task)DetailsForm.DataSource).Milestones.Length > 0 %>'>
 			<div class="Heading2"><%= Language.Milestones %></div>
                       <ss:EntityTree runat="server" id="ViewTaskMilestones" DataSource='<%# CurrentTask.Milestones %>' NoDataText='<%# Language.NoMilestonesForTask %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Milestone, SoftwareMonkeys.WorkHub.Modules.Tasks">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Task)DetailsForm.DataSource).AssignedUsers.Length > 0 %>'>
 			<div class="Heading2"><%= Language.AssignedUsers %></div>
                       <ss:EntityTree runat="server" id="ViewTaskAssignedUsers" DataSource='<%# CurrentTask.AssignedUsers %>' NoDataText='<%# Language.NoUsersAssignedToTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.User, SoftwareMonkeys.WorkHub.Entities">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# ((Task)DetailsForm.DataSource).Suggestions.Length > 0 %>'>
 			<div class="Heading2"><%= Language.Suggestions %></div>
                       <ss:EntityTree runat="server" id="ViewTaskSuggestions" DataSource='<%# CurrentTask.Suggestions %>' NoDataText='<%# Language.NoSuggestionsForTask %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Suggestion, SoftwareMonkeys.WorkHub.Modules.Tasks">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Issue") && ((Task)DetailsForm.DataSource).Issues.Length > 0  %>'>
 			<h2><%= Language.Issues %></h2>
                       <ss:EntityTree runat="server" id="ViewTaskIssues" DataSource='<%# CurrentTask.Issues %>' NoDataText='<%# Language.NoIssuesForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Bug") && ((Task)DetailsForm.DataSource).Bugs.Length > 0   %>'>
 			<h2><%= Language.Bugs %></h2>
                        <ss:EntityTree runat="server" id="ViewTaskBugs" DataSource='<%# CurrentTask.Bugs %>' NoDataText='<%# Language.NoBugsForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>    
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Goal") && ((Task)DetailsForm.DataSource).Goals.Length > 0   %>'>
 			<h2><%= Language.Goals %></h2>
                       <ss:EntityTree runat="server" id="ViewTaskGoals" DataSource='<%# CurrentTask.Goals %>' NoDataText='<%# Language.NoGoalsForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Scenario") && ((Task)DetailsForm.DataSource).Scenarios.Length > 0   %>'>
 			<h2><%= Language.Scenarios %></h2>
                       <ss:EntityTree runat="server" id="ViewTaskScenarios" DataSource='<%# CurrentTask.Scenarios %>' NoDataText='<%# Language.NoScenariosForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Feature") && ((Task)DetailsForm.DataSource).Features.Length > 0   %>'>
 			<h2><%= Language.Features %></h2>
                      <ss:EntityTree runat="server" id="ViewTaskFeatures" DataSource='<%# CurrentTask.Features %>' NoDataText='<%# Language.NoFeaturesForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Action") && ((Task)DetailsForm.DataSource).Actions.Length > 0   %>'>
 			<h2><%= Language.Actions %></h2>
                      <ss:EntityTree runat="server" id="ViewTaskActions" DataSource='<%# CurrentTask.Actions %>' NoDataText='<%# Language.NoActionsForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("ProjectEntity") && ((Task)DetailsForm.DataSource).PlanningEntities.Length > 0   %>'>
 			<h2><%= Language.PlanningEntities %></h2>
                        <ss:EntityTree runat="server" id="ViewTaskEntities" DataSource='<%# CurrentTask.PlanningEntities %>' NoDataText='<%# Language.NoPlanningEntitiesForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
            <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Restraint") && ((Task)DetailsForm.DataSource).Restraints.Length > 0   %>'>
 			<h2><%= Language.Restraints %></h2>
                         <ss:EntityTree runat="server" id="ViewTaskRestraints" DataSource='<%# CurrentTask.Restraints %>' NoDataText='<%# Language.NoRestraintsForTask %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
            </asp:placeholder>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
        
        <asp:View id="CloseView" runat="server">
			 <ss:EntitySelectDeliverer runat="server" id="DelivererToSuggestion" TransferFields="Title,Description"
			 	TextControlID="Title" EntityID='<%# DataForm.EntityID %>' SourceEntityType="Suggestion"/>
        </asp:View>
    </asp:MultiView>