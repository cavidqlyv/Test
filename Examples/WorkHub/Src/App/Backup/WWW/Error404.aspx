<%@ Page Language="C#" AutoEventWireup="true" Title="Error" ValidateRequest="false" Inherits="SoftwareMonkeys.WorkHub.Web.BasePage" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<script runat="server">
    protected Exception CurrentException = null;
	protected ModuleContext CurrentModuleContext;
    
    private void Page_Load(object sender, EventArgs e)
	{
		Response.TrySkipIisCustomErrors = true;
		Response.StatusCode = 404;
		Response.Status = "404 Not Found";
		
		try
		{
			CurrentException = Server.GetLastError();
			Exception exception = CurrentException;

			PageViews.SetActiveView(ErrorView);

			PageViews.DataBind();
		}
		catch (Exception ex)
		{
			LogWriter.Error("An error occurred on the error display page.");
			
			LogWriter.Error(new ExceptionHandler().GetMessage(ex));
			
			throw ex;
		}
		
		HttpContext.Current.ApplicationInstance.CompleteRequest();
    }    
    
    private string GetIssueSubject()
    {
    	return Resources.Language.PageNotFound + ": " + Request.Url.ToString();
    }
    
    private string GetIssueDescription()
    {
    	return new ExceptionHandler().GetMessage(CurrentException);
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
	
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
	    <title><%= Resources.Language.PageNotFound %></title>
	    <%= StyleUtilities.OutputStyleSheets() %>
	</head>
	<body>
	    <form id="form1" runat="server">
			<asp:MultiView runat="server" id="PageViews">
				<asp:View runat="server" id="ErrorView">
				<h1><%# Resources.Language.PageNotFound %></h1>
				<p>
				<%# Resources.Language.SorryPageNotFound %>
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
					&laquo; <a href='<%= Request.ApplicationPath %>'><%= Resources.Language.BackToHome %></a>
				</p>
				<% if (DataAccess.IsInitialized) { %>
			<p>
				WorkHub Version: <%= DataAccess.Data.Schema.ApplicationVersion %>
			</p>
				<% } %>
				</asp:View>
			</asp:MultiView>
		</form>
	</body>
</form>