<%@ Control Language="C#" ClassName="IndexGoals" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    
    public override void Index()
    {
    	using (LogGroup logGroup = LogGroup.Start("Showing an index of goals.", NLog.LogLevel.Debug))
    	{
			PagingLocation location = (PagingLocation)Location;

			Goal[] goals = new Goal[]{};

    		if (ProjectsState.ProjectSelected)
    		{
	    		Guid projectID = ProjectsState.ProjectID;
	    		
	    		LogWriter.Debug("Project ID: " + projectID);
	    		
	    		goals = IndexStrategy.New<Goal>(location, IndexGrid.CurrentSort).IndexWithReference<Goal>("Project", "Project", ProjectsState.ProjectID);
    		}
    		else
    			goals = IndexStrategy.New<Goal>(location, IndexGrid.CurrentSort).Index<Goal>();
    		
    		Index(goals);
	    		
    		WindowTitle = Language.Goals;
    		if (ProjectsState.ProjectSelected)
    			WindowTitle = WindowTitle + ": " + ProjectsState.ProjectName;
    	}
    }

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Goal), IndexGrid, true);
    
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Asc, "ProjectVersionAscending");
        IndexGrid.AddSortItem(Language.ProjectVersion + " " + Language.Desc, "ProjectVersionDescending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Asc, "TitleAscending");
        IndexGrid.AddSortItem(Language.Title + " " + Language.Desc, "TitleDescending");
        IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "TotalDemandVotes");
        IndexGrid.AddDualSortItem(Language.AchievedVotesBalance, "AchievedVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalAchievedVotes, "TotalAchievedVotes");
    }

  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "Goal");
  }              
  
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Goals;
      	MenuCategory = Language.Planning + "/" + Language.Requirements;
        ShowOnMenu = true;
    }
</script>
            <div class="Heading1">
                        <%= Language.ManageGoals %>
                    </div>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageGoalsIntro %>
                        </p>
                        <div id="ActionsContainer">
                        <div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateGoal %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Goal") %>'><%= Language.Xml %></a>
                       	</div>
						</div>
                    
                 <ss:IndexGrid ID="IndexGrid" DataSource='<%# DataSource %>' runat="server" DefaultSort="TitleAscending" AllowPaging="True"
                            DataKeyNames="ID" HeaderText='<%# Language.Goals %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%" NavigateUrl='<%# Navigator.GetLink("Index", "Goal") %>'
                            EmptyDataText='<%# ProjectsState.ProjectSelected ? Language.NoGoalsForProject : Language.NoGoals %>'>
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    <div class="Title">
                                    <asp:Hyperlink runat="server" text='<%# Eval("Title") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </div>
                                    <asp:Panel runat="server" cssClass="Content" visible='<%# Eval("Description") != null && Eval("Description") != String.Empty %>'>
                                    <%# Utilities.Summarize((String)Eval("Description"), 200) %>
                                    </asp:Panel>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle></itemstyle>
                                    <itemtemplate>
                                    <asp:placeholder runat="server" visible='<%# Eval("Project") != null && !ProjectsState.ProjectSelected %>'>
                                    <div class="Content">
                                    	<a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)Eval("Project")) : String.Empty %>'><%# ProjectsState.ProjectSelected ? String.Empty : (string)Eval("Project.Name") %></a>
                                   	</div>
                                   	</asp:placeholder>
                                   	<div class="Content">
                                    <%# Eval("ProjectVersion") %>
                                    </div>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Achieved + "&BalanceProperty=AchievedVotesBalance&TotalProperty=TotalAchievedVotes" %>' /></div>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="80px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	
																	<ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditGoalToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteGoal %>' ToolTip='<%# Language.DeleteGoalToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>