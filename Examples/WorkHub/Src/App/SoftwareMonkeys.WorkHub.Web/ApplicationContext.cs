using System;
using System.Web;
using SoftwareMonkeys.WorkHub.State;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Web;
using SoftwareMonkeys.WorkHub.Web.Data;
using SoftwareMonkeys.WorkHub.Web.Elements;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using SoftwareMonkeys.WorkHub.Web.Parts;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// The base class for the Global.asax file.
	/// </summary>
	public class ApplicationContext : System.Web.HttpApplication
	{
		ApplicationLock AppLock = new ApplicationLock();
		
		void Application_Start(object sender, EventArgs e)
		{
			InitializeTimeout();
			
			// Initialze the core state management and diagnostics
			InitializeCore();
			
			using (LogGroup logGroup = LogGroup.Start("Starting application."))
			{
				LogWriter.Debug("${Application.Start}");
				
				// Initialze the entire application
				Initialize();
				
				// Suspend the auto backup so it doesn't start immediately
				SuspendAutoBackup();
				
			}
		}

		private void InitializeTimeout()
		{
			if (new ModeDetector().IsDebug)
			{
				Context.Server.ScriptTimeout = 120 // minutes
					* 60 // seconds
					* 1000; // milliseconds
			}
		}
		
		void Application_End(object sender, EventArgs e)
		{
			using (LogGroup logGroup = LogGroup.Start("Ending application."))
			{
				LogWriter.Info("${Application.End}");
			}

			//  Dispose outside the log group because all logging needs to be finished
			Dispose();
		}
		
		void Application_Error(object sender, EventArgs e)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Application error."))
			{
				LogWriter.Debug("${Application.Error}");
				
				Exception lastException = Server.GetLastError();
				
				ExceptionHandler handler = new ExceptionHandler();
				handler.Handle(lastException);
			}
		}

		void Session_Start(object sender, EventArgs e)
		{
			InitializeCore();
			
			// Create a log group for the session
			HttpContext.Current.Session["Session_Start.LogGroup"] = LogGroup.StartDebug("Starting session.");
			
			LogWriter.Debug("${Session.Start}");
			
			// Attempt to initialize the config
			Initialize();
		}

		void Session_End(object sender, EventArgs e)
		{
			LogWriter.Debug("${Session.End}");
			
			// Not needed because the Session collection is cleared anyway
			//HttpContext.Current.Session["Session_Start.LogGroup"] = null;
		}
		
		void Application_BeginRequest(object sender, EventArgs e)
		{
			InitializeTimeout();
			
			InitializeCore();
			
			// Create a log group for the request
			HttpContext.Current.Items["Application_BeginRequest.LogGroup"] = LogGroup.StartDebug("Beginning request: " + HttpContext.Current.Request.Url.ToString());

			LogWriter.Debug("${Application.BeginRequest}");
			
			Initialize();
			
			UrlRewriter.Initialize();
		}
		
		
		void Application_EndRequest(object sender, EventArgs e)
		{
			LogWriter.Debug("${Application.EndRequest}");
			
			new AutoBackupInitializer().Initialize();
			
			HttpContext.Current.Items["Application_BeginRequest.LogGroup"] = null;
		}

		private void InitializeCore()
		{
			InitializeState();
		}

		private void Initialize()
		{
			using (LogGroup logGroup = LogGroup.Start("Initializing the config, entities, data, business, and web components", LogLevel.Debug))
			{
				Config.Initialize(Server.MapPath(HttpContext.Current.Request.ApplicationPath), WebUtilities.GetLocationVariation(HttpContext.Current.Request.Url));
				InitializeEntities();
				InitializeData();
				InitializeBusiness();
				InitializeModules();
				InitializeWeb();
			}
		}

		private void InitializeEntities()
		{
			new EntityInitializer().Initialize();
		}
		
		private void InitializeData()
		{
			new DataProviderInitializer().Initialize();
		}
		
		private void InitializeBusiness()
		{
			new StrategyInitializer().Initialize();
			new ReactionInitializer().Initialize();
		}
		
		private void InitializeWeb()
		{
			PartsInitializer.DefaultScanners = new PartScanner[] {
				new PartScanner(),
				new ModulePartScanner()
			};
			
			ProjectionsInitializer.DefaultScanners = new ProjectionScanner[] {
				new ProjectionScanner(),
				new ModuleProjectionScanner()
			};
			
			// Increase the timeout on the rare chance the cache needs to be initialized from scratch
			using (TimeoutExtender extender = TimeoutExtender.NewMinutes(30))
			{
				new ControllersInitializer().Initialize();
				new ElementsInitializer().Initialize();
				new ProjectionsInitializer().Initialize();
				new PartsInitializer().Initialize();
			}
		}
		
		private void InitializeState()
		{
			SoftwareMonkeys.WorkHub.Web.State.StateProviderInitializer.Initialize();
		}
		
		private void InitializeModules()
		{
			//  This initialization is done during setup
			string[] enabledModules = new string[] {};
			if (Config.Application != null && Config.Application.EnabledModules != null)
				enabledModules = Config.Application.EnabledModules;
			
			SoftwareMonkeys.WorkHub.Web.Modules.ModulesInitializer.Initialize(enabledModules);
		}
		
		public override void Dispose()
		{
			DataAccess.Dispose(true);
			Config.Dispose();
			DiagnosticState.Dispose();

			base.Dispose();
		}
		
		private void SuspendAutoBackup()
		{
			StateAccess.State.SetApplication("LastAutoBackup", DateTime.Now);
		}
		
	}
}
