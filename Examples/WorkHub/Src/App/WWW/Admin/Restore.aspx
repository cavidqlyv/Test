<%@ Page language="c#" AutoEventWireup="true" MasterPageFile="~/Site.master" %>
<%@ Register TagPrefix="cc" Assembly="SoftwareMonkeys.WorkHub.Web" Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import namespace="System.Collections.Specialized" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Xml" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Controllers" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Parts" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>

<script language="C#" runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
        using (LogGroup logGroup = LogGroup.Start("Initializing the import page.", NLog.LogLevel.Debug))
        {
            	// Set a long timeout because the import process can take a long time especially if there's a lot of data
				using (TimeoutExtender timeoutExtender = TimeoutExtender.NewMinutes(120))
				{
		        	EnsureRequiresRestore();
		        
		            if (!IsPostBack)
		            {
							Restore();
		            }
            	}
        }
        
    }
    
    private void EnsureRequiresRestore()
    {
			SetupChecker setupChecker = new SetupChecker();
			if (!setupChecker.RequiresRestore())
				Response.Redirect(Request.ApplicationPath);
    }

    private void Restore()
    {
        using (LogGroup logGroup = LogGroup.Start("Starting the restore process.", NLog.LogLevel.Debug))
        {
        	ExecuteSetup();
        	
            ModuleWebUtilities.EnableLegacyModules();
        
            ExecuteRestore();
        }
    }
    
    private void ExecuteSetup()
    {
    
		ApplicationInstaller installer = new ApplicationInstaller();
		installer.UseLegacyData = true;
		installer.ApplicationPath = Request.ApplicationPath;
		installer.FileMapper = new FileMapper();
		installer.PathVariation = WebUtilities.GetLocationVariation(Request.Url);
		installer.DataProviderInitializer = new DataProviderInitializer();
		installer.AdministratorRoleName = Resources.Language.Administrator;
		
		installer.Setup();
		
		InitializeWeb();
    }

	private void InitializeWeb()
	{
		new ModularWebInitializer().Initialize(this);
	}
    
    
    private void ExecuteRestore()
    {
		using (LogGroup logGroup = LogGroup.Start("Running the restore process.", NLog.LogLevel.Debug))
        {
            LogWriter.Debug("Converting and importing core data.");
          
            string dataDirectoryPath = Server.MapPath(Request.ApplicationPath) + Path.DirectorySeparatorChar + "App_Data";
            
            ApplicationRestorer restorer = new ApplicationRestorer(new FileMapper());
            restorer.LegacyDirectoryPath = dataDirectoryPath + Path.DirectorySeparatorChar + "Legacy";
            restorer.PersonalizationDirectoryPath = dataDirectoryPath + Path.DirectorySeparatorChar + "Personalization_Data";
            
            if (restorer.RequiresRestore)
            {
	            restorer.Restore();
	            
				// Fix the enabled modules config setting if needed
				ModuleWebUtilities.FixEnabledModules();
	        }
	        else
	        	Response.Redirect(Request.ApplicationPath + "/Default.aspx");


            
		}
    }
    
	
</script>
<asp:Content ContentPlaceHolderID="Body" runat="Server" ID="Body">
<div class="Heading1"><%= Resources.Language.UpdateComplete%></div>
<p><%= Resources.Language.UpdateCompleteMessage %></p>
<p><%= Resources.Language.PreviousVersion %>: <%= DataAccess.Data.Schema.LegacyVersion %></p>
<p><%= Resources.Language.CurrentVersion %>: <%= DataAccess.Data.Schema.ApplicationVersion %></p>

</asp:Content>
