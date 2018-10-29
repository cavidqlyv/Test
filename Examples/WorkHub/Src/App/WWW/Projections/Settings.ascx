<%@ Control Language="C#" ClassName="RegisterEditProjection" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<script runat="server">
    
    #region Main functions
    /// <summary>
    /// Displays the index for managing configs.
    /// </summary>
    private void ManageSettings()
    {
        OperationManager.StartOperation("ManageSettings", IndexView);

	    Authorisation.EnsureUserCan("Edit", "Settings");

        //IndexGrid.DataSource = configs;

        IndexView.DataBind();
    }

    #endregion

    #region Event handlers
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
                    ManageSettings();
        }
    }

    #endregion

</script>
    <asp:MultiView ID="PageView" runat="server">
        <asp:View ID="IndexView" runat="server">
            <h1>
                        <%# Resources.Language.Settings %></h1>

                        <cc:Result runat="server" ID="IndexResult">
                        </cc:Result>
                        <p>
                            <%# Resources.Language.SettingsIntro %></p>
			<ul>
				<li>
		                         <a href='<%= new UrlCreator().CreateUrl("WebSiteSettings") %>' id='WebSiteSettingsLink'><%# Resources.Language.WebSiteSettings %></a>
				</li>
				<li>
		                         <a href='<%= new UrlCreator().CreateUrl("WelcomeSettings") %>' id='WelcomeSettingsLink'><%# Resources.Language.WelcomeSettings %></a>
				</li>
				<li>
		                         <a href='<%= new UrlCreator().CreateUrl("UserSettings") %>' id='UserSettingsLink'><%# Resources.Language.UserSettings %></a>
				</li>
				<li>
		                         <a href='<%= new UrlCreator().CreateUrl("EmailSettings") %>' id='EmailSettingsLink'><%# Resources.Language.EmailSettings %></a> - <a href='<%= new UrlCreator().CreateUrl("TestSmtp") %>' id='TestSmtpLink'><%# Resources.Language.TestSmtpSettings %></a>
				</li>
				<li>
		                         <a href='<%= new UrlCreator().CreateUrl("AnalyticsSettings") %>' id='AnalyticsSettingsLink'><%# Resources.Language.AnalyticsSettings %></a>
				</li>
			</ul>
        </asp:View>
    </asp:MultiView>