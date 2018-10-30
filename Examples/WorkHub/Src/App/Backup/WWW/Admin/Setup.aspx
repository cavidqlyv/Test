<%@ Page language="c#" AutoEventWireup="true" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Parts" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Controllers" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.State" %>
<%@ Import namespace="System.Reflection" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Register TagPrefix="cc" Assembly="SoftwareMonkeys.WorkHub.Web" Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="System.IO" %>

<script language="C#" runat="server">

	public bool IsQuickSetup
	{
		get { return Request.QueryString["a"] == "QuickSetup"; }
	}


	private void Page_Load(object sender, EventArgs e)
	{
		using (LogGroup logGroup = LogGroup.StartDebug("Loading setup page."))
		{
		    if (!IsPostBack)
		    {
		    	SetupChecker checker = new SetupChecker();
		    	if (checker.RequiresImport())
		    		Response.Redirect(Request.ApplicationPath);
		    
        		using (TimeoutExtender timeoutExtender = TimeoutExtender.NewMinutes(30))
        		{
	        		Setup1();
	        	}
		    }
	    }
	    
	}

    private void Setup1()
    {
     	using (LogGroup logGroup = LogGroup.StartDebug("Starting setup wizard."))
     	{
	        if  (IsQuickSetup)
	        {
	            Setup2();
	        }
	        else if (SetupUtilities.RequiresRestore || SetupUtilities.RequiresImport)
	        {
	            Setup2();
	        }
	        else
	        {
	        	LogWriter.Debug("Showing setup form.");
	        
	            PageViews.SetActiveView(Setup1View);
	
	            User administrator = new User();
	            administrator.ID = Guid.NewGuid();
	            AdministratorDataForm.DataSource = administrator;
	
	            Setup1View.DataBind();
	        }
        }
    }

    private void Setup2()
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Preparing to execute setup process."))
    	{
	        ExecuteSetup();
	
	        PageViews.SetActiveView(SetupCompleteView);
	
	        SetupCompleteImportHolder.Visible = SetupUtilities.RequiresImport;
        }        
    }

    private void ExecuteSetup()
    {
        using (LogGroup logGroup = LogGroup.StartDebug("Running the setup process."))
        {
			using (TimeoutExtender extender = TimeoutExtender.NewMinutes(60))
			{
				ApplicationInstaller installer = new ApplicationInstaller();
				installer.ApplicationPath = Request.ApplicationPath;
				installer.FileMapper = new FileMapper();
				installer.PathVariation = WebUtilities.GetLocationVariation(Request.Url);
				installer.DataProviderInitializer = new DataProviderInitializer();
				installer.AdministratorRoleName = Resources.Language.Administrator;
				
				installer.Administrator = GetAdministrator();
				
				installer.Setup(GetDefaultSettings());
				
				// Initialize web BEFORE modules otherwise the modules can't initialize
				InitializeWeb();
				
				InitializeModules();
		
    			// Set the LastAutoBackup time stamp so that the auto backup doesn't start for 10 minutes
    			StateAccess.State.SetApplication("LastAutoBackup", DateTime.Now.Subtract(new TimeSpan(0, 50, 0)));
				
				if (!SetupUtilities.RequiresRestore)
				{
					Authentication.SetAuthenticatedUsername(installer.Administrator.Username);
					
					Response.Redirect(Request.ApplicationPath + "/Guide.aspx?a=SetupComplete");
				}
				else
					Response.Redirect("Restore.aspx");
        	}
        }
    }
    
    private Dictionary<string, object> GetDefaultSettings()
    {
    	Dictionary<string, object> settings = new Dictionary<string, object>();
    	
    	settings.Add("EnableUserRegistration", true);
    	settings.Add("WelcomeMessage", GetWelcomeMessage());
    	
    	return settings;
    }
    
    private string GetWelcomeMessage()
    {
    	return "<a href='" + Request.ApplicationPath + "/WelcomeSettings/Edit.aspx'>Add your own welcome message</a> here...";
    }
    
	private void InitializeWeb()
	{
		new ModularWebInitializer().Initialize(this);
	}
    
    private User GetAdministrator()
    {
        if (!SetupUtilities.RequiresImport && !SetupUtilities.RequiresRestore)
        {
            if (IsQuickSetup)
                return CreateDefaultAdministrator();
            else
                return CreateFormAdministrator();
    	}
    	
    	return null;
    }
    
    private User CreateFormAdministrator()
    {
    	User administrator = (User)AdministratorDataForm.DataSource;
        administrator.ID = Guid.NewGuid();
        administrator.IsApproved = true;

        AdministratorDataForm.ReverseBind(administrator);

        administrator.Password = SoftwareMonkeys.WorkHub.Business.Crypter.EncryptPassword(administrator.Password);
                    
        return administrator;
    }
    
    private User CreateDefaultAdministrator()
    {
    	User administrator = new User();
        administrator.Username = "admin";
        administrator.Password = SoftwareMonkeys.WorkHub.Business.Crypter.EncryptPassword("pass");
        administrator.FirstName = "System";
        administrator.LastName = "Administrator";
        administrator.Email = "default@softwaremonkeys.net";
        administrator.ID = Guid.NewGuid();
        administrator.IsApproved = true;
        administrator.EnableNotifications = true;
        
        return administrator;
    }
    

    private void CancelSetup()
    {
        PageViews.SetActiveView(SetupAbortedView);
    }

    protected void StartSetupButton_Click(object sender, EventArgs e)
    {
        Setup2();
    }
    
    private void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Start")
        {
            Setup2();
        }
    }
    
    public void InitializeModules()
    {            
    	ModulesInitializer.Initialize();
    	
    	EnableModules();
    }
    
    public void EnableModules()
    {
    	using (LogGroup logGroup = LogGroup.Start("Enabling the default modules.", NLog.LogLevel.Debug))
    	{
	    	string[] moduleOrder = ModuleWebUtilities.GetDefaultModules();
	    	
	    	foreach (string moduleID in moduleOrder)
	    	{
		    	using (LogGroup logGroup2 = LogGroup.StartDebug("Enabling module: " + moduleID))
		    	{
		    		ModuleState.Enable(moduleID);
	    		}
	    	}
    	}
    }


private string OutputStylesheets()
{   
	return StyleUtilities.GetStyleSheet("SLayout") +
		StyleUtilities.GetStyleSheet("Content");
}
</script>
<html>
<head>
<title><%= Resources.Language.WorkHub + " " + Resources.Language.Setup %></title>
<%= OutputStylesheets() %>
</head>
<body>
<form runat="server">
<asp:MultiView runat="server" ID="PageViews">
<asp:View runat="server" ID="Setup1View">
<h1><%= Resources.Language.WorkHub + " " + Resources.Language.Setup %></h1>
<p><%= Resources.Language.StartSetupIntro %></p>
      <cc:EntityForm runat="server" id="AdministratorDataForm" OnEntityCommand="DataForm_EntityCommand" CssClass="Panel" HeadingText='<%# Resources.Language.AdministratorDetails %>' headingcssclass="Heading2" width="100%">
			
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="Username" TextBox-Width="400" FieldControlID="Username" IsRequired="true" text='<%# Resources.Language.Username + ":" %>' RequiredErrorMessage='<%# Resources.Language.UsernameRequired %>'></cc:EntityFormTextBoxItem>
                        
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="Password" TextBox-Width="200" FieldControlID="Password" IsRequired='true' text='<%# Resources.Language.Password + ":" %>' RequiredErrorMessage='<%# Resources.Language.PasswordRequired %>' TextBox-TextMode='Password'></cc:EntityFormTextBoxItem>
                        
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="Password" TextBox-Width="200" FieldControlID="PasswordConfirm" IsRequired='true' text='<%# Resources.Language.PasswordConfirm + ":" %>' RequiredErrorMessage='<%# Resources.Language.PasswordConfirmRequired %>' TextBox-TextMode='Password'></cc:EntityFormTextBoxItem>
                        
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="FirstName" TextBox-Width="400" FieldControlID="FirstName" IsRequired="true" text='<%# Resources.Language.FirstName + ":" %>' RequiredErrorMessage='<%# Resources.Language.FirstNameRequired %>'></cc:EntityFormTextBoxItem>
                        
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="LastName" TextBox-Width="400" FieldControlID="LastName" IsRequired="true" text='<%# Resources.Language.LastName + ":" %>' RequiredErrorMessage='<%# Resources.Language.LastNameRequired %>'></cc:EntityFormTextBoxItem>
                        
                           <cc:EntityFormTextBoxItem runat="server" PropertyName="Email" TextBox-Width="400" FieldControlID="Email" IsRequired="true" text='<%# Resources.Language.Email + ":" %>' RequiredErrorMessage='<%# Resources.Language.EmailRequired %>'></cc:EntityFormTextBoxItem>
                        
                      <cc:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="StartButton" runat="server" CausesValidation="True" CommandName="Start"
                                                    Text='<%# Resources.Language.Start + "  &raquo;" %>'></asp:Button> <i><%= Resources.Language.SetupMayTakeAWhile %></i>
                                                   </FieldTemplate></cc:EntityFormButtonsItem>
</cc:EntityForm>
</asp:View>
<asp:View runat="server" ID="SetupCompleteView">

<div class="Heading1"><%= Resources.Language.SetupComplete%></div>
<p><%= Resources.Language.SetupCompleteMessage %></p>
<asp:PlaceHolder runat="server" ID="SetupCompleteImportHolder">
<p><%= Resources.Language.SetupImportMessage %></p>
<p><i>(<%= Resources.Language.PleaseWait %>)</i></p>
<script type="text/JavaScript">
<!--
setTimeout("location.href = '<%= Request.ApplicationPath %>/Admin/Restore.aspx';",300);
-->
</script>

</asp:PlaceHolder>

</asp:View>
<asp:View runat="server" ID="SetupAbortedView">

<div class="Heading1"><%= Resources.Language.SetupAborted%></div>
<p><%= Resources.Language.SetupHasAlreadyRun%></p>
</asp:View>
</asp:MultiView>
</form>
</body>
</html>
