using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.UI.Modules;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using System.Collections;
using System.IO;

namespace SoftwareMonkeys.WorkHub.Web.Modules
{
	/// <summary>
	/// Contains functions to assist between the UI and the backend of modules.
	/// </summary>
	public class ModuleFacade : IModuleFacade
	{
		private SiteMap siteMap;
		/// <summary>
		/// Gets/sets the current site map.
		/// </summary>
		public SiteMap SiteMap
		{
			get {
				if (siteMap == null)
					siteMap = SoftwareMonkeys.WorkHub.Web.SiteMap.Load(SoftwareMonkeys.WorkHub.Web.SiteMap.DefaultFilePath);
				return siteMap; }
			set { siteMap = value; }
		}
		
		private UrlCreator urlCreator;
		/// <summary>
		/// Gets/sets the URL creator used to generate URLs.
		/// </summary>
		public UrlCreator UrlCreator
		{
			get {
				if (urlCreator == null && HttpContext.Current != null)
				{
					urlCreator = new UrlCreator(HttpContext.Current.Request.ApplicationPath, HttpContext.Current.Request.Url.ToString());
				}
				return urlCreator; }
			set { urlCreator = value; }
		}
		
		private ProjectionLoader projectionLoader;
		public ProjectionLoader ProjectionLoader
		{
			get {
				if (projectionLoader == null)
					projectionLoader = new ProjectionLoader();
				return projectionLoader; }
			set { projectionLoader = value; }
		}
		
		private PartLoader partLoader;
		public PartLoader PartLoader
		{
			get {
				if (partLoader == null)
					partLoader = new PartLoader();
				return partLoader; }
			set { partLoader = value; }
		}
		
		public ModuleFacade()
		{
		}

		/// <summary>
		/// Enables the provided module and adds it to the site map.
		/// </summary>
		/// <param name="moduleID">The ID of the module to enable and add to the site map.</param>
		public virtual void Enable(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the module with the ID: " + moduleID, NLog.LogLevel.Debug))
			{
				ModuleContext module = ModuleState.Loader.GetModule(moduleID);
				
				EnableModuleProjections(module);
				EnableModuleParts(module);
				AddModuleToSiteMap(module);
			}
		}

		/// <summary>
		/// Disables the provided module and adds it to the site map.
		/// </summary>
		/// <param name="moduleID">The ID of the module to disabled and remove from the site map.</param>
		public virtual void Disable(string moduleID)
		{
			using (LogGroup logGroup = LogGroup.Start("Disabling the module with the ID: " + moduleID, NLog.LogLevel.Debug))
			{
				ModuleContext module = ModuleState.Loader.GetModule(moduleID);
				
				DisableModuleProjections(module);
				DisableModuleParts(module);
				RemoveModuleFromSiteMap(module);
			}
		}
		
		/// <summary>
		/// Adds the provided module to the site map.
		/// </summary>
		/// <param name="module">The module to add to the site map.</param>
		public virtual void AddModuleToSiteMap(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding the module '" + module.ModuleID + "' to the site map.", NLog.LogLevel.Debug))
			{
				if (SiteMap == null)
					throw new InvalidOperationException("The SiteMap property hasn't been initialized.");
				
				ISiteMapManager manager = module.GetSiteMapManager();
				
				if (manager != null)
				{
					SiteMap map = SiteMap;
					map.UrlCreator = UrlCreator;
					
					manager.Add(map);
					
					map.Save();
				}
			}
		}
		
		/// <summary>
		/// Removes the provided module from the site map.
		/// </summary>
		/// <param name="module">The module to remove from the site map.</param>
		public virtual void RemoveModuleFromSiteMap(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the module '" + module.ModuleID + "' from the site map.",NLog.LogLevel.Debug))
			{
				if (SiteMap == null)
					throw new InvalidOperationException("The SiteMap property hasn't been initialized.");
				
				ISiteMapManager manager = module.GetSiteMapManager();
				
				if (manager != null)
				{
					SiteMap map = SiteMap;
					map.UrlCreator = UrlCreator;
					manager.Remove(map);
					map.Save();
				}
			}
		}
		
		/// <summary>
		/// Enables the projections in the provided module.
		/// </summary>
		/// <param name="module"></param>
		public virtual void EnableModuleProjections(ModuleContext module)
		{
			if (module == null)
				throw new ArgumentNullException("module");
			
			using (LogGroup logGroup = LogGroup.StartDebug("Enabling projections for module: " + module.ModuleID))
			{
				ModuleProjectionsEnabler enabler = new ModuleProjectionsEnabler(ProjectionLoader);
				enabler.Enable(module);
			}
		}
		
		/// <summary>
		/// Enables the parts in the provided module.
		/// </summary>
		/// <param name="module"></param>
		public virtual void EnableModuleParts(ModuleContext module)
		{
			if (module == null)
				throw new ArgumentNullException("module");
			
			using (LogGroup logGroup = LogGroup.StartDebug("Enabling parts for module: " + module.ModuleID))
			{
				ModulePartsEnabler enabler = new ModulePartsEnabler(PartLoader);
				enabler.Enable(module);
			}
		}
		
		/// <summary>
		/// Disables the projections in the provided module.
		/// </summary>
		/// <param name="module"></param>
		public virtual void DisableModuleProjections(ModuleContext module)
		{
			ModuleProjectionsEnabler enabler = new ModuleProjectionsEnabler(ProjectionLoader);
			enabler.Disable(module);
		}
		
		/// <summary>
		/// Disables the parts in the provided module.
		/// </summary>
		/// <param name="module"></param>
		public virtual void DisableModuleParts(ModuleContext module)
		{
			ModulePartsEnabler enabler = new ModulePartsEnabler(PartLoader);
			enabler.Disable(module);
		}
	}
}
