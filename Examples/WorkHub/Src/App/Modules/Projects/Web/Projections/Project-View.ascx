<%@ Control Language="C#" ClassName="ViewProject" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Src="~/Controls/Parts.ascx" TagName="Parts" TagPrefix="uc" %>
<script runat="server">
	public Project CurrentProject;


    private void Page_Init(object sender, EventArgs e)
    {
    	if (QueryStrings.GetID("Project") != Guid.Empty)
    		CurrentProject = RetrieveStrategy.New<Project>().Retrieve<Project>("ID", QueryStrings.GetID("Project"));
    	else
    		CurrentProject = ProjectsState.Project;
    }

	private void Page_Load(object sender, EventArgs e)
	{
		DataBind();
	}
	
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Current;
      	MenuCategory = Language.Projects;
        ShowOnMenu = true;
    }
    
</script>
             
                                
		<asp:Panel runat="server" id="ProjectSummaryPanel" visible='<%# CurrentProject != null %>'>
		<div class="Trail">
		<a href='<%= Request.ApplicationPath %>'><%= Language.Home %></a> &gt;
		<a href='<%= new UrlCreator().CreateUrl("Index", "Project") %>'><%= Language.Projects %></a> &gt;
			<a href='<%= new UrlCreator().CreateUrl("View", CurrentProject) %>'><%= CurrentProject.Name %></a>
		</div>
		
		<h1>
		<%= CurrentProject != null ? CurrentProject.Name : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<p>
		<%= CurrentProject != null ? CurrentProject.Summary : String.Empty %>
		<%= (CurrentProject != null && CurrentProject.Summary == String.Empty) ? Language.NoSummary : String.Empty %>
		</p>
		<p class="ActionButtons">
		<input type="button" class="Button" value='<%= Language.EditProject %>' onclick='<%= "document.location.href=\"" + Navigator.GetLink("Edit", CurrentProject) + "\"" %>'/>
			<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# CurrentProject %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' />
			<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# CurrentProject %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' />
		</p>
		<p>
		<%= CurrentProject != null && CurrentProject.MoreInfo != null ? CurrentProject.MoreInfo.Replace("\n", "<br/>") : String.Empty %>
		</p>
		<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# CurrentProject %>'  />
      <uc:Parts runat="server"/>
		</asp:Panel>
		<asp:Panel runat="server" id="NoProjectSelectedPanel" visible='<%# CurrentProject == null %>'>
		<p><%= Language.NoProjectSelected %></p>
		</asp:Panel>
