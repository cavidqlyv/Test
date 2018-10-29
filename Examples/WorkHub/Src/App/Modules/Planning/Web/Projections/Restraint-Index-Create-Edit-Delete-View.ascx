<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
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
    protected void Page_Load(object sender, EventArgs e)
    {
        switch (QueryStrings.Action)
        {
           
            case "CreateRestraint":
        		if (!IsPostBack)
                	CreateRestraint();
                	
                break;
            case "ViewRestraint":
                	ViewRestraint(Utilities.GetQueryStringID("RestraintID"));
                break;
            case "View":
	            if (QueryStrings.GetID("Restraint") != Guid.Empty)
            		ViewRestraint(QueryStrings.GetID("Restraint"));
            	break;
            case "Create":
        		if (!IsPostBack)
            		CreateRestraint();
            	break;
            case "Edit":
        		if (!IsPostBack)
        		{
		        	if (QueryStrings.GetID("Restraint") != Guid.Empty)
		        		EditRestraint(QueryStrings.GetID("Restraint"));
            	}
            	break;
            case "Delete":
            	if (QueryStrings.GetID("Restraint") != Guid.Empty)
            		DeleteRestraint(QueryStrings.GetID("Restraint"));
            	break;
            default:
                ManageRestraints();
                break;
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        
        IndexGrid.AddSortItem(Language.Details + " " + Language.Asc, "DetailsAscending");
        IndexGrid.AddSortItem(Language.Details + " " + Language.Desc, "DetailsDescending");
        
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Asc, "ProjectVersionAscending");
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Desc, "ProjectVersionDescending");
        
        IndexGrid.AddDualSortItem(Language.VotesBalance, "VotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalVotes, "TotalVotes");
    }

    private void Projects_ProjectIDChanged(object sender, EventArgs e)
    {
        ManageRestraints();
    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing restraints.
    /// </summary>
    public void ManageRestraints(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
        
        OperationManager.StartOperation("ManageRestraints", IndexView);

        Restraint[] restraints = null;
        int total = 0;

		PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);

        if (ProjectsState.EnsureProjectSelected())
        {
        
            restraints = IndexStrategy.New<Restraint>(location, IndexGrid.CurrentSort).IndexWithReference<Restraint>("Project", "Project", ProjectsState.ProjectID);
        }

        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
        IndexGrid.DataSource = restraints;

        Authorisation.EnsureUserCan("View", restraints);
        
        WindowTitle = Language.Restraints + ": " + ProjectsState.ProjectName;

        IndexView.DataBind();
    }
    
    /// <summary>
    /// Displays the index on the first page for managing restraints.
    /// </summary>
    public void ManageRestraints()
    {
        ManageRestraints(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new restraint.
    /// </summary>
    public void CreateRestraint()
    {
        // Ensure that the user can create a new restraint
        Authorisation.EnsureUserCan("Create", typeof(Restraint));

        if (ProjectsState.EnsureProjectSelected())
        {
            // Declare the current operation
            OperationManager.StartOperation("CreateRestraint", FormView);

            // Create the default restraint
            Restraint restraint = new Restraint();
            restraint.ID = Guid.NewGuid();
            restraint.Project = ProjectsState.Project;
	    // TODO: Add default values    

            // Assign the default restraint to the form
            DataForm.DataSource = restraint;
            
            WindowTitle = Language.CreateRestraint;

            // Bind the form
            FormView.DataBind();
        }
    }

    /// <summary>
    /// Displays the form for editing the specified restraint.
    /// </summary>
    /// <param name="restraintID"></param>
    public void EditRestraint(Guid restraintID)
    {
    	EditRestraint(RetrieveStrategy.New<Restraint>().Retrieve<Restraint>("ID", restraintID));
    }

    public void EditRestraint(Restraint restraint)
    {
        // Declare the current operation
        OperationManager.StartOperation("EditRestraint", FormView);
        
        ActivateStrategy.New<Restraint>().Activate(restraint);
        
        DataForm.DataSource = restraint;

        // Ensure that the user can edit the specified restraint
        Authorisation.EnsureUserCan("Edit", (Restraint)DataForm.DataSource);
        
        WindowTitle = Language.EditRestraint + ": " + restraint.Title;

        // Bind the form
        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created restraint.
    /// </summary>
    private void SaveRestraint()
    {
        // Reverse bind the data back to the object
        DataForm.ReverseBind();

		Restraint restraint = (Restraint)DataForm.DataSource;

        // Save the new restraint
        if (SaveStrategy.New<Restraint>().Save(restraint))
        {
            // Display the result to the restraint
            Result.Display(Language.RestraintSaved);

            // Show the index again
            Navigator.Go("View", restraint);
        }
        else
            Result.Display(Language.RestraintTitleTaken);
    }

    /// <summary>
    /// Updates the restraint.
    /// </summary>
    private void UpdateRestraint()
    {
        // Get a fresh copy of the restraint object
        Restraint restraint = RetrieveStrategy.New<Restraint>().Retrieve<Restraint>("ID", DataForm.EntityID);
      
      	ActivateStrategy.New<Restraint>().Activate(restraint);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(restraint);

        // Update the new restraint
        if (UpdateStrategy.New<Restraint>().Update(restraint))
        {
            // Display the result to the restraint
            Result.Display(Language.RestraintUpdated);

            // Show the index again
            Navigator.Go("Index", "Restraint");
        }
        else
            Result.Display(Language.RestraintTitleTaken);

    }

    /// <summary>
    /// Deletes the restraint with the provided ID.
    /// </summary>
    /// <param name="restraintID">The ID of the restraint to delete.</param>
    private void DeleteRestraint(Guid restraintID)
    {
    	DeleteRestraint(RetrieveStrategy.New<Restraint>().Retrieve<Restraint>("ID", restraintID));
    }
    
    private void DeleteRestraint(Restraint restraint)
    {
        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("Delete", restraint);

        // Delete the restraint
        DeleteStrategy.New<Restraint>().Delete(restraint);
        
        // Display the result
        Result.Display(Language.RestraintDeleted);

        // Go back to the index
        Navigator.Go("Index", "Restraint");
    }

    /// <summary>
    /// Displays the details of the restraint with the specified ID.
    /// </summary>
    /// <param name="restraintID">The ID of the restraint to display.</param>
    private void ViewRestraint(Guid restraintID)
    {
    	ViewRestraint(RetrieveStrategy.New<Restraint>().Retrieve<Restraint>("ID", restraintID));
    }
    
    private void ViewRestraint(Restraint restraint)
    {
        // Declare the current operation
        OperationManager.StartOperation("ViewRestraint", DetailsView);

		ActivateStrategy.New<Restraint>().Activate(restraint);
        
        DetailsForm.DataSource = restraint;

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", (Restraint)DetailsForm.DataSource);
        
        WindowTitle = Language.Restraint + ": " + restraint.Title;

        // Bind the form
        DetailsView.DataBind();
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new restraint
        Navigator.Go("Create", "Restraint");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditRestraint(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteRestraint(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewRestraint(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveRestraint();
        }
        else if (e.CommandName == "Update")
        {
            UpdateRestraint();
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageRestraints();
    }                     
                 

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageRestraints(e.NewPageIndex);
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit", ((Restraint)DetailsForm.DataSource));
    }
    
    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ActorsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Actor>().IndexWithReference<Actor>("Project", "Project", ProjectsState.ProjectID);
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">


            <div class="Heading1">
                        <%= Language.ManageRestraints %>
                    </div>
              
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageRestraintsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateRestraint %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks"><%= Language.View %>: <a href='<% = Navigator.GetLink("XmlLinks", "Restraint") %>'><%= Language.Xml %></a>
                        </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="TitleAscending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Restraints %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoRestraintsForProject %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <asp:Panel runat="server" cssClass="Content" visible='<%# Eval("Details") != null && Eval("Details") != String.Empty %>'>
                                    <%# Utilities.Summarize((String)Eval("Details"), 200) %>
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
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# Container.DataItem %>' PropertyValuesString="BalanceProperty=VotesBalance&TotalProperty=TotalVotes" />
																	</div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditRestraintToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'/>
                                <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteRestraint %>' ToolTip='<%# Language.DeleteRestraintToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateRestraint" ? Language.CreateRestraint : Language.EditRestraint %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateRestraint" ? Language.CreateRestraintIntro : Language.EditRestraintIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateRestraint" ? Language.NewRestraintDetails : Language.RestraintDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" FieldControlID="RestraintTitle" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.RestraintTitleRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Details" FieldControlID="RestraintDetails" text='<%# Language.Details + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="10"></ss:EntityFormTextBoxItem>
						  <ss:EntityFormItem runat="server" PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actions + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" Rows="8" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions"
                                      NoSelectionText='<%# "-- " + Language.SelectActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          			  <ss:EntityFormItem runat="server" PropertyName="Actors" FieldControlID="Actors" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actors + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" Rows="8" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server"
                                      TextPropertyName="Name" id="Actors" DisplayMode="Multiple" SelectionMode="Multiple"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actors"
                                      NoSelectionText='<%# "-- " + Language.SelectActors + " --" %>' OnDataLoading='ActorsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateRestraint" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditRestraint" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <div class="Heading1">
                           <%# Language.Restraint + ": " + ((Restraint)DetailsForm.DataSource).Title %>
                   </div>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((Restraint)DetailsForm.DataSource).Details %></p>  
<p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditRestraint %>' CssClass="Button" OnClick="ViewEditButton_Click" />
                                     <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString="BalanceProperty=VotesBalance&TotalProperty=TotalVotes" /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateRestraint" ? Language.NewRestraintDetails : Language.RestraintDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Title" FieldControlID="RestraintTitleLabel" text='<%# Language.Title + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Details" FieldControlID="RestraintDetailsLabel" text='<%# Language.Details + ":" %>'></ss:EntityFormLabelItem>
				   <ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ActorProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				
				</ss:EntityForm>
				            <div class="Heading2"><%= Language.Actions + ":" %></div>
               <ss:EntityTree runat="server" NoDataText='<%# Language.NoActionsForRestraint %>' id="ViewRestraintActions" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" BranchesProperty="" DataSource='<%# ((Restraint)DetailsForm.DataSource).Actions %>'>
                </ss:EntityTree>
                            <div class="Heading2"><%= Language.Actors + ":" %></div>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoActorsForRestraint %>' id="ViewRestraintActors" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning" BranchesProperty="" DataSource='<%# ((Restraint)DetailsForm.DataSource).Actors %>'>
                </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>
    </asp:MultiView>