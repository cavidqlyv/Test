<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
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
    	EnableViewState=false;
    
        Initialize(typeof(Feature), DetailsForm);
        
        
    }

    #region Main functions
    

    /// <summary>
    /// Displays the form for creating a new feature.
    /// </summary>
    public override void View()
    {    
         Feature feature = PrepareView<Feature>();
         DataSource = feature;
         
         ActivateStrategy.New<Feature>().Activate(feature);
         
         GoalsTree.DataSource = feature.Goals;
         ActionsTree.DataSource = feature.Actions;
         //FeaturesTree.DataSource = feature.Features;
         EntitiesTree.DataSource = feature.Entities;
         //ActorsTree.DataSource = feature.Actors;
         
         WindowTitle = Language.Feature + ": " + feature.Name;
         
         View(feature);
    }
    
    // Edit action is managed automatically by the base page. It can be customised here.
    
    #endregion
    
    
    protected void PrerequisitesSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }


    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }

    protected void FeatureSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New<Feature>().IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
    }


    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit", RetrieveStrategy.New<Feature>().Retrieve<Feature>("ID", QueryStrings.GetID("Feature")));

    }    
</script>
                   <h1>
                                <%# Language.Feature + ": " + ((Feature)DetailsForm.DataSource).Name %>
                            </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%# ((Feature)DetailsForm.DataSource).Description %></p>  
                                    <p><asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditFeature %>' CssClass="Button" OnClick="EditButton_Click" />
                                    
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DetailsForm.DataSource %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' />
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DetailsForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateFeature" ? Language.NewFeatureDetails : Language.FeatureDetails %>' HeadingCssClass="Heading2">
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="FeatureNameLabel" text='<%# Language.Name + ":" %>'></ss:EntityFormLabelItem>
				
				<ss:EntityFormLabelItem runat="server" PropertyName="Description" FieldControlID="FeatureDescriptionLabel" text='<%# Language.Description + ":"%>'></ss:EntityFormLabelItem>
				<ss:EntityFormLabelItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersionLabel" text='<%# Language.ProjectVersion + ":"%>'></ss:EntityFormLabelItem>
				   
				</ss:EntityForm>
				<h2><%= Language.Goals %></h2>
				         <ss:EntityTree runat="server" NoDataText='<%# Language.NoGoalsForFeature %>' id="GoalsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning">
                        </ss:EntityTree>
                        		            <h2><%= Language.Actions %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoActionsForFeature %>' id="ActionsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                          <h2><%= Language.Entities %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoEntitiesForFeature %>' id="EntitiesTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.ProjectEntity, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DataSource %>'  />
