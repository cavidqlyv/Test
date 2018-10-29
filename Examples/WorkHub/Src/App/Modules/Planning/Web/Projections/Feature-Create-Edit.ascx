<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Feature), DataForm, "Name");
    }

    #region Main functions
    

    /// <summary>
    /// Displays the form for creating a new feature.
    /// </summary>
    public override void Create()
    {
    	ProjectsState.EnsureProjectSelected();
    
    	base.Create();
	    		
	    WindowTitle = Language.CreateFeature;
    }
    
    /// <summary>
    /// Displays the form for editing an existing feature.
    /// </summary>
    public override void Edit()
    {
        Feature feature = PrepareEdit<Feature>();
	    		
	    WindowTitle = Language.EditFeature + ": " + feature.Name;
	    
	    Edit(feature);
    }
    
    #endregion
    
    protected void ProjectEntitiesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<ProjectEntity>().IndexWithReference<ProjectEntity>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void FeatureSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }
    
    protected void GoalsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);
    }
    
</script>

                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateFeature" ? Language.CreateFeature : Language.EditFeature %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateFeature" ? Language.CreateFeatureIntro : Language.EditFeatureIntro %></p>  
                             <ss:EntityForm runat="server" CssClass="Panel" width="100%" DataSource='<%# DataSource %>' id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateFeature" ? Language.NewFeatureDetails : Language.FeatureDetails %>' HeadingCssClass="Heading2">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControlID="FeatureName" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.FeatureNameRequired %>'></ss:EntityFormTextBoxItem>
			
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="FeatureDescription" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
			  <ss:EntityFormItem runat="server" PropertyName="Goals" FieldControlID="Goals" ControlValuePropertyName="SelectedEntities" text='<%# Language.Goals + ":" %>'><FieldTemplate>
			                    <ss:EntitySelect Width="400px" rows="8" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server" TextPropertyName="Title" id="Goals" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectGoals + " --" %>' NoDataText='<%# "-- " + Language.NoGoals + " --" %>' OnDataLoading='GoalsSelect_DataLoading'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Goals"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
				 <ss:EntityFormItem runat="server" PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actions + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server" Width="400px" rows="8"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectActions + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions"
                                      NoDataText='<%# "-- " + Language.NoActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          	<ss:EntityFormItem runat="server" PropertyName="Entities" FieldControlID="ProjectEntities" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Entities + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.ProjectEntity, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server"
                                      TextPropertyName="Name" id="ProjectEntities" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectEntities + " --" %>'
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Entities"
                                      NoDataText='<%# "-- " + Language.NoEntities + " --" %>' OnDataLoading='ProjectEntitiesSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateFeature" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditFeature" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                       