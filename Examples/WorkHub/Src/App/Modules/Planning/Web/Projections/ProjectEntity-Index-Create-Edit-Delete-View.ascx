<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" AutoEventWireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="lc" %>
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
        if (!IsPostBack)
        {
            switch (QueryStrings.Action)
            {
                case "CreateProjectEntity":
                case "CreateEntity":
                    CreateProjectEntity();
                    break;
            	case "ViewProjectEntity":
                case "ViewEntity":
                	if (Utilities.GetQueryStringID("EntityID") != Guid.Empty)
	                    ViewProjectEntity(Utilities.GetQueryStringID("EntityID"));
	                else
	                    ViewProjectEntity(Utilities.GetQueryStringID("ProjectEntityID"));
                    break;
                case "View":
                	if (QueryStrings.GetID("ProjectEntity") != Guid.Empty)
                		ViewProjectEntity(QueryStrings.GetID("ProjectEntity"));
                	break;
                case "Edit":
                	if (QueryStrings.GetID("ProjectEntity") != Guid.Empty)
                		EditProjectEntity(QueryStrings.GetID("ProjectEntity"));
                	break;
                case "Delete":
                	if (QueryStrings.GetID("ProjectEntity") != Guid.Empty)
                		DeleteProjectEntity(QueryStrings.GetID("ProjectEntity"));
                	break;
                case "Create":
                		CreateProjectEntity();
                	break;
                default:
                    ManageProjectEntities();
                    break;
            }
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
        // Add all the sort items to the index grid
        
        IndexGrid.AddSortItem(Language.Name + " " + Language.Asc, "NameAscending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Desc, "NameDescending");
        
        IndexGrid.AddSortItem(Language.Description + " " + Language.Asc, "DescriptionAscending");
        IndexGrid.AddSortItem(Language.Description + " " + Language.Desc, "DescriptionDescending");

    }

    #region Main functions
    /// <summary>
    /// Displays the index for managing entities.
    /// </summary>
    public void ManageProjectEntities(int pageIndex)
    {
        IndexGrid.CurrentPageIndex = pageIndex;
        
        OperationManager.StartOperation("ManageProjectEntities", IndexView);

        ProjectEntity[] entities = null;
        int total = 0;

        if (ProjectsState.EnsureProjectSelected())
        {
        	PagingLocation location = new PagingLocation(pageIndex, IndexGrid.PageSize);
        
            entities = IndexStrategy.New<ProjectEntity>(location, IndexGrid.CurrentSort).IndexWithReference<ProjectEntity>("Project", "Project", ProjectsState.ProjectID);
            
	        IndexGrid.VirtualItemCount = location.AbsoluteTotal;
	        IndexGrid.DataSource = entities;
	
	        Authorisation.EnsureUserCan("View", entities);
	        
	        WindowTitle = Language.Entities + ": " + ProjectsState.ProjectName;
	
	        IndexView.DataBind();
            
        }
    }
    
    /// <summary>
    /// Displays the index on the first page for managing entities.
    /// </summary>
    public void ManageProjectEntities()
    {
        ManageProjectEntities(QueryStrings.PageIndex);
    }

    /// <summary>
    /// Displays the form for creating a new entity.
    /// </summary>
    public void CreateProjectEntity()
    {
        // Ensure that the user can create a new entity
        Authorisation.EnsureUserCan("Create", typeof(ProjectEntity));

        if (ProjectsState.EnsureProjectSelected())
        {
            // Declare the current operation
            OperationManager.StartOperation("CreateProjectEntity", FormView);

            // Create the default entity
            ProjectEntity entity = new ProjectEntity();
            entity.ID = Guid.NewGuid();
            entity.Project = ProjectsState.Project;
	    // TODO: Add default values    

            // Assign the default entity to the form
            DataForm.DataSource = entity;
            
            WindowTitle = Language.CreateEntity;

            // Bind the form
            FormView.DataBind();
        }
    }

    /// <summary>
    /// Displays the form for editing the specified entity.
    /// </summary>
    /// <param name="entityID"></param>
    public void EditProjectEntity(Guid entityID)
    {
    	EditProjectEntity(RetrieveStrategy.New<ProjectEntity>().Retrieve<ProjectEntity>("ID", entityID));
    }
    
    public void EditProjectEntity(ProjectEntity entity)
    {
        // Declare the current operation
        OperationManager.StartOperation("EditProjectEntity", FormView);
        
        DataForm.DataSource = entity;

        // Ensure that the user can edit the specified entity
        Authorisation.EnsureUserCan("Edit", (ProjectEntity)DataForm.DataSource);
        
       	WindowTitle = Language.EditProjectEntity + ": " + entity.Name;

        // Bind the form
        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created entity.
    /// </summary>
    private void SaveProjectEntity()
    {
        // Reverse bind the data back to the object
        DataForm.ReverseBind();

        // Save the new entity
        if (SaveStrategy.New<ProjectEntity>().Save((ProjectEntity)DataForm.DataSource))
        {
            // Display the result to the entity
            Result.Display(Language.ProjectEntitySaved);

			Navigator.Go("View", (ProjectEntity)DataForm.DataSource);
        }
        else
            Result.Display(Language.ProjectEntityNameTaken);
    }

    /// <summary>
    /// Updates the entity.
    /// </summary>
    private void UpdateProjectEntity()
    {
        // Get a fresh copy of the entity object
        ProjectEntity entity = RetrieveStrategy.New<ProjectEntity>().Retrieve<ProjectEntity>("ID", DataForm.EntityID);
      
      	ActivateStrategy.New<ProjectEntity>().Activate(entity);
      
        // Transfer data from the form to the object
        DataForm.ReverseBind(entity);

        // Update the new entity
        if (UpdateStrategy.New<ProjectEntity>().Update(entity))
        {
            // Display the result to the entity
            Result.Display(Language.ProjectEntityUpdated);

			Navigator.Go("View", ((ProjectEntity)DataForm.DataSource));
        }
        else
            Result.Display(Language.ProjectEntityNameTaken);

    }

    /// <summary>
    /// Deletes the entity with the provided ID.
    /// </summary>
    /// <param name="entityID">The ID of the entity to delete.</param>
    private void DeleteProjectEntity(Guid entityID)
    {
        // Load the entity
        ProjectEntity entity = RetrieveStrategy.New<ProjectEntity>().Retrieve<ProjectEntity>("ID", entityID);
		DeleteProjectEntity(entity);
    }
        
    private void DeleteProjectEntity(ProjectEntity entity)
    {
        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("Delete", entity);

        // Delete the entity
        DeleteStrategy.New<ProjectEntity>().Delete(entity);
        
        // Display the result
        Result.Display(Language.ProjectEntityDeleted);

        // Go back to the index
		Navigator.Go("Index", "ProjectEntity");
    }

    /// <summary>
    /// Displays the details of the entity with the specified ID.
    /// </summary>
    /// <param name="entityID">The ID of the entity to display.</param>
    private void ViewProjectEntity(Guid entityID)
    {
    	ViewProjectEntity(RetrieveStrategy.New<ProjectEntity>().Retrieve<ProjectEntity>("ID", entityID));
    }
        
    private void ViewProjectEntity(ProjectEntity entity)
    {
        // Declare the current operation
        OperationManager.StartOperation("ViewProjectEntity", DetailsView);
        
        ActivateStrategy.New<ProjectEntity>().Activate(entity);
        
        // Sort the properties ascending by name
        entity.Properties = Collection<ProjectEntityProperty>.Sort(entity.Properties, "NameAscending");

        DetailsForm.DataSource = entity;

        // Ensure that the user is authorised to view the data
        Authorisation.EnsureUserCan("View", (ProjectEntity)DetailsForm.DataSource);    
        
        WindowTitle = Language.ProjectEntity + ": " + entity.Name;

        // Bind the form
        DetailsView.DataBind();
    }

    /// <summary>
    /// Displays the form for creating a new entity property.
    /// </summary>
    public void CreateProjectEntityProperty(ProjectEntity entity)
    {
        Navigator.Go("Create", "ProjectEntityProperty", "Parent-ID",  entity.ID.ToString());
    }

    /// <summary>
    /// Displays the form for editing the specified property.
    /// </summary>
    /// <param name="propertyID"></param>
    public void EditProjectEntityProperty(Guid propertyID)
    {
    	EditProjectEntityProperty(RetrieveStrategy.New<ProjectEntityProperty>().Retrieve<ProjectEntityProperty>("ID", propertyID));
    }
        
    public void EditProjectEntityProperty(ProjectEntityProperty property)
    {
        Navigator.Go("Create", "ProjectEntityProperty", "ID", property.ID.ToString());
    }

    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new entity
        Navigator.Go("Create", "ProjectEntity");
    }


    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            EditProjectEntity(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "Delete")
        {
            DeleteProjectEntity(new Guid(e.CommandArgument.ToString()));
        }
        else if (e.CommandName == "View")
        {
            ViewProjectEntity(new Guid(e.CommandArgument.ToString()));
        }
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveProjectEntity();
        }
        else if (e.CommandName == "Update")
        {
            UpdateProjectEntity();
        }
    }

    private void IndexGrid_SortChanged(object sender, EventArgs e)
    {
        ManageProjectEntities();
    }                     
                 

    private void IndexGrid_PageIndexChanged(object sender, DataGridPageChangedEventArgs e)
    {
        ManageProjectEntities(e.NewPageIndex);
    }

    private void ViewEditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit", ((ProjectEntity)DetailsForm.DataSource));
    }
    
    protected void FeatureSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    private void PropertiesGrid_SortChanged(object sender, EventArgs e)
    {
        ViewProjectEntity(((ProjectEntity)DetailsForm.DataSource).ID);
    }

    private void CreatePropertyButton_Click(object sender, EventArgs e)
    {
        CreateProjectEntityProperty((ProjectEntity)DetailsForm.DataSource);
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">

            <div class="Heading1">
                        <%= Language.ManageProjectEntities %>
                    </div>
              
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageProjectEntitiesIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateProjectEntity %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = Navigator.GetLink("XmlLinks", "ProjectEntity") %>'><%= Language.Xml %></a></td>
                        </div>
						</div>
                <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending" OnSortChanged="IndexGrid_SortChanged" OnPageIndexChanged="IndexGrid_PageIndexChanged" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.ProjectEntities %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoProjectEntitiesForProject %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Hyperlink runat="server" text='<%# Eval("Name") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Utilities.Summarize((string)Eval("Description"), 100) %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                               <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# (string)Eval("ProjectVersion") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditProjectEntityToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'/>&nbsp;
                                <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteProjectEntity %>' ToolTip='<%# Language.DeleteProjectEntityToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateProjectEntity" ? Language.CreateProjectEntity : Language.EditProjectEntity %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateProjectEntity" ? Language.CreateProjectEntityIntro : Language.EditProjectEntityIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateProjectEntity" ? Language.NewProjectEntityDetails : Language.ProjectEntityDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControID="EntityName" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.ProjectEntityNameRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
			  <ss:EntityFormItem runat="server" PropertyName="Features" FieldControlID="Features" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Features + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Name" id="Features" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectFeatures + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Features"
                                      NoDataText='<%# "-- " + Language.NoFeatures + " --" %>' OnDataLoading='FeatureSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                           <ss:EntityFormItem runat="server" PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actions + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectActions + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions"
                                      NoDataText='<%# "-- " + Language.NoActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                                  
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateProjectEntity" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditProjectEntity" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
			
                            </ss:EntityForm>
                            
        </asp:View>
	<asp:View runat="server" ID="DetailsView">
                   <h1>
                           <%# Language.ProjectEntity + ": " + ((ProjectEntity)DetailsForm.DataSource).Name %>
                   </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((ProjectEntity)DetailsForm.DataSource).Description %></p>  
<p><asp:Button runat="server" ID="ViewEditButton" Text='<%# Language.EditProjectEntity %>' CssClass="Button" OnClick="ViewEditButton_Click" /></p>
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateProjectEntity" ? Language.NewProjectEntityDetails : Language.ProjectEntityDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="EntityNameLabel" text='<%# Language.Name + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Description" FieldControlID="DescriptionLabel" text='<%# Language.Description + ":" %>'></ss:EntityFormLabelItem>
				      <ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ActorProjectVersionLabel" text='<%# Language.ProjectVersion + ":" %>'></ss:EntityFormLabelItem>
				
				</ss:EntityForm>
				<h2><%= Language.EntityProperties %></h2>
				<p class="Intro"><%= Language.EntityPropertiesIntro %></p>
				<p><asp:Button runat="server" ID="CreatePropertyButton" text='<%# Language.CreateProjectEntityProperty %>' OnClick="CreatePropertyButton_Click" /></p>
				<p>
				<ss:IndexGrid ID="PropertiesGrid" runat="server" DefaultSort="NameAscending" DataSource='<%# ((ProjectEntity)DetailsForm.DataSource).Properties %>' OnSortChanged="PropertiesGrid_SortChanged" AllowPaging="false"
                            DataKeyNames="ID" HeaderText='<%# Language.ProjectEntityProperties %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="false" ShowHeader="false" ShowSort="True"
                            EmptyDataText='<%# Language.NoProjectEntityPropertiesFound %>'>
                            <Columns>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                                                  <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("Type") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>  
                                    <asp:TemplateColumn>
                                    <ItemTemplate>
                                    <asp:Label runat="server" text='<%# Eval("OtherType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                              
                                                          <asp:TemplateColumn>
                            <ItemStyle width="80" horizontalalign="right" wrap="false" />
                            <itemtemplate>
                                
                                <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditProjectEntityPropertyToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", "ProjectEntityProperty", "ID", Eval("ID").ToString()) %>'/>
                                 <cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteProjectEntityProperty %>' ToolTip='<%# Language.DeleteProjectEntityPropertyToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", "ProjectEntityProperty", "ID", Eval("ID").ToString()) %>'>
																	</cc:DeleteLink>
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>
                        </p>
				<h2><%= Language.Features %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoFeaturesForProjectEntity %>' id="ViewEntityFeatures" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning" DataSource='<%# ((ProjectEntity)DetailsForm.DataSource).Features %>'>
                </ss:EntityTree>
				<h2><%= Language.Actions %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoActionsForProjectEntity %>' id="ViewEntityActions" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" DataSource='<%# ((ProjectEntity)DetailsForm.DataSource).Actions %>'>
                </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DetailsForm.DataSource %>'  />
        </asp:View>

    </asp:MultiView>