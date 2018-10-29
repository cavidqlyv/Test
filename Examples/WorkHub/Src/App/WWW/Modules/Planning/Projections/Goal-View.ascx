<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
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
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Goal));
        
        
    }
    
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


    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit",  RetrieveStrategy.New("Goal").Retrieve("ID", QueryStrings.GetID("Goal")));

    }    
</script>
                   <h1>
                                <%# Language.Goal + ": " + Eval("Title") %>
                            </h1>
                                <ss:Result ID="Result3" runat="server">
                                </ss:Result>
                                <p class="Details"><%= Language.ProjectVersion %>: <%= Eval("ProjectVersion") %></p>
                                <p>
                                    <%# Eval("Description") %></p>
                                    <div id="ActionsContainer">
                                    <div id="ActionButtons">
                                    <asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditGoal %>' CssClass="Button" OnClick="EditButton_Click" />
                                     <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DataSource %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# DataSource %>' PropertyValuesString='<%# "Text=" + Language.Achieved + "&BalanceProperty=AchievedVotesBalance&TotalProperty=TotalAchievedVotes" %>' />
                                    </div>
                                    </div>
				   <H2><%# Language.Prerequisites %></H2>
				         <ss:EntityTree NoDataText='<%# Language.NoPrerequisitesForGoal %>' runat="server" id="PrerequisitesTree" DataSource='<%# (IEntity[])Controller.Eval("Prerequisites") %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Goal, SoftwareMonkeys.WorkHub.Modules.Planning" BranchesProperty="Prerequisites">
                        </ss:EntityTree>
                           <h2><%= Language.Features %></h2>
               <ss:EntityTree runat="server" NoDataText='<%# Language.NoFeaturesForGoal %>' id="FeaturesTree" DataSource='<%# (IEntity[])Controller.Eval("Features") %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Feature, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
                        <h2><%# Language.Actors %></h2>
                        <ss:EntityTree runat="server" NoDataText='<%# Language.NoActorsForGoal %>' id="ActorsTree" DataSource='<%# (IEntity[])Controller.Eval("Actors") %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Actor, SoftwareMonkeys.WorkHub.Modules.Planning">
                        </ss:EntityTree>
           <h2><%= Language.Actions %></h2>
                <ss:EntityTree runat="server" NoDataText='<%# Language.NoActionsForGoal %>' id="ActionsTree" DataSource='<%# (IEntity[])Controller.Eval("Actions") %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action, SoftwareMonkeys.WorkHub.Modules.Planning">
                </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# DataSource %>'  />
