<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Maintenance" TagPrefix="ic" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>		
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (QueryStrings.Action)
        {
            case "ReportIssue":
    			if (!IsPostBack)
               		ReportIssue();
                break;
            case "ViewIssue":
                ViewIssue(Utilities.GetQueryStringID("IssueID"));
                break;
            case "View":
            	if (QueryStrings.GetID("Issue") != Guid.Empty)
            		ViewIssue(QueryStrings.GetID("Issue"));
            	break;
            case "Edit":
    			if (!IsPostBack)
    			{
            		if (QueryStrings.GetID("Issue") != Guid.Empty)
            			EditIssue(QueryStrings.GetID("Issue"));
            	}
            	break;
            case "Delete":
            	if (QueryStrings.GetID("Issue") != Guid.Empty)
            		DeleteIssue(QueryStrings.GetID("Issue"));
            	break;
            case "Create":
    			if (!IsPostBack)
            		ReportIssue();
            	break;
            default:
    			if (!IsPostBack)
                	ManageIssues();
                break;
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        IndexGrid.AddSortItem(Language.DateReported + " " + Language.Asc, "DateReportedAscending");
        IndexGrid.AddSortItem(Language.DateReported + " " + Language.Desc, "DateReportedDescending");
        IndexGrid.AddSortItem(Language.ReporterEmail + " " + Language.Asc, "ReporterEmailAscending");
        IndexGrid.AddSortItem(Language.ReporterEmail + " " + Language.Desc, "ReporterEmailDescending");
        IndexGrid.AddSortItem(Language.ReporterName + " " + Language.Asc, "ReporterNameAscending");
        IndexGrid.AddSortItem(Language.ReporterName + " " + Language.Desc, "ReporterNameDescending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Asc, "StatusAscending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Desc, "StatusDescending");
        IndexGrid.AddSortItem(Language.Subject + " " + Language.Asc, "SubjectAscending");
        IndexGrid.AddSortItem(Language.Subject + " " + Language.Desc, "SubjectDescending");
      
        IndexGrid.AddDualSortItem(Language.TotalBugs, "TotalBugs");
        IndexGrid.AddDualSortItem(Language.TotalVotes, "TotalVotes"); 
        IndexGrid.AddDualSortItem(Language.VotesBalance, "VotesBalance"); 
    }


    #region Main functions
    /// <summary>
    /// Displays the index for managing issues.
    /// </summary>
    /// <param name="pageIndex">The index of the page of issues to manage.</param>
    public void ManageIssues(int pageIndex)
    {
        // Set the index of the grid
        IndexGrid.CurrentPageIndex = pageIndex;

        // Declare the current operation
        OperationManager.StartOperation("ManageIssues", IndexView);

        // Load the data for the index
        Issue[] issues = LoadIndexData(pageIndex);

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", issues);

		WindowTitle = Language.Issues;
		if (ProjectsState.ProjectSelected)
			WindowTitle = Language.Issues + ": " + ProjectsState.ProjectName;
        			
        // Bind the index
        IndexView.DataBind();
    }

    /// <summary>
    /// Displays the index for managing issues.
    /// </summary>
    public void ManageIssues()
    {
        // Display the first page of the index
        ManageIssues(QueryStrings.PageIndex);
    }
    
    /// <summary>
    /// Displays the form for creating a new issue.
    /// </summary>
    public void ReportIssue()
    {
    	Navigator.Go("Report", "Issue");
    	
    }

    /// <summary>
    /// Displays the form for editing the specified issue.
    /// </summary>
    /// <param name="issueID"></param>
    public void EditIssue(Guid issueID)
    {
    	Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);
    	
		if (issue == null)
			throw new EntityNotFoundException("Issue", issueID);
			
    	EditIssue(issue);
    }
    
    public void EditIssue(Issue issue)
    {
        OperationManager.StartOperation("EditIssue", FormView);

        DataForm.DataSource = issue;
        
        ActivateStrategy.New(issue).Activate(issue);

        Authorisation.EnsureUserCan("Edit", (Issue)DataForm.DataSource);
        
        WindowTitle = Language.EditIssue + ": " + issue.Subject;

        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created issue.
    /// </summary>
    private void SaveIssue()
    {
        DataForm.ReverseBind();
        
        
        Issue issue = (Issue)DataForm.DataSource;
        
        // Save the new issue
        SaveStrategy.New<Issue>().Save(issue);
        
        IssueNotificationStrategy.New().SendNotification((Issue)DataForm.DataSource,
        		"[" + Language.IssueNotificationSubject + "] " + issue.Subject,
        		Language.IssueNotificationEmail.Replace("${Application.Url}", WebUtilities.ConvertRelativeUrlToAbsoluteUrl(Request.ApplicationPath))
        		.Replace("${Issue.Url}", new ExternalNavigator().GetExternalLink("View", "Issue", "ID", issue.ID.ToString())));

        

        // Display the result to the issue
        Result.Display(Language.IssueSaved);

   		Navigator.Go("View", "Issue", "ID", issue.ID.ToString());
    }

    /// <summary>
    /// Updates the issue.
    /// </summary>
    private void UpdateIssue()
    {
        // Get a fresh copy of the issue object
        Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>(((Issue)DataForm.DataSource).ID);
      
      	ActivateStrategy.New<Issue>().Activate(issue);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(issue);

		UpdateStrategy.New<Issue>().Update(issue);
		
        // Display the result to the issue
        Result.Display(Language.IssueUpdated);

        // Show the index again
   		Navigator.Go("View", issue);

    }

    /// <summary>
    /// Deletes the issue with the provided ID.
    /// </summary>
    /// <param name="issueID">The ID of the issue to delete.</param>
    private void DeleteIssue(Guid issueID)
    {
        Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);

		if (issue == null)
			throw new EntityNotFoundException("Issue", issueID);

        Authorisation.EnsureUserCan("Delete", issue);
        
        // Delete the issue
        DeleteStrategy.New<Issue>().Delete(issue);
        
        // Display the result
        Result.Display(Language.IssueDeleted);

        // Go back to the index
        Navigator.Go("Index", "Issue");
    }

    /// <summary>
    /// Displays the details of the issue with the specified ID.
    /// </summary>
    /// <param name="issueID">The ID of the issue to display.</param>
    private void ViewIssue(Guid issueID)
    {
    	Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);
    	
		if (issue == null)
			throw new EntityNotFoundException("Issue", issueID);
    
    	ViewIssue(issue);
    }

    private void ViewIssue(Issue issue)
    {
    
        OperationManager.StartOperation("ViewIssue", DetailsView);

		if (issue == null)
			Response.Redirect(Request.ApplicationPath + "/Error404.aspx");

        ActivateStrategy.New<Issue>().Activate(issue);
        
        DetailsForm.DataSource = issue;

        Authorisation.EnsureUserCan("View", (Issue)DetailsForm.DataSource);
        
        WindowTitle = Language.Issue + ": " + issue.Subject;
        
        DetailsView.DataBind();
    }

    /// <summary>
    /// Marks the issue with the provided ID as resolved.
    /// </summary>
    /// <param name="issueID">The ID of the issue that has been resolved.</param>
    private void IssueResolved(Guid issueID)
    {
        Issue issue = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);

		if (issue == null)
			throw new EntityNotFoundException("Issue", issueID);

        Authorisation.EnsureUserCan("Edit", issue);

        // Resolve the issue
        UpdateIssueStatusStrategy.New().UpdateIssueStatus(issueID, IssueStatus.Resolved);

        // Display the result
        Result.Display(Language.IssueResolved);

        // Go back to the index
        if (OperationManager.PreviousOperation == "ReportIssue")
            Navigator.Go("View", issue);
        else
			Navigator.Go("Index", "Issue");
    }

    /// <summary>
    /// Sets the specified issue's status.
    /// </summary>
    /// <param name="issueID">The ID of the issue to set the status of.</param>
    /// <param name="status">The status to set to the issue.</param>
    private void SetIssueStatus(Guid issueID, IssueStatus status)
    {
        Authorisation.EnsureUserCan
        (
        	"Edit",
        	RetrieveStrategy.New<Issue>().Retrieve<Issue>(issueID)
        );
    
        UpdateIssueStatusStrategy.New().UpdateIssueStatus(issueID, status);

        Result.Display(Language.IssueStatusUpdated);

		Response.Redirect(IndexGrid.CompileNavigateUrl());
    }

    private Issue[] LoadIndexData(int pageIndex)
    {
        Issue[] issues = null;
        int total = 0;

        if (ProjectsState.IsEnabled)
        {
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
            issues = IndexIssueStrategy.New(location, IndexGrid.CurrentSort).Index(ProjectsState.ProjectID,
            		IssueFilterState.ShowPending,
            		IssueFilterState.ShowResolved,
            		IssueFilterState.ShowClosed);
            	    	
	        ActivateStrategy.New<Issue>().Activate(issues);
	        
        	Authorisation.EnsureUserCan("Index", issues);
	
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        IndexGrid.DataSource = issues;
        }
        else
            ProjectsState.EnsureProjectsEnabled();
            

        return issues;
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new issue
        //if (Request.IsAuthenticated && Authorisation.UserCan("Create", typeof(Issue)))
	    //    ReportIssue();
	    //else
	    	Response.Redirect(UrlCreator.Current.CreateUrl("Report", "Issue"));
    }
    
    protected void LinkInfoButton_Click(object sender, EventArgs e)
    {
		Navigator.Go("ViewLinkInfo", "Issue");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
        	Navigator.Go("Edit",
        		RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", new Guid(e.CommandArgument.ToString()))
        	);
        }
        else if (e.CommandName == "Delete")
        {
            DeleteIssue(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewIssue(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Resolve")
        {
            IssueResolved(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveIssue();
        }
        else if (e.CommandName == "Update")
        {
            UpdateIssue();
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageIssues(IndexGrid.CurrentPageIndex);
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageIssues(e.NewPageIndex);
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        	Navigator.Go("Edit", (IEntity)DetailsForm.DataSource);
    }

    private void ViewResolvedButton_Click(object sender, EventArgs e)
    {
        IssueResolved(((Issue)DetailsForm.DataSource).ID);
    }

    protected void BugsSelect_DataLoading(object sender, EventArgs e)
    {
    	if (ProjectsState.IsEnabled && ProjectsState.ProjectSelected)
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Bug>().IndexWithReference<Bug>("Project", "Project", ProjectsState.ProjectID);
		else
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Bug>().Index();
    }
    
    protected void TasksSelect_DataLoading(object sender, EventArgs e)
    {
    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
	        ((EntitySelect)sender).DataSource = IndexStrategy.New("Task").IndexWithReference("Project", "Project", ProjectsState.ProjectID);
	    else
	    	// No data shown when a project is not selected, otherwise someone could select a suggestion in a different project, which could cause problems
	        ((EntitySelect)sender).DataSource = new ISimple[] {};
    }

    private void IndexStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIndexData(QueryStrings.PageIndex);

        IndexGrid.DataBind();
        
        DataGridItem item = (DataGridItem)((WebControl)sender).Parent.Parent;
        
        IssueStatusSelect status = (IssueStatusSelect)sender;

        int index = item.ItemIndex;
        
        SetIssueStatus(((Issue[])IndexGrid.DataSource)[index].ID,
            status.SelectedStatus);    
    }
    

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    private void FilterButton_Click(object sender, EventArgs e)
    {
    	IssueFilterState.ShowPending = ShowPendingFilter.Checked;
    	
    	IssueFilterState.ShowResolved = ShowResolvedFilter.Checked;
    	
    	IssueFilterState.ShowClosed = ShowClosedFilter.Checked;
    	
    	Response.Redirect(IndexGrid.CompileNavigateUrl());
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageIssues %>
                    </div>
             
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageIssuesIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.ReportIssue %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                &nbsp;<asp:Button ID="LinkInfoButton" runat="server" Text='<%# Language.LinkInfo %>'
                                CssClass="Button" OnClick="LinkInfoButton_Click"></asp:Button>
                    	</div>
                    <div id="Filter">
                    	Filter:
                    	<asp:checkbox runat="server" id="ShowPendingFilter" text='<%# Language.Pending %>' checked='<%# (bool)IssueFilterState.ShowPending %>'/>
                    	<asp:checkbox runat="server" id="ShowResolvedFilter" text='<%# Language.Resolved %>' checked="<%# (bool)IssueFilterState.ShowResolved %>"/>
                    	<asp:checkbox runat="server" id="ShowClosedFilter" text='<%# Language.Closed %>' checked="<%# (bool)IssueFilterState.ShowClosed %>"/>
                    	<asp:button runat="server" id="FilterButton" text='<%# Language.ApplyFilter %>' onclick="FilterButton_Click"/>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="DateReportedDescending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Issues %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%" NavigateUrl='<%# Navigator.GetLink("Index", "Issue") %>'
                            EmptyDataText='<%# ProjectsState.ProjectSelected ? Language.NoIssuesForProject : Language.NoIssuesFound %>' OnItemCommand="IndexGrid_ItemCommand">

                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Utilities.Summarize((string)Eval("Subject"), 100) %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <div class="Details"><asp:Label runat="server" text='<%# Eval("DateReported") %>'></asp:Label>
                                    - <%= Language.Bugs %>: <%# Eval("TotalBugs") %>
                                    <asp:placeholder runat="server" visible='<%# Eval("ReporterName") != String.Empty || Eval("ReporterEmail") != String.Empty %>'>
                                    - <asp:hyperlink runat="server" navigateurl='<%# new UrlCreator().CreateUrl("Reply", "Issue") + "?IssueID=" + Eval("ID").ToString() %>' text='<%# Utilities.Summarize((string)Eval("ReporterName"), 100) %>' />
                                    </asp:placeholder>
                                    <asp:placeholder runat="server" visible='<%# Eval("Project") != null && !ProjectsState.ProjectSelected %>'>
                                    - <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)Eval("Project")) : String.Empty %>'><%# ProjectsState.ProjectSelected ? String.Empty : (string)Eval("Project.Name") %></a>
                                   	</asp:placeholder>
                                   	<asp:placeholder runat="server" visible='<%# Eval("ProjectVersion") != String.Empty %>'>
                                    - <%# Eval("ProjectVersion") %>
                                    </asp:placeholder>
                                    </div>
                                    <div class="Content"><%# Utilities.Summarize((string)Eval("Description"), 100) %>
                                    </div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>    
                               	<asp:TemplateColumn>
                                    <itemtemplate>
																<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Confirmed + "&BalanceProperty=ConfirmedVotesBalance&TotalProperty=TotalConfirmedVotes" %>' /></div>
																	<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Resolved + "&BalanceProperty=ResolvedVotesBalance&TotalProperty=TotalResolvedVotes" %>' /></div>
								</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <ic:IssueStatusSelect runat="server" id="IndexStatus" AutoPostBack="true" SelectedStatus='<%# (IssueStatus)Eval("Status") %>' OnSelectedIndexChanged='IndexStatus_SelectedIndexChanged'></ic:IssueStatusSelect>
                                    </ItemTemplate>
                                    </asp:TemplateColumn>
                              			<asp:TemplateColumn>
                              			<ItemStyle width="140" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                 <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditIssueToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteIssue %>' ToolTip='<%# Language.DeleteIssueToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
                            </itemtemplate>
                        </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "ReportIssue" ? Language.ReportIssue : Language.EditIssue %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "ReportIssue" ? Language.ReportIssueIntro : Language.EditIssueIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "ReportIssue" ? Language.NewIssueDetails : Language.IssueDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Subject" FieldControlID="Subject" text='<%# Language.Subject + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.IssueSubjectRequired %>'></ss:EntityFormTextBoxItem>
			  <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
				<ss:EntityFormTextBoxItem runat="server" PropertyName="HowToRecreate" FieldControlID="HowToRecreate" text='<%# Language.HowToRecreate + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterName" FieldControlID="ReporterName" text='<%# Language.ReporterName + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterEmail" FieldControlID="ReporterEmail" text='<%# Language.ReporterEmail + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterPhone" FieldControlID="ReporterPhone" text='<%# Language.ReporterPhone + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
				   
			<ss:EntityFormCheckBoxItem runat="server" PropertyName="NeedsReply" FieldControlID="NeedsReply" text='<%# Language.RequestReply + ":" %>' CheckBox-Text='<%# Language.YesReplyToIssue %>'></ss:EntityFormCheckBoxItem>
			
						  <ss:EntityFormItem runat="server" PropertyName="Status" FieldControlID="Status" ControlValuePropertyName="SelectedStatus"
                              text='<%# Language.Status + ":" %>'>
                              <FieldTemplate>
                                  <ic:IssueStatusSelect runat="server" width="200" id="Status">
                                  </ic:IssueStatusSelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          <ss:EntityFormItem runat="server" PropertyName="Priority" FieldControlID="Priority" ControlValuePropertyName="SelectedPriority"
                              text='<%# Language.Priority + ":" %>'>
                              <FieldTemplate>
                                  <cc:PrioritySelect runat="server" width="200" id="Priority">
                                  </cc:PrioritySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				 			  <ss:EntityFormItem runat="server" enabled='<%# ProjectsState.ProjectSelected %>' PropertyName="Bugs" FieldControlID="Bugs" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Bugs + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400px" enabled='<%# ProjectsState.ProjectSelected %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Bug, SoftwareMonkeys.WorkHub.Modules.Maintenance" runat="server"
                                      TextPropertyName="Title" id="Bugs" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Bugs"
                                      NoDataText='<%# "-- " + Language.NoBugs + " --" %>' OnDataLoading='BugsSelect_DataLoading'>
                                  </ss:EntitySelect><br />
                                    <ss:EntitySelectRequester visible='<%# ProjectsState.ProjectSelected %>' runat="server" id="BugRequester" EntitySelectControlID="Bugs"
                                  	text='<%# Language.ReportBug + " &raquo;" %>'
                                  	DeliveryPage='<%# UrlCreator.Current.CreateUrl("Report", "Bug") %>'
                                  	WindowWidth="650px" WindowHeight="650px"
                                  	EntityType="Issue" EntityID='<%# DataForm.EntityID %>'
                                  	TransferData="Title=Subject&Description=Description"
                                  	/>
                              </FieldTemplate>
                          </ss:EntityFormItem>
						   <ss:EntityFormItem runat="server" PropertyName="Tasks" FieldControlID="Tasks" ControlValuePropertyName="SelectedEntities" text='<%# Language.Tasks + ":" %>' visible='<%# EntityState.Entities.EntityExists("Task") %>'><FieldTemplate><ss:EntitySelect
                                 ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Tasks"
                                 enabled='<%# EntityState.Entities.EntityExists("Task") %>' width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" runat="server" TextPropertyName="Title" id="Tasks" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.Select + " " + Language.Tasks + " --" %>' OnDataLoading='TasksSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                          <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
                           <ss:EntityFormItem runat="server" PropertyName="Project" FieldControlID="Project" ControlValuePropertyName="SelectedEntity" text='<%# Language.Project + ":" %>'><FieldTemplate><ss:EntitySelect
							enabled='<%# OperationManager.CurrentOperation == "ReportIssue" %>' ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty='Project' runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts" id="Project" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
			<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "ReportIssue" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditIssue" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <h1>
                           <%# Language.Issue + ": " + HtmlTools.FormatText(((Issue)DetailsForm.DataSource).Subject) %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# HtmlTools.FormatText(((Issue)DetailsForm.DataSource).Description) %></p>  
                                
								   <p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditIssue %>' CssClass="Button" OnClick="ViewEditButton_Click" />&nbsp;<asp:Button CssClass="Button" runat="server" ID="ViewResolvedButton" Text='<%# Language.ResolveIssue %>' OnClick="ViewResolvedButton_Click" />
                                    
																<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Confirmed + "&BalanceProperty=ConfirmedVotesBalance&TotalProperty=TotalConfirmedVotes" %>' />
																<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Resolved + "&BalanceProperty=ResolvedVotesBalance&TotalProperty=TotalResolvedVotes" %>' />
									</p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "ReportIssue" ? Language.NewIssueDetails : Language.IssueDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="HowToRecreate" FieldControlID="HowToRecreateLabel" text='<%# Language.HowToRecreate + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormItem runat="server" PropertyName="ReporterName" FieldControlID="ReporterName" text='<%# Language.ReporterName + ":" %>'>
                              <FieldTemplate>
                                  <a href='<%# Navigator.GetLink("Reply", "Issue") + "?IssueID=" + DetailsForm.EntityID.ToString() %>'><asp:Label runat="server" text='<%# Utilities.Summarize((((Issue)DetailsForm.DataSource).ReporterName), 100) %>'></asp:Label></a>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				
				<ss:EntityFormItem runat="server" PropertyName="ReporterPhone" FieldControlID="ReporterPhone" text='<%# Language.ReporterPhone + ":" %>' visible='<%# AuthenticationState.IsAuthenticated && ((Issue)DetailsForm.DataSource).Project.HasManager(AuthenticationState.User.ID) %>'>
                              <FieldTemplate>
                                  <asp:Label runat="server" text='<%# AuthenticationState.IsAuthenticated && ((Issue)DetailsForm.DataSource).Project.HasManager(AuthenticationState.User.ID) ? ((Issue)DetailsForm.DataSource).ReporterPhone : "<i>[" + Language.Hidden + "]</i>" %>'></asp:Label>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
				<ss:EntityFormLabelItem runat="server" PropertyName="DateReported" FieldControlID="DateReportedLabel" text='<%# Language.DateReported + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="DateResolved" FieldControlID="DateResolvedLabel" text='<%# Language.DateResolved + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="NeedsReply" FieldControlID="NeedsReplyLabel" text='<%# Language.NeedsReply + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Status" FieldControlID="StatusLabel" text='<%# Language.Status + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Priority" FieldControlID="PriorityLabel" text='<%# Language.Priority + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				 
				</ss:EntityForm>
				            <h2><%= Language.Bugs %></h2>
                 <ss:EntityTree runat="server" id="ViewIssueBugs" NoDataText='<%# Language.NoBugsForIssue %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Bug, SoftwareMonkeys.WorkHub.Modules.Maintenance" BranchesProperty="" DataSource='<%# ((Issue)DetailsForm.DataSource).Bugs %>'>
                </ss:EntityTree>
                 <asp:placeholder runat="server" visible='<%# EntityState.Entities.EntityExists("Task") %>'>
				            <h2><%= Language.Tasks %></h2>
                 <ss:EntityTree runat="server" id="ViewIssueTasks" NoDataText='<%# Language.NoTasksForIssue %>' EntityType="SoftwareMonkeys.WorkHub.Entities.ISimple, SoftwareMonkeys.WorkHub.Contracts" BranchesProperty="" DataSource='<%# ((Issue)DetailsForm.DataSource).Tasks %>'>
                </ss:EntityTree>
                </asp:placeholder>
                
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
    </asp:MultiView>