<%@ Control Language="C#" ClassName="Solutions" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %><%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (QueryStrings.Action)
        {
           
            case "CreateSolution":
    			if (!IsPostBack)
                	CreateSolution();
                break;
            case "Create":
    			if (!IsPostBack)
                	CreateSolution();
                break;
            case "ViewSolution":
                ViewSolution(Utilities.GetQueryStringID("SolutionID"));
                break;
            case "View":
            	if (QueryStrings.GetID("Solution") != Guid.Empty)
            		ViewSolution(QueryStrings.GetID("Solution"));
            	break;
            case "Delete":
            	if (QueryStrings.GetID("Solution") != Guid.Empty)
            		DeleteSolution(QueryStrings.GetID("Solution"));
            	break;
            case "Edit":
    			if (!IsPostBack)
    			{
                	if (QueryStrings.GetID("Solution") != Guid.Empty)
                		EditSolution(QueryStrings.GetID("Solution"));                	
            	}
            	break;
            default:
            	if (!IsPostBack)
                	ManageSolutions();
                break;
        }
    }

    protected override void OnInit(EventArgs e)
    {
        // Add all the sort items to the index grid
        
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        
        IndexGrid.AddSortItem(Language.Instructions + " " + Language.Asc, "InstructionsAscending");
        IndexGrid.AddSortItem(Language.Instructions + " " + Language.Desc, "InstructionsDescending");
        
        IndexGrid.AddSortItem(Language.DateCreated + " " + Language.Asc, "DateCreatedAscending");
        IndexGrid.AddSortItem(Language.DateCreated + " " + Language.Desc, "DateCreatedDescending");
        
        IndexGrid.AddDualSortItem(Language.EffectiveVotesBalance, "EffectiveVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalEffectiveVotes, "TotalEffectiveVotes");
        
        base.OnInit(e);
    }


    #region Main functions
    /// <summary>
    /// Displays the index for managing solutions.
    /// </summary>
    public void ManageSolutions(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
        
        OperationManager.StartOperation("ManageSolutions", IndexView);

        Solution[] solutions = null;
        int total = 0;

        if (ProjectsState.IsEnabled)
        {
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
            if (ProjectsState.ProjectSelected)
            {
            	solutions = IndexStrategy.New<Solution>(location, IndexGrid.CurrentSort).IndexWithReference<Solution>("Project", "Project", ProjectsState.ProjectID);
            }
            else
            	solutions = IndexStrategy.New<Solution>(location, IndexGrid.CurrentSort).Index<Solution>();
           
           	ActivateStrategy.New<Solution>().Activate(solutions);
	    	
        	Authorisation.EnsureUserCan("View", solutions);
        	
        	
			WindowTitle = Language.Solutions;
			if (ProjectsState.ProjectSelected)
				WindowTitle = Language.Solutions + ": " + ProjectsState.ProjectName;
	
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        IndexGrid.DataSource = solutions;
        }
        else
            ProjectsState.EnsureProjectsEnabled();

        IndexView.DataBind();
    }
    
    /// <summary>
    /// Displays the index on the first page for managing solutions.
    /// </summary>
    public void ManageSolutions()
    {
        ManageSolutions(0);
    }

    /// <summary>
    /// Displays the form for creating a new solution.
    /// </summary>
    public void CreateSolution()
    {
        // Ensure that the user can create a new solution
        Authorisation.EnsureUserCan("Create", typeof(Solution));

        if (ProjectsState.EnsureProjectSelected())
        {
            // Declare the current operation
            OperationManager.StartOperation("CreateSolution", FormView);

            // Create the default solution
            Solution solution = new Solution();
            solution.ID = Guid.NewGuid();
            solution.Project = ProjectsState.Project;
            solution.DateCreated = DateTime.Now;
	    // TODO: Add default values    

            // Assign the default solution to the form
            DataForm.DataSource = solution;
            
        	WindowTitle = Language.CreateSolution;

            // Bind the form
            FormView.DataBind();
        }
    }

    /// <summary>
    /// Displays the form for editing the specified solution.
    /// </summary>
    /// <param name="solutionID"></param>
    public void EditSolution(Guid solutionID)
    {
    	EditSolution(RetrieveStrategy.New<Solution>().Retrieve<Solution>("ID", solutionID));
    }
    
    public void EditSolution(Solution solution)
    {
        // Declare the current operation
        OperationManager.StartOperation("EditSolution", FormView);

        // Get the existing data for the specified solution
        DataForm.DataSource = solution;
        
        ActivateStrategy.New(solution).Activate(solution);

        // Ensure that the user can edit the specified solution
        Authorisation.EnsureUserCan("Edit", (Solution)DataForm.DataSource);
        
        WindowTitle = Language.EditSolution + ": " + solution.Title;

        // Bind the form
        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created solution.
    /// </summary>
    private void SaveSolution()
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Saving solution from form."))
    	{
	        // Reverse bind the data back to the object
	        DataForm.ReverseBind();
	
			Solution solution = (Solution)DataForm.DataSource;
	
	      	LogWriter.Debug("Solution title: " + solution.Title);
	      	
	        // Save the new solution
	        if (SaveStrategy.New<Solution>().Save(solution))
	        {
	            // Display the result to the solution
	            Result.Display(Language.SolutionSaved);
	
	
	             // TODO: Figure out a better way around this.
				// Due to the new navigator redirecting instead of just loading after postback the javascript based deliverer
				// control is unable to load. This fix only uses the new navigator when this save action is not being done through a sub
				// window of another form 
				if (Request.QueryString["AutoReturn"] != null && Request.QueryString["AutoReturn"].ToLower() == "true")
	            	Close();
	            else
	        		Navigator.Go("View", solution);
	        }
	        else
	            Result.Display(Language.SolutionTitleTaken);
        }
            
    }

    /// <summary>
    /// Updates the solution.
    /// </summary>
    private void UpdateSolution()
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Updating solution from form."))
    	{
	        // Get a fresh copy of the solution object
	        Solution solution = RetrieveStrategy.New<Solution>().Retrieve<Solution>("ID", ((Solution)DataForm.DataSource).ID);
	      
	      	LogWriter.Debug("Previous solution title: " + solution.Title);
	      	
	      	ActivateStrategy.New<Solution>().Activate(solution);
	      
	        // Transfer data from the form to the object
	        DataForm.ReverseBind(solution);
	
			LogWriter.Debug("New solution title: " + solution.Title);
	
	        // Update the new solution
	        if (UpdateStrategy.New<Solution>().Update(solution))
	        {
	            // Display the result to the solution
	            Result.Display(Language.SolutionUpdated);
	
	       		Navigator.Go("View", solution);
	        }
	        else
	            Result.Display(Language.SolutionTitleTaken);
        }

    }



    /// <summary>
    /// Deletes the solution with the provided ID.
    /// </summary>
    /// <param name="solutionID">The ID of the solution to delete.</param>
    private void DeleteSolution(Guid solutionID)
    {
    	DeleteSolution(RetrieveStrategy.New<Solution>().Retrieve<Solution>("ID", solutionID));
    }
    
    private void DeleteSolution(Solution solution)
    {
        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("Delete", solution);

        // Delete the solution
        DeleteStrategy.New<Solution>().Delete(solution);
        
        // Display the result
        Result.Display(Language.SolutionDeleted);

        // Go back to the index
        Navigator.Go("Index", "Solution");
    }

    /// <summary>
    /// Displays the details of the solution with the specified ID.
    /// </summary>
    /// <param name="solutionID">The ID of the solution to display.</param>
    private void ViewSolution(Guid solutionID)
    {
    	ViewSolution(RetrieveStrategy.New<Solution>().Retrieve<Solution>("ID", solutionID));
    }
    
    private void ViewSolution(Solution solution)
    {
    	if (solution == null)
    		throw new ArgumentNullException("solution");
    
        // Declare the current operation
        OperationManager.StartOperation("ViewSolution", DetailsView);
        
        ActivateStrategy.New<Solution>().Activate(solution);
        
        ViewSolutionBugs.DataSource = solution.Bugs;
        
        DetailsForm.DataSource = solution;

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", (Solution)DetailsForm.DataSource);    
        
        WindowTitle = Language.Solution + ": " + solution.Title;

        // Bind the form
        DetailsView.DataBind();
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new solution
        CreateSolution();
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Navigator.Go("Edit", RetrieveStrategy.New<Solution>().Retrieve<Solution>("ID", new Guid(e.CommandArgument.ToString())));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteSolution(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewSolution(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveSolution();
        }
        else if (e.CommandName == "Update")
        {
            UpdateSolution();
        }
		else if (e.CommandName == "Cancel")
		{
			ManageSolutions();
		}
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageSolutions();
    }                     
                 

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageSolutions(e.NewPageIndex);
    }

    private void CancelButton_Click(object sender, EventArgs e)
    {
        if (OperationManager.PreviousOperation == "ViewSolution")
            ViewSolution(((Solution)DetailsForm.DataSource).ID);
        else
            ManageSolutions();
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Navigator.Go("Edit", (Solution)DetailsForm.DataSource);
    }
    
    protected void BugsSelect_DataLoading(object sender, EventArgs e)
    {
    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Bug>().IndexWithReference<Bug>("Project", "Project", ProjectsState.ProjectID);
		else
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Bug>().Index<Bug>();
    }

    private void Close()
    {
    	PageView.SetActiveView(CloseView);
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">
            <h1>
                        <%= Language.ManageSolutions %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageSolutionsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateSolution %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="TitleAscending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Solutions %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoSolutionsForProject %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                                                  <asp:TemplateColumn>
                                                                  <ItemStyle width="70%" />
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Utilities.Summarize((string)Eval("Instructions"), 120) %>'></asp:Label>
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
					<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' /></div>
					</itemtemplate>
                                </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditSolutionToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteSolution %>' ToolTip='<%# Language.DeleteSolutionToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateSolution" ? Language.CreateSolution : Language.EditSolution %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateSolution" ? Language.CreateSolutionIntro : Language.EditSolutionIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateSolution" ? Language.NewSolutionDetails : Language.SolutionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" Visible="true" PropertyName="Title" FieldControID="SolutionTitle" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.SolutionTitleRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" Visible="true" PropertyName="Instructions" FieldControlID="Instructions" text='<%# Language.Instructions + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="10"></ss:EntityFormTextBoxItem>
			 		<ss:EntityFormItem runat="server" PropertyName="Bugs" FieldControlID="Bugs" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Bugs + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Bug, SoftwareMonkeys.WorkHub.Modules.Maintenance" runat="server"
                                      TextPropertyName="Title" id="Bugs" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Bugs"
                                      NoSelectionText='<%# "-- " + Language.SelectBugs + " --" %>' OnDataLoading='BugsSelect_DataLoading'>
                                  </ss:EntitySelect><br />
                                  <ss:EntitySelectRequester runat="server" id="BugRequester" EntitySelectControlID="Bugs"
                                  	text='<%# Language.ReportBug + " &raquo;" %>'
                                  	DeliveryPage='<%# UrlCreator.Current.CreateUrl("Report", "Bug") %>'
                                  	WindowWidth="650px" WindowHeight="600px"
                                  	EntityType="Bug" EntityID='<%# DataForm.EntityID %>'
                                  	TransferData="Title=Title&Description=Instructions"
                                  	/>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                           <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateSolution" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditSolution" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <h1>
                           <%# Language.Solution + ": " + HtmlTools.FormatText(((Solution)DetailsForm.DataSource).Title) %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# HtmlTools.FormatText(((Solution)DetailsForm.DataSource).Instructions) %></p>  
<p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditSolution %>' CssClass="Button" OnClick="ViewEditButton_Click" />
<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateSolution" ? Language.NewSolutionDetails : Language.SolutionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="DateCreated" FieldControlID="DateCreatedLabel" text='<%# Language.DateCreated + ":" %>'></ss:EntityFormLabelItem>
				<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				   
				</ss:EntityForm>
				            <h2><%= Language.Bugs %></h2>
                  <ss:EntityTree runat="server" id="ViewSolutionBugs" NoDataText='<%# Language.NoBugsForSolution %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities.Bug, SoftwarEMonkeys.WorkHub.Modules.Maintenance" BranchesProperty="" DataSource='<%# ((Solution)DetailsForm.DataSource).Bugs %>'>
                </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
        <asp:View id="CloseView" runat="server">
			<ss:EntitySelectDeliverer runat="server" id="DelivererToBug" TransferFields="Title,Instructions"
			 	TextControlID="Title" EntityID='<%# DataForm.EntityID %>' SourceEntityType="Bug"/>
        </asp:View>
    </asp:MultiView>