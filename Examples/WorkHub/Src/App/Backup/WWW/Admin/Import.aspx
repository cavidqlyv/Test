<%@ Page language="c#" AutoEventWireup="true" MasterPageFile="~/Site.master" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State	" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Data	" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import namespace="System.Collections.Specialized" %>
<%@ Import namespace="System.Collections.Generic" %>
<%@ Import namespace="System.Xml" %>
<%@ Register TagPrefix="cc" Assembly="SoftwareMonkeys.WorkHub.Web" Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="System.IO" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Projections" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Parts" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Controllers" %>

<script language="C#" runat="server">

		

    private void Page_Init(object sender, EventArgs e)
    {
        using (LogGroup logGroup = LogGroup.Start("Initializing the import page.", NLog.LogLevel.Debug))
        {
            if (!IsPostBack)
            {
                using (TimeoutExtender extender = TimeoutExtender.NewMinutes(120)) // TODO: See if this timeout can be reduced
				{
					Import();
				}
            }
        }
        
    }

    private void Import()
    {
        using (LogGroup logGroup = LogGroup.Start("Starting the import.", NLog.LogLevel.Debug))
        {
			try
			{
				ExecuteSetup();
				
				ModuleWebUtilities.EnableLegacyModules();
				
				ExecuteImport();

				PageViews.SetActiveView(SetupCompleteView);
            }
			catch (Exception ex)
			{
				LogWriter.Error("An error occurred while importing data.");
				
				LogWriter.Error(ex);
				
				throw;
			}
        }
    }

    private void ExecuteSetup()
    {
    
        string dataDirectoryPath = Server.MapPath(Request.ApplicationPath) + Path.DirectorySeparatorChar + "App_Data";
            
		ApplicationInstaller installer = new ApplicationInstaller();
		installer.UseLegacyData = true;
		installer.ApplicationPath = Request.ApplicationPath;
		installer.FileMapper = new FileMapper();
		installer.PathVariation = WebUtilities.GetLocationVariation(Request.Url);
		installer.DataProviderInitializer = new DataProviderInitializer();
		
		installer.Setup();
		
		InitializeWeb();
		
		InitializeModules();
		
    }
    

	private void InitializeWeb()
	{
		new ModularWebInitializer().Initialize(this);
	}
	
    public void InitializeModules()
    {            
    	ModulesInitializer.Initialize();
    	
    	ModuleWebUtilities.EnableLegacyModules();
    }
	
    private void ExecuteImport()
    {
		using (LogGroup logGroup = LogGroup.Start("Running the import process.", NLog.LogLevel.Debug))
        {
            string dataDirectoryPath = Server.MapPath(Request.ApplicationPath) + Path.DirectorySeparatorChar + "App_Data";
            
            ApplicationRestorer restorer = new ApplicationRestorer(new FileMapper());
            restorer.LegacyDirectoryPath = dataDirectoryPath + Path.DirectorySeparatorChar + "Import";
            
            restorer.PersonalizationDirectoryPath = dataDirectoryPath + Path.DirectorySeparatorChar + "Personalization_Data";
            
            restorer.Restore();
            
            ModuleWebUtilities.FixEnabledModules();
		}
    }
	
</script>
<asp:Content ContentPlaceHolderID="Body" runat="Server" ID="Body">
<asp:MultiView runat="server" ID="PageViews">
<asp:View runat="server" ID="SetupCompleteView">

<div class="Heading1"><%= Resources.Language.ImportComplete%></div>
<p><%= Resources.Language.ImportCompleteMessage %></p>
<ul><li><a href='../User-SignIn.aspx'><%= Resources.Language.SignIn %></a></li></ul>

</asp:View>
</asp:MultiView>
</asp:Content>
