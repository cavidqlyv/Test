<%@ Control Language="C#" ClassName="WelcomeSettings" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
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
    /// Displays the form for editing the specified entity.
    /// </summary>
    private void EditSettings()
    {        
        // Start the operation
        OperationManager.StartOperation("EditSettings", SettingsFormView);

        AppConfig config = (AppConfig)Config.Application;

        Authorisation.EnsureUserCan("Edit", "Settings");

        // Bind the form
        SettingsFormView.DataBind();
    }

    /// <summary>
    /// Updates the currently edited entity.
    /// </summary>
    private void UpdateSettings()
    {
        // Get a fresh copy of the config object
        AppConfig config = (AppConfig)Config.Application;

        config.Settings["WelcomeMessage"] = WelcomeMessage.Text;
    
        // Update the config
        config.Save();

		Config.Application = config;

        // Display the result to the config
        Result.Display(Resources.Language.WelcomeMessageUpdated);

        // Show the index again
            Navigator.Go("Settings");
    }

    #endregion

    #region Event handlers
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EditSettings();
        }
    }

    private void SettingsForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Update")
        {
            UpdateSettings();
        }
        else
            Navigator.Go("Index", "Settings");
    }

    private void UpdateButton_Click(object sender, EventArgs e)
    {
        UpdateSettings();
    }

    private void CancelButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Settings.aspx");
    }
    #endregion

</script>
    <asp:MultiView ID="PageView" runat="server">
        <asp:View ID="SettingsFormView" runat="server">
     
                         <h1>
                        <%# Resources.Language.WelcomeSettings %>
                        </h1>
                          <cc:Result runat="server"></cc:Result>
                        <p>
                             <%# Resources.Language.EditWelcomeSettingsIntro %>
                         </p>
                                               
                            <table class="BodyPanel" width="100%">
                                <tr>
                                    <td colspan="2" class="Heading2"><%# Resources.Language.WelcomeSettings %></td>
                                </tr>
                                 <tr>
                                    <td class="FieldLabel"><%# Resources.Language.WelcomeMessage + ":"%></td>
                                    <td class="Field">
                                    <asp:TextBox runat="Server" id="WelcomeMessage" width="400px" cssClass="Form" textmode="multiline" rows="10" text='<%# Config.Application.Settings.GetString("WelcomeMessage") %>'/>
                                </tr>
                                <tr>
                                    <td></td><td>
                                                    <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" OnClick="UpdateButton_Click" CommandName="Update"
                                                    Text='<%# Resources.Language.Update %>'></asp:Button>
                                                </td></tr></table>
        </asp:View>
    </asp:MultiView>