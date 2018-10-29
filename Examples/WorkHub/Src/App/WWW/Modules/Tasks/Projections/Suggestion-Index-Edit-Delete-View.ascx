<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Tasks" TagPrefix="ic" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (QueryStrings.Action)
        {
            case "CreateSuggestion":
            	if (!IsPostBack)
                	CreateSuggestion();
                break;
            case "ViewSuggestion":
            	if (!IsPostBack)
                	ViewSuggestion(Utilities.GetQueryStringID("SuggestionID"));
                break;
            case "Delete":
            	if (!IsPostBack)
            	{
	            		DeleteSuggestion(QueryStrings.GetID("Suggestion"));
           		}
            	break;
            case "View":
                	ViewSuggestion(QueryStrings.GetID("Suggestion"));
            	break;
            case "Edit":
            	if (!IsPostBack)
                	EditSuggestion(QueryStrings.GetID("Suggestion"));
            	break;
            default:
            	if (!IsPostBack)
                	ManageSuggestions();
                break;
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        IndexGrid.AddSortItem(Language.DatePosted + " " + Language.Asc, "DatePostedAscending");
        IndexGrid.AddSortItem(Language.DatePosted + " " + Language.Desc, "DatePostedDescending");
        IndexGrid.AddSortItem(Language.AuthorEmail + " " + Language.Asc, "AuthorEmailAscending");
        IndexGrid.AddSortItem(Language.AuthorEmail + " " + Language.Desc, "AuthorEmailDescending");
        IndexGrid.AddSortItem(Language.AuthorName + " " + Language.Asc, "AuthorNameAscending");
        IndexGrid.AddSortItem(Language.AuthorName + " " + Language.Desc, "AuthorNameDescending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Asc, "StatusAscending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Desc, "StatusDescending");
        IndexGrid.AddSortItem(Language.Subject + " " + Language.Asc, "SubjectAscending");
        IndexGrid.AddSortItem(Language.Subject + " " + Language.Desc, "SubjectDescending");
        
        IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "TotalDemandVotes");
        IndexGrid.AddDualSortItem(Language.ImplementedVotesBalance, "ImplementedVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalImplementedVotes, "TotalImplementedVotes");
        
        IndexGrid.AddDualSortItem(Language.TotalTasks, "TotalTasks");
    }
    
    #region Main functions
    /// <summary>
    /// Displays the index for managing suggestions.
    /// </summary>
    /// <param name="pageIndex">The index of the page of suggestions to manage.</param>
    public void ManageSuggestions(int pageIndex)
    {
        // Set the index of the grid
        IndexGrid.CurrentPageIndex = pageIndex;

        // Declare the current operation
        OperationManager.StartOperation("ManageSuggestions", IndexView);

        // Load the data for the index
        Suggestion[] suggestions = LoadIndexData(pageIndex);

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", suggestions);
        
		WindowTitle = Language.Suggestions;
		if (ProjectsState.ProjectSelected)
			WindowTitle = Language.Suggestions + ": " + ProjectsState.ProjectName;

        // Bind the index
        IndexView.DataBind();
    }

    /// <summary>
    /// Displays the index for managing suggestions.
    /// </summary>
    public void ManageSuggestions()
    {
        ManageSuggestions(QueryStrings.PageIndex);
    }
    
    /// <summary>
    /// Displays the form for creating a new suggestion.
    /// </summary>
    public void CreateSuggestion()
    {
	    if (!Request.IsAuthenticated)
            Response.Redirect(UrlCreator.Current.CreateUrl("Tasks", "PostSuggestion"));

            OperationManager.StartOperation("CreateSuggestion", FormView); 
      		 Authorisation.EnsureUserCan("Create", typeof(Suggestion));

         

        Suggestion suggestion = CreateStrategy.New<Suggestion>().Create<Suggestion>();
        suggestion.ID = Guid.NewGuid();
        suggestion.DatePosted = DateTime.Now;
        suggestion.Status = SuggestionStatus.Pending;
        if (AuthenticationState.User != null)
        	suggestion.Author = AuthenticationState.User;
        if (ProjectsState.ProjectSelected)
            suggestion.Project = ProjectsState.Project;
        DataForm.DataSource = suggestion;
        
    		WindowTitle = Language.CreateSuggestion;

        FormView.DataBind();
    }

    /// <summary>
    /// Displays the form for editing the specified suggestion.
    /// </summary>
    /// <param name="suggestionID"></param>
    public void EditSuggestion(Guid suggestionID)
    {
    	EditSuggestion(RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>(
    			"ID", suggestionID));
    }
    
    public void EditSuggestion(Suggestion suggestion)
    {
    	if (suggestion == null)
    		Navigator.Go("Index", "Suggestion");
    	else
    	{
	        OperationManager.StartOperation("EditSuggestion", FormView);
	
	        DataForm.DataSource = suggestion;
	
	        Authorisation.EnsureUserCan("Edit", suggestion);
	        
	        WindowTitle = Language.EditSuggestion + ": " + suggestion.Subject;
	
	        FormView.DataBind();
        }
    }

    /// <summary>
    /// Saves the newly created suggestion.
    /// </summary>
    private void SaveSuggestion()
    {
        DataForm.ReverseBind();
        
        Suggestion suggestion = (Suggestion)DataForm.DataSource;
        
        // Save the new suggestion
        SaveStrategy.New<Suggestion>().Save(suggestion);

        // Display the result to the suggestion
        Result.Display(Language.SuggestionSaved);

        // Show the index again
        Navigator.Go("View", suggestion);
    }

    /// <summary>
    /// Updates the suggestion.
    /// </summary>
    private void UpdateSuggestion()
    {
        // Get a fresh copy of the suggestion object
        Suggestion suggestion = RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>(((Suggestion)DataForm.DataSource).ID);
      
      	ActivateStrategy.New<Suggestion>().Activate(suggestion);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(suggestion);
        
        UpdateStrategy.New<Suggestion>().Update(suggestion);

        // Display the result to the suggestion
        Result.Display(Language.SuggestionUpdated);

        // Show the index again
        Navigator.Go("Index", "Suggestion");
    }

    /// <summary>
    /// Deletes the suggestion with the provided ID.
    /// </summary>
    /// <param name="suggestionID">The ID of the suggestion to delete.</param>
    private void DeleteSuggestion(Guid suggestionID)
    {
    	DeleteSuggestion(RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>(
    			"ID", suggestionID));
    }
    
    private void DeleteSuggestion(Suggestion suggestion)
    {
    	if (suggestion == null)
    		Navigator.Go("Index", "Suggestion");
    	else
    	{
	        Authorisation.EnsureUserCan("Delete", suggestion);
	        
	        // Delete the suggestion
	        DeleteStrategy.New<Suggestion>().Delete(suggestion);
	        
	        // Display the result
	        Result.Display(Language.SuggestionDeleted);
	
	        // Go back to the index
	        Navigator.Go("Index", "Suggestion");
        }
    }

    /// <summary>
    /// Displays the details of the suggestion with the specified ID.
    /// </summary>
    /// <param name="suggestionID">The ID of the suggestion to display.</param>
    private void ViewSuggestion(Guid suggestionID)
    {
    	ViewSuggestion(RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>("ID", suggestionID));
    }

	private void ViewSuggestion(Suggestion suggestion)
    {
    	if (suggestion == null)
    		Navigator.Go("Index", "Suggestion");
    	else
    	{
	        OperationManager.StartOperation("ViewSuggestion", DetailsView);
	
	        ActivateStrategy.New<Suggestion>().Activate(suggestion);
	        DetailsForm.DataSource = suggestion;
	
	        Authorisation.EnsureUserCan("View", (Suggestion)DetailsForm.DataSource);
	        
	        WindowTitle = Language.Suggestion + ": " + suggestion.Subject;
	        
	        DetailsView.DataBind();
        }
    }

    /// <summary>
    /// Sets the specified suggestion's status.
    /// </summary>
    /// <param name="suggestionID">The ID of the suggestion to set the status of.</param>
    /// <param name="status">The status to set to the suggestion.</param>
    private void SetSuggestionStatus(Guid suggestionID, SuggestionStatus status)
    {
        Authorisation.EnsureUserCan
        (
        	"Edit",
        	RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>(suggestionID)
        );
        
        UpdateSuggestionStatusStrategy.New().UpdateSuggestionStatus(suggestionID, status);

        Result.Display(Language.SuggestionStatusUpdated);

        Response.Redirect(IndexGrid.CompileNavigateUrl());
    }

    private Suggestion[] LoadIndexData(int pageIndex)
    {
        Suggestion[] suggestions = null;

        PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
        if (ProjectsState.IsEnabled)
        {
        	suggestions = IndexSuggestionStrategy.New(location, IndexGrid.CurrentSort).Index(ProjectsState.ProjectID,
	        	SuggestionFilterState.ShowPending,
	        	SuggestionFilterState.ShowAccepted,
	        	SuggestionFilterState.ShowImplemented);
        }
        else
            throw new Exception("The Projects modules is required and was not found.");
            
            ActivateStrategy.New<Suggestion>().Activate(suggestions);

        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
        IndexGrid.DataSource = suggestions;

        return suggestions;
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
	    	Response.Redirect(UrlCreator.Current.CreateUrl("Post", "Suggestion"));
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditSuggestion(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteSuggestion(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewSuggestion(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveSuggestion();
        }
        else if (e.CommandName == "Update")
        {
            UpdateSuggestion();
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        Response.Redirect(IndexGrid.CompileNavigateUrl());
    }

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        Response.Redirect(IndexGrid.CompileNavigateUrl(e.NewPageIndex, IndexGrid.CurrentSort));
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
        Navigator.Go("Edit", (IEntity)DetailsForm.DataSource);
    }

    private void CancelButton_Click(object sender, EventArgs e)
    {
        if (OperationManager.PreviousOperation == "ViewSuggestion")
            ViewSuggestion(((Suggestion)DetailsForm.DataSource).ID);
        else
            ManageSuggestions();
    }

    protected void TasksSelect_DataLoading(object sender, EventArgs e)
    {
    	if (ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().IndexWithReference<Task>("Project", "Project",ProjectsState.ProjectID);
	    else
	        ((EntitySelect)sender).DataSource = IndexStrategy.New<Task>().Index<Task>();
    }

    private void IndexStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadIndexData(QueryStrings.PageIndex);

        IndexGrid.DataBind();
        
        DataGridItem item = (DataGridItem)((WebControl)sender).Parent.Parent;
        
        SuggestionStatusSelect status = (SuggestionStatusSelect)sender;

        int index = item.ItemIndex;
        
        SetSuggestionStatus(((Suggestion[])IndexGrid.DataSource)[index].ID,
            status.SelectedStatus);    
    }
    

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
    private string WriteUserDetails(string name, string email)
    {
    	string output = name;
    	
    	if (name != String.Empty && email != String.Empty)
    		output += "&nbsp;|&nbsp;";
    		
    	output += email;
    		
    	return output;
    }
    
    
    protected void LinkInfoButton_Click(object sender, EventArgs e)
    {
		Navigator.Go("ViewLinkInfo", "Suggestion");
    }
    
    
    private void FilterButton_Click(object sender, EventArgs e)
    {
    	SuggestionFilterState.ShowPending = ShowPendingFilter.Checked;
    	
    	SuggestionFilterState.ShowAccepted = ShowAcceptedFilter.Checked;
    	
    	SuggestionFilterState.ShowImplemented = ShowImplementedFilter.Checked;
    	
    	Response.Redirect(IndexGrid.CompileNavigateUrl());
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageSuggestions %>
                    </div>
              
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageSuggestionsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateSuggestion %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                &nbsp;<asp:Button ID="LinkInfoButton" runat="server" Text='<%# Language.LinkInfo %>'
                                CssClass="Button" OnClick="LinkInfoButton_Click"></asp:Button>
                    </div>
                    <div id="Filter">
                    	Filter:
                    	<asp:checkbox runat="server" id="ShowPendingFilter" text='<%# Language.Pending %>' checked='<%# (bool)SuggestionFilterState.ShowPending %>'/>
                    	<asp:checkbox runat="server" id="ShowAcceptedFilter" text='<%# Language.Accepted %>' checked="<%# (bool)SuggestionFilterState.ShowAccepted %>"/>
                    	<asp:checkbox runat="server" id="ShowImplementedFilter" text='<%# Language.Implemented %>' checked="<%# (bool)SuggestionFilterState.ShowImplemented %>"/>
                    	<asp:button runat="server" id="FilterButton" text='<%# Language.ApplyFilter %>' onclick="FilterButton_Click"/>
                    </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="DemandVotesBalanceDescending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Suggestions %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                           GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# ProjectsState.ProjectSelected ? Language.NoSuggestionsForProject : Language.NoSuggestionsFound %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
	                            <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title"><asp:Hyperlink runat="server" text='<%# Eval("Subject") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink></div>
                                    <div class="Details"><asp:Label runat="server" text='<%# Eval("DatePosted") %>'></asp:Label>
                                    <asp:placeholder runat="server" visible='<%# Eval("Project") != null && !ProjectsState.ProjectSelected %>'>| <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)Eval("Project")) : String.Empty %>'><%# ProjectsState.ProjectSelected || Eval("Project") == null ? String.Empty : (string)Eval("Project.Name") %></a></asp:placeholder></div>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                 <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <a href='<%# Navigator.GetLink("Reply", "Suggestion") + "?SuggestionID=" + Eval("ID").ToString() %>'><asp:Label runat="server" text='<%# Utilities.Summarize((string)Eval("AuthorName"), 100) %>'></asp:Label></a>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
												<div><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
												<div><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Implemented + "&BalanceProperty=ImplementedVotesBalance&TotalProperty=TotalImplementedVotes" %>' /></div>
								</itemtemplate>
                                </asp:TemplateColumn>
                                 <asp:TemplateColumn>
                                    <ItemTemplate>
                                   <%= Language.Tasks %>: <%# Eval("TotalTasks") %>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <ic:SuggestionStatusSelect runat="server" id="IndexStatus" AutoPostBack="true" SelectedStatus='<%# (SuggestionStatus)Eval("Status") %>' OnSelectedIndexChanged='IndexStatus_SelectedIndexChanged'></ic:SuggestionStatusSelect>
                                    </ItemTemplate>
                                    </asp:TemplateColumn>
                              			<asp:TemplateColumn>
                              			<ItemStyle width="140" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                 <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditSuggestionToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'/>
                                &nbsp;<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteSuggestion %>' ToolTip='<%# Language.DeleteSuggestionToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateSuggestion" ? Language.CreateSuggestion : Language.EditSuggestion %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateSuggestion" ? Language.CreateSuggestionIntro : Language.EditSuggestionIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateSuggestion" ? Language.NewSuggestionDetails : Language.SuggestionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Subject" FieldControlID="Subject" text='<%# Language.Subject + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.SuggestionSubjectRequired %>'></ss:EntityFormTextBoxItem>
			  <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="AuthorName" FieldControlID="AuthorName" text='<%# Language.Name + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="AuthorEmail" FieldControlID="AuthorEmail" text='<%# Language.Email + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
						  <ss:EntityFormItem runat="server" PropertyName="Status" FieldControlID="Status" ControlValuePropertyName="SelectedStatus"
                              text='<%# Language.Status + ":" %>'>
                              <FieldTemplate>
                                  <ic:SuggestionStatusSelect runat="server" width="200" id="Status">
                                  </ic:SuggestionStatusSelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          <ss:EntityFormItem runat="server" PropertyName="Priority" FieldControlID="Priority" ControlValuePropertyName="SelectedPriority"
                              text='<%# Language.Priority + ":" %>'>
                              <FieldTemplate>
                                  <cc:PrioritySelect runat="server" width="200" id="Priority">
                                  </cc:PrioritySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				 			  <ss:EntityFormItem runat="server" PropertyName="Tasks" FieldControlID="Tasks" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Tasks + ":" %>' enabled='<%# ProjectsState.ProjectSelected %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400px" enabled='<%# ProjectsState.ProjectSelected %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" runat="server"
                                      TextPropertyName="Title" id="Tasks" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Tasks"
                                      NoSelectionText='<%# "-- " + Language.SelectTasks + " --" %>' OnDataLoading='TasksSelect_DataLoading'>
                                  </ss:EntitySelect><br />
                                  <ss:EntitySelectRequester visible='<%# ProjectsState.ProjectSelected %>' runat="server" id="TasksRequester" EntitySelectControlID="Tasks"
                                  	text='<%# Language.CreateTask + " &raquo;" %>'
                                  	DeliveryPage='<%# UrlCreator.Current.CreateUrl("Create", "Task") %>'
                                  	WindowWidth="650px" WindowHeight="650px"
                                  	EntityType="Suggestion" EntityID='<%# DataForm.EntityID %>'
                                  	TransferData="Title=Subject&Description=Description"
                                  	/>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                           <ss:EntityFormItem runat="server" PropertyName="Project" FieldControlID="Project" ControlValuePropertyName="SelectedEntity" text='<%# Language.Project + ":" %>'><FieldTemplate><ss:EntitySelect
                          ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Project"
                          enabled='<%# OperationManager.CurrentOperation == "CreateSuggestion" %>' runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IEntity, SoftwareMonkeys.WorkHub.Contracts" id="Project" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
			<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateSuggestion" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditSuggestion" %>'></asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <h1>
                           <%# Language.Suggestion + ": " + HtmlTools.FormatText(((Suggestion)DetailsForm.DataSource).Subject) %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# HtmlTools.FormatText(((Suggestion)DetailsForm.DataSource).Description) %></p>  
                                    <p><asp:Button runat="server" ID="ViewEditButton" CssClass="Button" Text='<%# Language.EditSuggestion %>' OnClick="ViewEditButton_Click" />
                                     	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
										<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Implemented + "&BalanceProperty=ImplementedVotesBalance&TotalProperty=TotalImplementedVotes" %>' />
                                    </p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateSuggestion" ? Language.NewSuggestionDetails : Language.SuggestionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormItem runat="server" PropertyName="AuthorName" text='<%# Language.AuthorName + ":" %>'>
                              <FieldTemplate>
                                  <a href='<%# Navigator.GetLink("Reply", "Suggestion") + "?SuggestionID=" + DetailsForm.EntityID.ToString() %>'><asp:Label runat="server" text='<%# Utilities.Summarize((((Suggestion)DetailsForm.DataSource).AuthorName), 100) %>'></asp:Label></a>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          
				<ss:EntityFormLabelItem runat="server" PropertyName="Status" FieldControlID="StatusLabel" text='<%# Language.Status + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="DatePosted" FieldControlID="DatePostedLabel" text='<%# Language.DatePosted + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="ApplicationVersion" FieldControlID="ApplicationVersionLabel" text='<%# Language.ApplicationVersion + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="NeedsReply" FieldControlID="NeedsReplyLabel" text='<%# Language.NeedsReply + ":" %>'></ss:EntityFormLabelItem>
				   
				</ss:EntityForm>
				            <h2><%= Language.Tasks %></h2>
				            <div class="TreeContainer">
                <ss:EntityTree runat="server" id="ViewSuggestionTasks" NoDataText='<%# Language.NoTasksForSuggestion %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities.Task, SoftwareMonkeys.WorkHub.Modules.Tasks" BranchesProperty="SubTasks" DataSource='<%# ((Suggestion)DetailsForm.DataSource).Tasks %>'>
                </ss:EntityTree>
                			</div>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
    </asp:MultiView>