<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<script runat="server">
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	ShowLinkInfo();
            //CreateIssue();
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
    }

    #region Main functions
   
    /// <summary>
    /// Displays the form for creating a new issue.
    /// </summary>
    public void ShowLinkInfo()
    {
        PageViews.SetActiveView(DetailsView);
    }
    #endregion
   
</script>
    <asp:MultiView runat="server" ID="PageViews">
        <asp:View runat="server" ID="DetailsView">
                     <H1><%= Language.LinkToIssues %></H1>
                     <cc:Result runat="Server"></cc:Result>
                     <p><%= Language.LinkToIssuesIntro %></p>
                     <h2>Simple Link</h2>
                     <H3>Example:</H3>
                     <p>
						<textarea class="CodeExample" style="width: 100%;" rows="1"><%= new ExternalNavigator().GetExternalLink("Report", "Issue") %></textarea>
						</p>
                     <H3>Code:</H3>
                     <p>
        	         <textarea class="CodeExample" style="width: 100%;" rows="3"><a href='<%= new ExternalNavigator().GetExternalLink("Report", "Issue") %>'>
    Report issue
</a>
						</textarea>
					</p>
        </asp:View>
    </asp:MultiView>
                         