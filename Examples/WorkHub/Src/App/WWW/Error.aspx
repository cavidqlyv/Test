<%@ Page Language="C#" AutoEventWireup="true" Title="Error" ValidateRequest="false" Inherits="SoftwareMonkeys.WorkHub.Web.BasePage" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<script runat="server">
    protected Exception CurrentException = null;
	protected ModuleContext CurrentModuleContext;
    
    private void Page_Load(object sender, EventArgs e)
    {
		Response.StatusCode = 500;

		try
		{
			if (QueryStrings.Action != String.Empty && QueryStrings.Type != String.Empty)
			{
				if (ProjectionState.Projections.ProjectionExists(QueryStrings.Action, QueryStrings.Type))
				{
					ProjectionInfo projection = ProjectionState.Projections[QueryStrings.Action, QueryStrings.Type];
				
					string moduleID = ModuleWebUtilities.GetModuleID(projection);
					
					if (moduleID != String.Empty)
						CurrentModuleContext = ModuleState.Modules[moduleID];
				}
			}

			Exception exception = CurrentException = Server.GetLastError();

			PageViews.SetActiveView(ErrorView);

			PageViews.DataBind();
		}
		catch (Exception ex)
		{
			LogWriter.Error("An error occurred on the error display page.");
			
			LogWriter.Error(new ExceptionHandler().GetMessage(ex));
		}
    }    

	protected string GetWorkHubProjectID()
	{
		return ConfigurationSettings.AppSettings["UniversalProjectID"];
	}
	
	protected string GetModuleProjectID()
	{
		if (CurrentModuleContext == null)
			return Guid.Empty.ToString();
		return CurrentModuleContext.Config.UniversalProjectID.ToString();
	}
	
    private string GetIssueSubject()
    {
    	if (CurrentException == null)
    		return String.Empty;
    	else
    		return CurrentException.GetType().Name + ": " + Utilities.Summarize(CurrentException.Message, 100);
    }
    
    private string GetIssueDescription()
    {
    	if (CurrentException == null)
    		return String.Empty;
    	else
    		return new ExceptionHandler().GetMessage(CurrentException);
    }
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
	    <title><%= WindowTitle %></title>
	    <%= StyleUtilities.OutputStyleSheets() %>
	</head>
	<body>
	
		<form runat="server">
			<asp:MultiView runat="server" id="PageViews">
				<asp:View runat="server" id="ErrorView">
					<h1><%# Resources.Language.ErrorPageTitle %></h1>
				
					<p>
					<textarea id="ErrorDetails" style="width: 98%; height: 300px; font-size: 11px;"><%# CurrentException != null ? CurrentException.ToString() : Resources.Language.NoErrorOccurred %>
					</textarea>
					</p>
					<p>
					<% if (CurrentModuleContext != null) { %>
					<%= CurrentModuleContext.Config.Title + " (" + CurrentModuleContext.Config.Name.Replace(" Module", String.Empty) + ") " + Resources.Language.Module %>: <cc:ReportIssueLink runat="server" id="ReportModuleIssueLink" IssueSubject='<%# GetIssueSubject() %>' IssueDescription='<%# GetIssueDescription() %>' ProjectID='<%# GetModuleProjectID() %>' />
					<% } %>
					</p>
					<p>
					<%= Resources.Language.WorkHub %>: <cc:ReportIssueLink runat="server" id="ReportWorkHubIssueLink"  IssueSubject='<%# GetIssueSubject() %>' IssueDescription='<%# GetIssueDescription() %>' ProjectID='<%# GetWorkHubProjectID() %>'  />
					</p>
					<p>
					<a href='<%= Request.ApplicationPath %>'><%= Resources.Language.BackToHome %> &raquo;</a>
					</p>
			<p>
				WorkHub Version: <%= DataAccess.Data.Schema.ApplicationVersion %>
			</p>
				</asp:View>
			</asp:MultiView>
		</form>
	</body>
</html>

