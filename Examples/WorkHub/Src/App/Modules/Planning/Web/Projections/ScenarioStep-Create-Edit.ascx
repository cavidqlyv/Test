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
        Initialize(typeof(ScenarioStep), DataForm);
        
        
    }
    
    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }
    
</script>

                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateScenarioStep" ? Language.CreateScenarioStep : Language.EditScenarioStep %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateScenarioStep" ? Language.CreateScenarioStepIntro : Language.EditScenarioStepIntro %></p>  
                            
                            <ss:EntityForm runat="server" CssClass="Panel" DataSource='<%# EntitiesUtilities.GetPropertyValue(DataSource, "Scenario") %>' width="100%" id="ScenarioSummaryForm" HeadingText='<%# Language.ScenarioDetails %>' HeadingCssClass="Heading2">
                            	<ss:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="ScenarioSummaryNameLabel" text='<%# Language.Name + ":" %>'></ss:EntityFormLabelItem>
                            	<ss:EntityFormLabelItem runat="server" PropertyName="Description" FieldControlID="ScenarioSummaryDescriptionLabel" text='<%# Language.Description + ":" %>'></ss:EntityFormLabelItem>
                            </ss:EntityForm>
                            <ss:EntityForm runat="server" CssClass="Panel" DataSource='<%# DataSource %>' width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateScenarioStep" ? Language.NewScenarioStepDetails : Language.ScenarioStepDetails %>' HeadingCssClass="Heading2">
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Text" FieldControlID="ScenarioStepText" text='<%# Language.Description + ":" %>' TextBox-Width="400px" TextBox-TextMode="Multiline" TextBox-Rows="5"></ss:EntityFormTextBoxItem>
				   <ss:EntityFormItem runat="server" PropertyName="Action" FieldControlID="Actions" ControlValuePropertyName="SelectedEntity"
                              text='<%# Language.Action + ":" %>'>
                              <FieldTemplate>
                                  <ss:EntitySelect width="400" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning" runat="server"
                                      TextPropertyName="Name" id="Actions" DisplayMode="Single" SelectionMode="Single"
                                      ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Action"
                                      NoDataText='<%# "-- " + Language.NoActions + " --" %>' OnDataLoading='ActionsSelect_DataLoading'>
                                  </ss:EntitySelect><br />
                                  <ss:EntitySelectRequester runat="server" id="ActionsRequester" EntitySelectControlID="Actions"
                                  	text='<%# Language.CreateAction + " &raquo;" %>'
                                  	DeliveryPage='<%# UrlCreator.Current.CreateUrl("Create", "Action") %>'
                                  	WindowWidth="650px" WindowHeight="650px"
                                  	EntityType="ScenarioStep" EntityID='<%# DataForm.EntityID %>'
                                  	TransferData="Name=ScenarioStepText"
                                  	/>
                              </FieldTemplate>
                          </ss:EntityFormItem>
				    <ss:EntityFormTextBoxItem runat="server" PropertyName="Comments" FieldControlID="ScenarioStepComments" text='<%# Language.Comments + ":" %>' TextBox-Width="400px" TextBox-TextMode="Multiline" TextBox-Rows="5"></ss:EntityFormTextBoxItem>
				    
				<ss:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="SaveStepButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateScenarioStep" %>'></asp:Button>
<asp:Button ID="UpdateStepButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditScenarioStep" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</ss:EntityFormButtonsItem>
				   

                            </ss:EntityForm>
                       