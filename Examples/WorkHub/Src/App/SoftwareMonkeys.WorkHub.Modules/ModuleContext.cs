using System;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules
{
	/// <summary>
	/// The base of all module context components.
	/// </summary>
	public abstract class ModuleContext : BaseEntity, IModuleContext
	{
		private string moduleID;
		/// <summary>
		/// Gets/sets the ID of the module.
		/// </summary>
		public string ModuleID
		{
			get { return moduleID; }
			set { moduleID = value; }
		}
		
		private IModuleConfig config;
		/// <summary>
		/// Gets/sets the module configuration component.
		/// </summary>
		public IModuleConfig Config
		{
			get { return config; }
			set { config = value; }
		}
		
		public new string ShortTypeName
		{
			get { return "Module"; }
		}
		
		[Obsolete]
		public virtual event EntityEventHandler EntitySaved;
		[Obsolete]
		public virtual event EntityEventHandler EntityUpdated;
		[Obsolete]
		public virtual event EntityEventHandler EntityDeleted;
		
		public abstract void Enable();
		public abstract void Disable();
		
		/// <summary>
		/// Raises the EntitySaved event.
		/// </summary>
		/// <param name="entity">The entity that was saved.</param>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		[Obsolete]
		public void RaiseEntitySaved(IEntity entity)
		{
			if (EntitySaved != null)
				EntitySaved(null, new EntityEventArgs(entity));
		}
		
		/// <summary>
		/// Raises the EntityUpdated event.
		/// </summary>
		/// <param name="entity">The entity that was updated.</param>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		public void RaiseEntityUpdated(IEntity entity)
		{
			if (EntityUpdated != null)
				EntityUpdated(null, new EntityEventArgs(entity));
		}
		
		/// <summary>
		/// Raises the EntityDeleted event.
		/// </summary>
		/// <param name="entity">The entity that was deleted.</param>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		[Obsolete]
		public void RaiseEntityDeleted(IEntity entity)
		{
			using (LogGroup logGroup = LogGroup.Start("Raising the entity deleted event.", NLog.LogLevel.Debug))
			{
				if (EntityDeleted != null)
				{
					LogWriter.Debug("Firing.");
					EntityDeleted(null, new EntityEventArgs(entity));
				}
				else
					LogWriter.Debug("EntityDeleted == null. Not firing.");
			}
		}
		
		
		/// <summary>
		/// Initializes the event management between modules.
		/// </summary>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		[Obsolete]
		public virtual void InitializeEventHandlers()
		{
			
		}
		
		/// <summary>
		/// Initializes the event management between modules.
		/// </summary>
		/// <param name="module">The module to initialize the events of.</param>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		[Obsolete]
		public virtual void InitializeEventHandlers(ModuleContext module)
		{
			
		}
		
		/// <summary>
		/// Handles the provided event and triggers the appropriate business functions.
		/// </summary>
		/// <param name="ev">The entity event to handle.</param>
		// TODO: Check if needed. Should be obsolete now that reactions can be used
		[Obsolete]
		public virtual void HandleEvent(IEntityEvent ev)
		{
			
		}
		
		public virtual ISiteMapManager GetSiteMapManager()
		{
			return null;
			//throw new NotImplementedException();
		}
	}
}
