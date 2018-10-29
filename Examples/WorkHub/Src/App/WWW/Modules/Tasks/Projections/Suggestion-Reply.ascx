<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<script runat="server">
public Suggestion DataSource;

private void Page_Load(object sender, EventArgs e)
{
	if (IsPostBack)
		PageView.SetActiveView(SentView);
	else
	{	
		PageView.SetActiveView(FormView);
		
		Guid suggestionID = Guid.Empty;
		
		try
		{
			suggestionID = new Guid(Request.QueryString["SuggestionID"]);
		}
		catch (Exception ex)
		{
			LogWriter.Error("Invalid suggestion ID: " + Request.QueryString["SuggestionID"] + Environment.NewLine + new ExceptionHandler().GetMessage(ex));
		
			Navigator.Go("Index", "Suggestion");
		}
		
		if (suggestionID != Guid.Empty)
		{
			DataSource = RetrieveStrategy.New<Suggestion>().Retrieve<Suggestion>("ID", suggestionID);
			
			if (DataSource == null)
				throw new EntityNotFoundException("Suggestion", suggestionID);
			else
				DataBind();
		}
	}
}
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="FormView">
                   <h1><%# Language.Reply %></h1>
                   <p><%= Language.ReplyToSuggestionAuthorIntro %></p>
                   <cc:ContactForm runat="server"
                   	HeaderText='<%# Language.ReplyDetails %>'
                   	HeaderCssClass='Heading2'
                   	LabelCssClass="FieldLabel"
                   	FieldCssClass="Field"
                   	ToEmail='<%# DataSource.AuthorEmail %>'
                   	FromEmail='<%# AuthenticationState.User.Email %>'
                   	SuccessMessage='<%# Language.SuggestionReplySent %>'
                   	Subject='<%# Language.Re + ": " + DataSource.Subject %>'
                   	ToName='<%#  DataSource.AuthorName %>'
                   />
        </asp:View>
        <asp:View runat="server" ID="SentView">
                   <h1><%# Language.ReplySent %></h1>
                   <cc:result runat="server"/>
                   <p><a href='<%= Navigator.GetLink("Index", "Suggestion") %>'><%= Language.Continue %> &raquo;</a></p>
        </asp:View>
    </asp:MultiView>