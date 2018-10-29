<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Maintenance" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            switch (QueryStrings.Action)
            {
                case "ViewBug":
                    ViewBug(Utilities.GetQueryStringID("BugID"));
                    break;
                case "View":
                	if (QueryStrings.GetID("Bug") != Guid.Empty)
                		ViewBug(QueryStrings.GetID("Bug"));
                	break;
                case "Delete":
                	if (QueryStrings.GetID("Bug") != Guid.Empty)
                		DeleteBug(QueryStrings.GetID("Bug"));
                	break;
                default:
                    ManageBugs();
                    break;
            }
        }
    }
    
    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        IndexGrid.AddSortItem(Language.DateReported + " " + Language.Asc, "DateReportedAscending");
        IndexGrid.AddSortItem(Language.DateReported + " " + Language.Desc, "DateReportedDescending");
        IndexGrid.AddSortItem(Language.Description + " " + Language.Asc, "DescriptionAscending");
        IndexGrid.AddSortItem(Language.Description + " " + Language.Desc, "DescriptionDescending");
        IndexGrid.AddSortItem(Language.Difficulty + " " + Language.Asc, "DifficultyAscending");
        IndexGrid.AddSortItem(Language.Difficulty + " " + Language.Desc, "DifficultyDescending");
        IndexGrid.AddSortItem(Language.Priority + " " + Language.Asc, "PriorityAscending");
        IndexGrid.AddSortItem(Language.Priority + " " + Language.Desc, "PriorityDescending"); 
        IndexGrid.AddSortItem(Language.Status + " " + Language.Asc, "StatusAscending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Desc, "StatusDescending"); 
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        IndexGrid.AddDualSortItem(Language.TotalIssues, "TotalIssues");
        IndexGrid.AddDualSortItem(Language.TotalSolutions, "TotalSolutions");


    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing bugs.
    /// </summary>
    public void ManageBugs(int pageIndex)
    {
		using (LogGroup logGroup = LogGroup.Start("Displays the index for managing bugs.", NLog.LogLevel.Debug))
		{
		        IndexGrid.CurrentPageIndex = pageIndex;
	
		        OperationManager.StartOperation("ManageBugs", IndexView);
	
		        Bug[] bugs = LoadIndexData(pageIndex);
	
		        Authorisation.EnsureUserCan("View", bugs);
		    	
        		WindowTitle = Language.Bugs;
        		if (ProjectsState.ProjectSelected)
        			WindowTitle = Language.Bugs + ": " + ProjectsState.ProjectName;
        
	        	IndexView.DataBind();
		}
    }

    /// <summary>
    /// Displays the index for managing bugs on the first page.
    /// </summary>
    public void ManageBugs()
    {
        ManageBugs(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new bug.
    /// </summary>
    public void ReportBug()
    {
    	Navigator.Go("Report", "Bug");
    }

    /// <summary>
    /// Deletes the bug with the provided ID.
    /// </summary>
    /// <param name="bugID">The ID of the bug to delete.</param>
    private void DeleteBug(Guid bugID)
    {
    	DeleteBug(RetrieveStrategy.New<Bug>().Retrieve<Bug>("ID", bugID));
    }
    
    private void DeleteBug(Bug bug)
    {
        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("Delete", bug);

        // Delete the bug
        DeleteStrategy.New<Bug>().Delete(bug);
    
        // Display the result
        Result.Display(Language.BugDeleted);

        // Go back to the index
        Navigator.Go("Index", "Bug");
    }

    /// <summary>
    /// Displays the details of the bug with the specified ID.
    /// </summary>
    /// <param name="bugID">The ID of the bug to display.</param>
    private void ViewBug(Guid bugID)
    {
    	ViewBug(RetrieveStrategy.New<Bug>().Retrieve<Bug>("ID", bugID));
    }
    
    private void ViewBug(Bug bug)
    {
        // Declare the current operation
        OperationManager.StartOperation("ViewBug", DetailsView);

       	ActivateStrategy.New<Bug>().Activate(bug);

        DetailsForm.DataSource = bug;

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", (Bug)DetailsForm.DataSource);
        
        WindowTitle = Language.Bug + ": " + bug.Title;

        // Bind the form
        DetailsView.DataBind();
    }

    /// <summary>
    /// Sets the specified bug's status.
    /// </summary>
    /// <param name="bugID">The ID to set the status of.</param>
    /// <param name="status">The status to set to the bug.</param>
    private void SetBugStatus(Guid bugID, BugStatus status)
    {
        Authorisation.EnsureUserCan
        (
        	"Edit",
        	RetrieveStrategy.New<Bug>().Retrieve<Bug>(bugID)
        );
        
    	UpdateBugStatusStrategy.New().UpdateBugStatus(bugID, status);

        Result.Display(Language.BugStatusUpdated);

        ManageBugs(IndexGrid.CurrentPageIndex);
    }

    private Bug[] LoadIndexData(int pageIndex)
    {
        Bug[] bugs = null;
        int total = 0;

        //if (ProjectsState.EnsureProjectSelected())
        //{
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
            bugs = IndexBugStrategy.New(location, IndexGrid.CurrentSort).Index(ProjectsState.ProjectID,
            		BugFilterState.ShowPending,
            		BugFilterState.ShowInProgress,
            		BugFilterState.ShowOnHold,
            		BugFilterState.ShowFixed,
            		BugFilterState.ShowTested);
            	
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        IndexGrid.DataSource = bugs;

        //}

        return bugs;
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
    	ReportBug();
    }

    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
       	if (e.CommandName == "Delete")
        {
            DeleteBug(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewBug(new Guid(e.CommandArgument.ToString()));
        }
    }
                    
    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageBugs();
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageBugs(e.NewPageIndex);
    }    
    
    private void ViewEditButton_Click(object sender, EventArgs e)
    {
         Navigator.Go("Edit", (IEntity)DetailsForm.DataSource);
    }    
    
    private void IndexStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIndexData(QueryStrings.PageIndex);

        IndexGrid.DataBind();

        DataGridItem item = (DataGridItem)((WebControl)sender).Parent.Parent;

        BugStatusSelect status = (BugStatusSelect)sender;

        int index = item.ItemIndex;

        SetBugStatus(((Bug[])IndexGrid.DataSource)[index].ID,
            status.SelectedStatus);   
    }
    
    
    private void FilterButton_Click(object sender, EventArgs e)
    {
    	BugFilterState.ShowPending = ShowPendingFilter.Checked;
    	
    	BugFilterState.ShowInProgress = ShowInProgressFilter.Checked;
    	
    	BugFilterState.ShowOnHold = ShowOnHoldFilter.Checked;
    	    	
    	BugFilterState.ShowFixed = ShowFixedFilter.Checked;
    	
    	BugFilterState.ShowTested = ShowTestedFilter.Checked;
    	
    	Response.Redirect(IndexGrid.CompileNavigateUrl());
    }
</script>

    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageBugs %>
                    </div>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageBugsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.ReportBug %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                    </div>
                    <div id="Filter">
                    	Filter:
                    	<asp:checkbox runat="server" id="ShowPendingFilter" text='<%# Language.Pending %>' checked='<%# (bool)BugFilterState.ShowPending %>'/>
                    	<asp:checkbox runat="server" id="ShowInProgressFilter" text='<%# Language.InProgress %>' checked="<%# (bool)BugFilterState.ShowInProgress %>"/>
                    	<asp:checkbox runat="server" id="ShowOnHoldFilter" text='<%# Language.OnHold %>' checked="<%# (bool)BugFilterState.ShowOnHold %>"/>
                    	<asp:checkbox runat="server" id="ShowFixedFilter" text='<%# Language.Fixed %>' checked="<%# (bool)BugFilterState.ShowFixed %>"/>
                    	<asp:checkbox runat="server" id="ShowTestedFilter" text='<%# Language.Tested %>' checked="<%# (bool)BugFilterState.ShowTested %>"/>
                    	<asp:button runat="server" id="FilterButton" text='<%# Language.ApplyFilter %>' onclick="FilterButton_Click"/>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="DateReportedDescending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Bugs %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="10" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoBugsForProject %>' OnItemCommand="IndexGrid_ItemCommand" NavigateUrl='<%# Navigator.GetLink("Index", "Bug") %>'>
                            <Columns>
                              
                                 <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div><asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink></div>
                                    <div><asp:Label runat="server" text='<%# Utilities.Summarize((string)Eval("Description"), 100) %>'></asp:Label></div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Content">
                                    	<a href='<%# Navigator.GetLink("Select", (IEntity)Eval("Project")) %>'><%# ProjectsState.ProjectSelected ? String.Empty : (string)Eval("Project.Name") %></a>
                                    </div>
                                    <div class="Content">
                                    	<%# Eval("Version") %>
                                    </div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    	<div><%= DynamicLanguage.GetText("Priority") %>: <%# PriorityUtilities.GetPriorityText((Priority)Eval("Priority")) %></div>
                                    	<div><%= DynamicLanguage.GetText("Difficulty") %>: <%# DifficultyUtilities.GetDifficultyText((Difficulty)Eval("Difficulty")) %></div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Content"><%= Language.Issues %>: <%# Eval("TotalIssues") %></div>
                                    <div class="Content"><%= Language.Solutions %>: <%# Eval("TotalSolutions") %></div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    	<%= Language.Type %>: <%# BugTypeUtilities.GetTypeText((BugType)Eval("Type")) %>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                               	<asp:TemplateColumn>
                                    <itemtemplate>
																<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Confirmed + "&BalanceProperty=ConfirmedVotesBalance&TotalProperty=TotalConfirmedVotes" %>' /></div>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Resolved + "&BalanceProperty=ResolvedVotesBalance&TotalProperty=TotalResolvedVotes" %>' /></div>
								</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <cc:BugStatusSelect runat="server" id="IndexStatus" AutoPostBack="true" SelectedStatus='<%# (BugStatus)Eval("Status") %>' OnSelectedIndexChanged='IndexStatus_SelectedIndexChanged'></cc:BugStatusSelect>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                              		<ItemStyle width="80" horizontalalign="right" wrap="false" />
		                            <itemtemplate>
		                               <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditBugToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																			</ASP:Hyperlink><br/>
																			<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteBug %>' ToolTip='<%# Language.DeleteBugToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																			</cc:DeleteLink>	
		                            </itemtemplate>
		                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <div class="Heading1">
                           <%# Language.Bug + ": " + HtmlTools.FormatText(((Bug)DetailsForm.DataSource).Title) %>
                   </div>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# HtmlTools.FormatText(((Bug)DetailsForm.DataSource).Description) %></p>
                   <p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditBug %>' CssClass="Button" OnClick="ViewEditButton_Click" />
                   <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Confirmed + "&BalanceProperty=ConfirmedVotesBalance&TotalProperty=TotalConfirmedVotes" %>' />
																<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Resolved + "&BalanceProperty=ResolvedVotesBalance&TotalProperty=TotalResolvedVotes" %>' /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "ReportBug" ? Language.NewBugDetails : Language.BugDetails %>' HeadingCssClass="Heading2">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="DateReported" FieldControlID="DateReportedLabel" text='<%# Language.DateReported + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Status" FieldControlID="StatusLabel" text='<%# Language.Status + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Priority" FieldControlID="PriorityLabel" text='<%# Language.Priority + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Difficulty" FieldControlID="DifficultyLabel" text='<%# Language.Difficulty + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Type" FieldControlID="TypeLabel" text='<%# Language.Type + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Version" FieldControlID="VersionLabel" text='<%# Language.Version + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="FixVersion" FieldControlID="FixVersionLabel" text='<%# Language.VersionToFixFor + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="PercentFixed" FieldControlID="PercentFixedLabel" text='<%# Language.PercentFixed + ":" %>'></ss:EntityFormLabelItem>
				
				</ss:EntityForm>
				            <div class="Heading2"><%= Language.Issues %></div>
                <ss:EntityTree runat="server" id="ViewBugIssues" NoDataText='<%# Language.NoIssuesForBug %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Issue, SoftwareMonkeys.WorkHub.Modules.Maintenance" DataSource='<%# ((Bug)DetailsForm.DataSource).Issues %>'>
                </ss:EntityTree>
				            <div class="Heading2"><%= Language.Solutions %></div>
                <ss:EntityTree runat="server" id="ViewBugSolutions" NoDataText='<%# Language.NoSolutionsForBug %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Solution, SoftwareMonkeys.WorkHub.Modules.Maintenance" DataSource='<%# ((Bug)DetailsForm.DataSource).Solutions %>'>
                </ss:EntityTree>
                 <asp:placeholder runat="server" visible='<%# EntityState.IsType("Task") %>'>
 			<h2><%= Language.Tasks %></h2>
                        <ss:EntityTree runat="server" id="ViewBugTasks" NoDataText='<%# Language.NoTasksForBug %>' EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts" DataSource='<%# ((Bug)DetailsForm.DataSource).Tasks %>'>
                        </ss:EntityTree>
            </asp:placeholder>
        </asp:View>
    </asp:MultiView>