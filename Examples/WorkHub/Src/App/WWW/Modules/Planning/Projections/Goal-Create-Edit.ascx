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
        Initialize(typeof(Goal), DataForm, "Title");
    }

    #region Main functions
    

    /// <summary>
    /// Displays the form for creating a new goal.
    /// </summary>
    public override void Create()
    {         
    	ProjectsState.EnsureProjectSelected();
    
    	 WindowTitle = Language.CreateGoal;
         
         base.Create();
    }
    
    /// <summary>
    /// Displays the form for editing an existing goal.
    /// </summary>
    public override void Edit()
    {
        Goal goal = PrepareEdit<Goal>();
         
    	WindowTitle = Language.EditGoal + ": " + goal.Title;
    	
    	Edit(goal);
         
    }
    
    // Edit action is managed automatically by the base page. It can be customised here.
    
    #endregion
    
    
    protected void PrerequisitesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Goal>().IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);
    }


    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void FeatureSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }
    

    protected void ActorsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Actor>().IndexWithReference<Actor>("Project", "Project", ProjectsState.ProjectID);
    }
    
    
</script>
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateGoal" ? Language.CreateGoal : Language.EditGoal %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateGoal" ? Language.CreateGoalIntro : Language.EditGoalIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateGoal" ? Language.NewGoalDetails : Language.GoalDetails %>' HeadingCssClass="Heading2">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" FieldControlID="Title" text='<%# Language.Title + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.GoalTitleRequired %>'></ss:EntityFormTextBoxItem>
				      <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="8"></ss:EntityFormTextBoxItem>
				       <ss:EntityFormItem runat="server" PropertyName="Prerequisites" FieldControlID="Prerequisites" ControlValuePropertyName="SelectedEntities" text='<%# Language.Prerequisites + ":" %>'><FieldTemplate>
				       <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning"
				       ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Prerequisites"
				       Width="400px" rows="8" runat="server" TextPropertyName='Title' id="Prerequisites" displaymode="multiple" selectionmode="multiple" NoSelectionText='<%# "-- " + Language.SelectGoals + " --" %>' NoDataText='<%# "-- " + Language.NoGoals + " --" %>' OnDataLoading='PrerequisitesSelect_DataLoading'></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                        <ss:EntityFormItem runat="server" PropertyName="Features" FieldControlID="Features" ControlValuePropertyName="SelectedEntities" text='<%# Language.Features + ":" %>'>
                                <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning" Rows="8" Width="400px" runat="server"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Features"
                                      TextPropertyName="Name" id="Features" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectFeatures + " --" %>'
                                      NoDataText='<%# "-- " + Language.NoFeatures + " --" %>' OnDataLoading='FeatureSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
                          <ss:EntityFormItem runat="server" PropertyName="Actors" FieldControlID="Actors" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actors + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning" Width="400px" rows="8" runat="server"
                                  	ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actors"
                                      TextPropertyName="Name" id="Actors" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectActors + " --" %>'
                                      NoDataText='<%# "-- " + Language.NoActors + " --" %>' OnDataLoading='ActorsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				       	  <ss:EntityFormItem runat="server" PropertyName="Actions" FieldControlID="Actions" ControlValuePropertyName="SelectedEntities"
                              text='<%# Language.Actions + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" Width="400px" rows="8" runat="server"
                                  		ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Actions"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Multiple" SelectionMode="Multiple" NoSelectionText='<%# "-- " + Language.SelectActions + " --" %>'
                                      NoDataText='<%# "-- " + Language.NoActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect>
                              </FieldTemplate>
                          </ss:EntityFormItem>
							<ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
							  <ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateGoal" %>'></asp:Button>
<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditGoal" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                            