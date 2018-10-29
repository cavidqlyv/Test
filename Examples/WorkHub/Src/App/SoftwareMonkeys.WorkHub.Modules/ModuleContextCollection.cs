using System;
using System.Collections.Generic;
using System.Collections;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Modules
{
	/// <summary>
	/// Holds a collection of module contexts.
	/// </summary>
	public class ModuleContextCollection : ArrayList
	{
		private ModuleLoader loader;
		/// <summary>
		/// Gets/sets the loader used to load module contexts as needed.
		/// </summary>
		public ModuleLoader Loader
		{
			get {
				if (loader == null)
					loader = new ModuleLoader();
				return loader; }
			set { loader = value; }
		}
		
		/// <summary>
		/// Gets the module context for the module with the provided ID.
		/// </summary>
		public ModuleContext this[string moduleID]
		{
			get { return GetByID(moduleID); }
		}
		
		/// <summary>
		/// Retrieves the module context for the module with the provided ID.
		/// </summary>
		/// <param name="moduleID">The ID of the module to retrieve the context for.</param>
		/// <returns>The module context retrieved for the specified ID.</returns>
		public ModuleContext GetByID(string moduleID)
		{
			ModuleContext returnContext = null;
			
			using (LogGroup logGroup = LogGroup.Start("Retrieving module with the ID '" + moduleID + "'.", NLog.LogLevel.Debug))
			{
				if (moduleID == String.Empty)
					throw new ArgumentException("The moduleID cannot be String.Empty.", "moduleID");
				
				// Try getting it from the list
				foreach (ModuleContext context in this)
				{
					LogWriter.Debug("Checking '" + context.ModuleID + "' vs. '" + moduleID + "'.");
					
					if (context.ModuleID == moduleID)
					{
						LogWriter.Debug("Does match");
						returnContext = context;
					}
					else
						LogWriter.Debug("Doesn't match");
				}
			}
			return returnContext;
		}
		
		/// <summary>
		/// Checks whether the collection contains the module with the specified ID.
		/// </summary>
		/// <param name="moduleID">The ID of the module to look for in the collection.</param>
		/// <returns>A boolean value indicating whether the module with the specified ID was found in the collection.</returns>
		public bool Contains(string moduleID)
		{
			bool doesContain = false;
			using (LogGroup logGroup = LogGroup.StartDebug("Checking whether the collection currently contains the module '" + moduleID + "'."))
			{
				
				doesContain = GetByID(moduleID) != null;
				
				LogWriter.Debug("Does contain: " + doesContain.ToString());
			}
			
			return doesContain;
		}
		
		public override int Add(object value)
		{
			Add((ModuleContext)value);
			
			return 0;
		}
	
		/// <summary>
		/// Adds the provide module to the collection.
		/// </summary>
		/// <param name="module">The module context to add to the collection.</param>
		public void Add(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Adding the provide module to the collection.", NLog.LogLevel.Debug))
			{
				module.InitializeEventHandlers();
				
				LogWriter.Debug("Module ID: " + module.ModuleID);
				
				base.Add(module);
				CommitToState();
			}
		}
		
		public override void Remove(object context)
		{
			Remove((ModuleContext)context);
		}
		
		/// <summary>
		/// Removes the module at the specified index from the collection.
		/// </summary>
		/// <param name="index">The index of the module to remove.</param>
		public override void RemoveAt(int index)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the module at the specified position from the collection.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Index: " + index);
				
				base.RemoveAt(index);
				CommitToState();
			}
		}
		
		
		/// <summary>
		/// Removes the provided module from the collection.
		/// </summary>
		/// <param name="module"></param>
		public void Remove(ModuleContext module)
		{
			using (LogGroup logGroup = LogGroup.Start("Removing the provided module from the collection.", NLog.LogLevel.Debug))
			{
				LogWriter.Debug("Module ID: " + module.ModuleID);
				
				base.Remove(module);
				CommitToState();
			}
		}
		
		/// <summary>
		/// Commits the collection to state.
		/// </summary>
		public void CommitToState()
		{
			using (LogGroup logGroup = LogGroup.Start("Committing the collection to state.", NLog.LogLevel.Debug))
			{
				ModuleState.Modules = this;
			}
		}
		
		public void InitializeEventHandlers()
		{
			using (LogGroup logGroup = LogGroup.Start("Initializing the event handlers on the collection of modules contexts.", NLog.LogLevel.Debug))
			{
				foreach (ModuleContext module in this)
				{
					module.InitializeEventHandlers();
				}
			}
		}
		
		
		/// <summary>
		/// Handles the provided event and triggers the appropriate business functions.
		/// </summary>
		/// <param name="ev">The event to handle.</param>
		public void HandleEvent(IEntityEvent ev)
		{
			foreach (IModuleContext context in this)
			{
				context.HandleEvent(ev);
			}
		}
	}
}
