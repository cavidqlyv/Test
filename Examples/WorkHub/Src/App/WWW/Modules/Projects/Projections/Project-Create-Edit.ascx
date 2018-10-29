<%@ Control Language="C#" ClassName="ProjectForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Project), DataForm, "Name");
        
        if (QueryStrings.Action == "Create")
        	CreateController.ActionOnSuccess = "Select";
    }

	protected void UsersSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<User>().Index<User>();
    }
                    
    protected void ProjectsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Project>().Index<Project>();
    }
                            
	  public override void InitializeInfo()
	  {
		ProjectionInfo createProjection = new ProjectionInfo();
		createProjection.MenuTitle = Language.Create;
		createProjection.MenuCategory = Language.Projects;
		createProjection.Action = "Create";
		createProjection.TypeName = "Project";
		createProjection.ShowOnMenu = true;
		
		AddInfo(createProjection);
		
		ProjectionInfo editProjection = new ProjectionInfo();
		editProjection.MenuTitle = Language.Edit;
		editProjection.MenuCategory = Language.Projects;
		editProjection.Action = "Edit";
		editProjection.TypeName = "Project";
		editProjection.ShowOnMenu = true;
		
		AddInfo(editProjection);
	  }   
</script>
<div class="Trail">
		<a href='<%= Request.ApplicationPath %>'><%= Language.Home %></a> &gt;
		<a href='<%= new UrlCreator().CreateUrl("Index", "Project") %>'><%= Language.Projects %></a> &gt;
		<% if (QueryStrings.Action == "Create") { %>
			<a href='<%= new UrlCreator().CreateUrl("Create", "Project") %>'><%= Language.CreateProject %></a>
		<% } else { %>
			<a href='<%= new UrlCreator().CreateUrl("Edit", (IEntity)DataSource) %>'><%= Language.Edit + ": " + DataSource.ToString() %></a>
		<% } %>
	</div>
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateProject" ? Language.CreateProject : Language.EditProject %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateProject" ? Language.CreateProjectIntro : Language.EditProjectIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateProject" ? Language.NewProjectDetails : Language.ProjectDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" text='<%# Language.ProjectName + ":" %>' IsRequired="true" TextBox-Width="400" RequiredErrorMessage='<%# Language.ProjectNameRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Summary" text='<%# Language.Summary + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="MoreInfo" text='<%# Language.MoreInformation + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem   runat="server" PropertyName="CompanyName" text='<%# Language.CompanyName + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="CurrentVersion" text='<%# Language.CurrentVersion + ":" %>' TextBox-width="200"></ss:EntityFormTextBoxItem>
                             <ss:EntityFormItem runat="server" PropertyName="Status" ControlValuePropertyName="SelectedStatus" Text='<%# Language.Status + ":" %>'><FieldTemplate><cc:ProjectStatusSelect runat="server" id="Status" CssClass="Field" width="200"></cc:ProjectStatusSelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormItem runat="server" PropertyName="Visibility" ControlValuePropertyName="SelectedVisibility" Text='<%# Language.Visibility + ":" %>'><FieldTemplate><cc:ProjectVisibilitySelect runat="server" id="Visibility" CssClass="Field" width="200"></cc:ProjectVisibilitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormItem runat="server" PropertyName="Managers" FieldControlID="Managers" ControlValuePropertyName="SelectedEntities" text='<%# Language.Managers + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.User, SoftwareMonkeys.WorkHub.Entities" runat="server" TextPropertyName="Name" id="Managers" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectManagers + " --" %>' OnDataLoading='UsersSelect_DataLoading' ReferenceProperty="Managers" ReferenceSource='<%# (IEntity)DataSource %>'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                    <ss:EntityFormItem runat="server" PropertyName="Contributors" FieldControlID="Contributors" ControlValuePropertyName="SelectedEntities" text='<%# Language.Contributors + ":" %>'><FieldTemplate><ss:EntitySelect width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.User, SoftwareMonkeys.WorkHub.Entities" runat="server" TextPropertyName="Name" id="Contributors" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectContributors + " --" %>' OnDataLoading='UsersSelect_DataLoading' ReferenceProperty="Contributors" ReferenceSource='<%# (IEntity)DataSource %>'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateProject" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditProject" %>'></asp:Button></FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               