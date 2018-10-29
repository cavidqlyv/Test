<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Maintenance" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<script runat="server">
    public string ProjectName
    {
        get { return (string)ViewState["ProjectName"]; }
        set { ViewState["ProjectName"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	switch (QueryStrings.Action)
        	{
                case "Edit":
                	if (QueryStrings.GetID("Bug") != Guid.Empty)
                		EditBug(QueryStrings.GetID("Bug"));
                	break;
        		default:
            		ReportBug();
            		break;
            }
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
    }

    #region Main functions
   
    /// <summary>
    /// Displays the form for creating a new bug.
    /// </summary>
    public void ReportBug()
    {
        // Ensure that the user can create a new bug
        Authorisation.EnsureUserCan("Create", typeof(Bug));

        if (ProjectsState.EnsureProjectSelected())
        {
            // Declare the current operation
            OperationManager.StartOperation("ReportBug", FormView);

            // Create the default bug
            Bug bug = new Bug();
            bug.ID = Guid.NewGuid();
            bug.Project = ProjectsState.Project;
            bug.DateReported = DateTime.Now;
            if (Request.QueryString["Title"] != String.Empty)
                bug.Title = Request.QueryString["Title"];
            if (Request.QueryString["Description"] != String.Empty)
                bug.Description = Request.QueryString["Description"];
            // TODO: Add default values    

			Authorisation.EnsureUserCan("Create", bug);

            // Assign the default bug to the form
            DataForm.DataSource = bug;
            
        	WindowTitle = Language.ReportBug;

            // Bind the form
            FormView.DataBind();
        }
    }
   
    /// <summary>
    /// Saves the newly created bug.
    /// </summary>
    private void SaveBug()
    {
        // Reverse bind the data from the form to the object
        DataForm.ReverseBind();
        
        Bug bug = (Bug)DataForm.DataSource;
        
        bug.Reporter = AuthenticationState.User;

        // Save the new bug
        if (SaveStrategy.New<Bug>().Save(bug))
        {
            // Display the result to the bug
            Result.Display(Language.BugSaved);
            
            // TODO: Move this to a controller or a strategy
        	BugNotificationStrategy.New()
        		.SendNotification((Bug)DataForm.DataSource,
	        		"[" + Language.BugNotificationSubject + "] " + bug.Title,
	        		Language.BugNotificationEmail.Replace("${Application.Url}",
	        										WebUtilities.ConvertRelativeUrlToAbsoluteUrl(Request.ApplicationPath))
	        									.Replace("${Bug.Url}",
	        										new ExternalNavigator().GetExternalLink("View", bug)));


			if (Request.QueryString["AutoReturn"] != null && Request.QueryString["AutoReturn"].ToLower() == "true")
			{
				Close();
            }
            else
        		Navigator.Go("View", bug);
        }
        else
            Result.DisplayError(Language.BugTitleTaken);
    }
    
    /// <summary>
    /// Displays the form for editing the specified bug.
    /// </summary>
    /// <param name="bugID"></param>
    public void EditBug(Guid bugID)
    {
    	EditBug(RetrieveStrategy.New<Bug>().Retrieve<Bug>("ID", bugID));
    }
        
    public void EditBug(Bug bug)
    {
    	ActivateStrategy.New<Bug>().Activate(bug);
    
        // Declare the current operation
        OperationManager.StartOperation("EditBug", FormView);

        // Get the existing data for the specified bug
        DataForm.DataSource = bug;

        // Ensure that the user can edit the specified bug
        Authorisation.EnsureUserCan("Edit", (Bug)DataForm.DataSource);
        
        WindowTitle = Language.EditBug + ": " + bug.Title;

        // Bind the form
        FormView.DataBind();
    }

    /// <summary>
    /// Updates the bug.
    /// </summary>
    private void UpdateBug()
    {
        // Get a fresh copy of the bug object
        Bug bug = RetrieveStrategy.New<Bug>().Retrieve<Bug>(DataForm.EntityID);
      
      	ActivateStrategy.New<Bug>().Activate(bug);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(bug);

        // Update the bug
        if (UpdateStrategy.New<Bug>().Update(bug))
        {
            // Display the result to the bug
            Result.Display(Language.BugUpdated);

        	Navigator.Go("View", bug);
        }
        else
        {
            Result.DisplayError(Language.BugTitleTaken);
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveBug();
        }
        else if (e.CommandName == "Update")
        {
            UpdateBug();
        }
		else if (e.CommandName == "Cancel")
		{
			Navigator.Go("Manage", "Bug");
		}
    }
    
    private void Close()
    {
    	PageView.SetActiveView(CloseView);
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new issue
        ReportBug();
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    
    protected void TasksSelect_DataLoading(object sender, EventArgs e)
    {
    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
	        ((EntitySelect)sender).DataSource = IndexStrategy.New("Task").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
	    else
	    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
	        ((EntitySelect)sender).DataSource = new ISimple[] {};
    }
    
    protected void IssuesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Issue>().IndexWithReference<Issue>("Project", "Project", ProjectsState.ProjectID);
    }
    
    protected void SolutionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Solution>().IndexWithReference<Solution>("Project", "Project", ProjectsState.ProjectID);
    }
    
	  public override void InitializeInfo()
	  {
	  	MenuTitle = Language.ReportBug;
	  	MenuCategory = Language.Maintenance;
	  	ShowOnMenu = true;
	  	ActionAlias = "Create";
	  }    
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "ReportBug" ? Language.ReportBug : Language.EditBug %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "ReportBug" ? Language.ReportBugIntro : Language.EditBugIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "ReportBug" ? Language.NewBugDetails : Language.BugDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" FieldControlID="Title" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.BugTitleRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="12"></ss:EntityFormTextBoxItem>
				   
					<ss:EntityFormItem runat="server" PropertyName="Priority" FieldControlID="Priority" ControlValuePropertyName="SelectedPriority"
                              text='<%# Language.Priority + ":" %>'>
                              <FieldTemplate>
                                  <cc:PrioritySelect runat="server" width="200" id="Priority">
                                  </cc:PrioritySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
					<ss:EntityFormItem runat="server" PropertyName="Difficulty" FieldControlID="Difficulty" ControlValuePropertyName="SelectedDifficulty"
                              text='<%# Language.Difficulty + ":" %>'>
                              <FieldTemplate>
                                  <cc:DifficultySelect runat="server" width="200" id="Difficulty">
                                  </cc:DifficultySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
                          <ss:EntityFormItem runat="server" PropertyName="Type" FieldControlID="Type" ControlValuePropertyName="SelectedType"
                              text='<%# Language.Type + ":" %>'>
                              <FieldTemplate>
                                  <cc:BugTypeSelect runat="server" width="200" id="Type">
                                  </cc:BugTypeSelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
			 			<ss:EntityFormItem runat="server" PropertyName="Status" FieldControlID="Status" ControlValuePropertyName="SelectedStatus"
                              text='<%# Language.Status + ":" %>'>
                              <FieldTemplate>
                                  <cc:BugStatusSelect runat="server" width="200" id="Status">
                                  </cc:BugStatusSelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
				<ss:EntityFormLabelItem runat="server" PropertyName="DateReported" FieldControlID="DateReported" text='<%# Language.DateReported + ":" %>'></ss:EntityFormLabelItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Version" FieldControlID="Version" text='<%# Language.Version + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="FixVersion" FieldControlID="FixVersion" text='<%# Language.VersionToFixFor + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="PercentFixed" FieldControlID="PercentFixed" text='<%# Language.PercentFixed + ":" %>' TextBox-Width="100"></ss:EntityFormTextBoxItem>
           
                          <ss:EntityFormItem runat="server" PropertyName="Issues" FieldControlID="Issues" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Issues + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Issue, SoftwareMonkeys.WorkHub.Modules.Maintenance" runat="server"
                                  ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Issues"
                                      TextPropertyName="Subject" id="Issues" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectIssues + " --" %>' OnDataLoading='IssuesSelect_DataLoading'>
                                  </ss:EntitySelect>
                                  </FieldTemplate>
                                 </ss:EntityFormItem>
                          			  <ss:EntityFormItem runat="server" PropertyName="Solutions" FieldControlID="Solutions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Solutions + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Solution, SoftwareMonkeys.WorkHub.Modules.Maintenance" runat="server"
                                  		ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Solutions"
                                      TextPropertyName="Title" id="Solutions" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectSolutions + " --" %>' OnDataLoading='SolutionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                                  <br />
                                  <ss:EntitySelectRequester runat="server" id="SolutionRequester" EntitySelectControlID="Solutions"
                                  	text='<%# Language.CreateSolution + " &raquo;" %>'
                                  	DeliveryPage='<%# UrlCreator.Current.CreateUrl("Create", "Solution") %>'
                                  	WindowWidth="650" WindowHeight="600"
                                  	EntityType="Bug" EntityID='<%# DataForm.EntityID %>'
                                  	TransferData="Title=Title&Instructions=Description"
                                  	/>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                           <ss:EntityFormItem runat="server" PropertyName="Tasks" FieldControlID="Tasks" ControlValuePropertyName="SelectedEntities" text='<%# Language.Tasks + ":" %>'><FieldTemplate>
                                 	<ss:EntitySelect enabled='<%# EntityState.IsType("Task") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Title" id="Tasks" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Tasks + " --" %>' OnDataLoading='TasksSelect_DataLoading'
                                 	ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Tasks">
                                 	</ss:EntitySelect>
                                 	</FieldTemplate>
                          </ss:EntityFormItem>
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "ReportBug" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditBug" %>'></asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
                            
        </asp:View>
        <asp:View id="CloseView" runat="server">
	 		<ss:EntitySelectDeliverer runat="server" id="DelivererToIssue" TransferFields="Title,Description"
			 	TextControlID="Title" EntityID='<%# DataForm.EntityID %>' SourceEntityType="Issue"/>
 			<ss:EntitySelectDeliverer runat="server" id="DelivererToSolution" TransferFields="Title,Description"
			 	TextControlID="Title" EntityID='<%# DataForm.EntityID %>' SourceEntityType="Solution"/>
        </asp:View>
    </asp:MultiView>