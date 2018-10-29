<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<script runat="server">
public Issue DataSource;

private void Page_Load(object sender, EventArgs e)
{
	if (IsPostBack)
		PageView.SetActiveView(SentView);
	else
	{	
		// TODO: Check if authorisation check is required
	
		PageView.SetActiveView(FormView);
		
		Guid issueID = Guid.Empty;
		
		try
		{
			issueID = new Guid(Request.QueryString["IssueID"]);
		}
		catch (Exception ex)
		{
			LogWriter.Error("Invalid issue ID: " + Request.QueryString["IssueID"] + Environment.NewLine + new ExceptionHandler().GetMessage(ex));
			
			Navigator.Go("Index", "Issue");
		}
		
		if (issueID != Guid.Empty)
		{
			DataSource = RetrieveStrategy.New<Issue>().Retrieve<Issue>("ID", issueID);
			
			if (DataSource == null)
				throw new EntityNotFoundException("Issue", issueID);
			else
				DataBind();
		}
	}
}
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="FormView">
                   <h1><%# Language.Reply %></h1>
                   <p><%= Language.ReplyToIssueReporterIntro %></p>
                   <cc:ContactForm runat="server"
                   	HeaderText='<%# Language.ReplyDetails %>'
                   	HeaderCssClass='Heading2'
                   	LabelCssClass="FieldLabel"
                   	FieldCssClass="Field"
                   	ToEmail='<%# DataSource.ReporterEmail %>'
                   	FromEmail='<%# AuthenticationState.IsAuthenticated && AuthenticationState.User != null ? AuthenticationState.User.Email : String.Empty %>'
                   	SuccessMessage='<%# Language.IssueReplySent %>'
                   	Subject='<%# Language.Re + ": " + DataSource.Subject %>'
                   	ToName='<%#  DataSource.ReporterName %>'
                   />
        </asp:View>
        <asp:View runat="server" ID="SentView">
                   <h1><%# Language.ReplySent %></h1>
                   <cc:result runat="server"/>
                   <p><a href='<%= Navigator.GetLink("Index", "Issue") %>'><%= Language.Continue %> &raquo;</a></p>
        </asp:View>
    </asp:MultiView>