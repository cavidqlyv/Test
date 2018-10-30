<%@ Control
	Language           = "C#"
	AutoEventWireup    = "true"
%>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Parts" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<script runat="server">
	private ModuleContext currentModuleContext;
	public ModuleContext CurrentModuleContext
	{
		get
		{
			if (currentModuleContext == null)
				currentModuleContext = ModuleWebUtilities.GetCurrentModule();
			return currentModuleContext;
		}
	}
	
	private string GetReportModuleIssueLink()
	{
		if (CurrentModuleContext != null)
			return ConfigurationSettings.AppSettings["ReportIssueUrl"]
				.Replace("${Project.ID}", CurrentModuleContext.Config.UniversalProjectID.ToString())
				.Replace("${Project.Version}", ModuleVersionUtilities.GetModuleVersion(CurrentModuleContext.ModuleID).ToString());
		else
			return String.Empty;
	}
	
	private string GetPostModuleSuggestionLink()
	{
		if (CurrentModuleContext != null)
			return ConfigurationSettings.AppSettings["PostSuggestionUrl"]
				.Replace("${Project.ID}", CurrentModuleContext.Config.UniversalProjectID.ToString())
				.Replace("${Project.Version}", ModuleVersionUtilities.GetModuleVersion(CurrentModuleContext.ModuleID).ToString());
		else
			return String.Empty;
	}
	
	private string GetReportIssueLink()
	{
			return ConfigurationSettings.AppSettings["ReportIssueUrl"]
				.Replace("${Project.ID}", ConfigurationSettings.AppSettings["UniversalProjectID"])
				.Replace("${Project.Version}", VersionUtilities.GetCurrentVersion().ToString());
	}
	
	private string GetPostSuggestionLink()
	{
			return ConfigurationSettings.AppSettings["PostSuggestionUrl"]
				.Replace("${Project.ID}", ConfigurationSettings.AppSettings["UniversalProjectID"])
				.Replace("${Project.Version}", VersionUtilities.GetCurrentVersion().ToString());
	}
</script>
<asp:Panel runat="server" HorizontalAlign="center" ID="FeedbackPanel">

<% if (CurrentModuleContext != null) { %>
	<%= CurrentModuleContext.Config.Title + " (" + CurrentModuleContext.Config.Name.Replace(" Module", String.Empty) + ") " + Resources.Language.Module %>: <a target="_blank" href="<%= GetReportModuleIssueLink() %>"><%= Resources.Language.ReportIssue %></a>
	-
	<a target="_blank" href="<%= GetPostModuleSuggestionLink() %>"><%= Resources.Language.PostSuggestion %></a>
<% } %><br/>

			
<%= Resources.Language.WorkHub %>: <a target="_blank" href="<%= GetReportIssueLink() %>"><%= Resources.Language.ReportIssue %></a> - <a target="_blank" href="<%= GetPostSuggestionLink() %>"><%= Resources.Language.PostSuggestion %></a>
</asp:Panel>