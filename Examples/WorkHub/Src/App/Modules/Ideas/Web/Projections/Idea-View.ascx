<%@ Control Language="C#" ClassName="ViewIdea" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

	public Idea CurrentIdea
	{
		get { return ((Idea)Controller.DataSource); }
	}

    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Idea));
    }

	private void Page_Load(object sender, EventArgs e)
	{
		//if (!IsPostBack)
			DataBind();
	}
    
    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit",  RetrieveStrategy.New("Idea").Retrieve("ID", QueryStrings.GetID("Idea")));
    }    
</script>
             
                                
		<asp:Panel runat="server" id="IdeaSummaryPanel" visible='<%# CurrentIdea != null %>'>
		<h1>
		<%= CurrentIdea != null ? Utilities.Summarize(CurrentIdea.Details, 50) : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<p><ASP:Hyperlink runat="server"
                                        	ToolTip='<%# Resources.Language.SendMessage %>'
                                        	text='<%# CurrentIdea.Author != null ? CurrentIdea.Author.Name : "" %>'
                                        	navigateurl='<%# Navigator.GetLink("Send", "Message") + "?RecipientID=" + CurrentIdea.ID.ToString() %>'>
										</ASP:Hyperlink></p>
		<p>
		<%= CurrentIdea != null ? CurrentIdea.Details : String.Empty %>
		</p>
		<div id="ActionsContainer">
                                    <div id="ActionButtons">
                                    <asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditIdea %>' CssClass="Button" OnClick="EditButton_Click" />
                                    
																	 <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# CurrentIdea %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
																	<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# CurrentIdea %>' PropertyValuesString='<%# "Text=" + Language.Achieved + "&BalanceProperty=AchievedVotesBalance&TotalProperty=TotalAchievedVotes" %>' />
                                    </div>
                                    </div>
		<h2><%= Language.SubIdeas %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentIdea.SubIdeas %>' NoDataText='<%# Language.NoSubIdeasForIdea %>' id="SubIdeasTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas">
                        </ss:EntityTree>
		<h2><%= Language.ParentIdeas %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentIdea.ParentIdeas %>' NoDataText='<%# Language.NoParentIdeasForIdea %>' id="ParentIdeasTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas">
                        </ss:EntityTree>
		<h2><%= Language.RelatedIdeas %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentIdea.RelatedIdeas %>' NoDataText='<%# Language.NoRelatedIdeasForIdea %>' id="RelatedIdeasTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas">
                        </ss:EntityTree>
		<h2><%= Language.Projects %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentIdea.Projects %>' NoDataText='<%# Language.NoProjectsForIdea %>' id="ProjectsTree" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts">
                        </ss:EntityTree>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# CurrentIdea %>'  />
		</asp:Panel>