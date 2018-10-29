using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Business;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Web;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Web;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks
{
	/// <summary>
	/// 
	/// </summary>
	[Entity("TasksModuleContext")]
	public class TasksModuleContext : ModuleContext
	{

        public override void Enable()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling module: "+ Config.Name, NLog.LogLevel.Debug))
			{
				EnableDependencies();
				
			}
		}

        public override void Disable()
		{
			
		}
	
		
		/// <summary>
		/// Enables any modules that this module depends on.
		/// </summary>
		public void EnableDependencies()
		{
			using (LogGroup logGroup = LogGroup.Start("Enabling the dependencies of the module.", NLog.LogLevel.Debug))
			{
				if (!ModuleState.IsEnabled("Projects"))
					ModuleState.Enable("Projects");
			}
		}
		
		/// <summary>
		/// Handles the provided event and triggers the appropriate business functions.
		/// </summary>
		/// <param name="ev">The entity event to handle.</param>
		public override void HandleEvent(IEntityEvent ev)
		{
			if (ev.Entity.ShortTypeName == "Project")
			{
				if (ev.EventName == "Deleted")
				{
					HandleProjectDeleted(ev.Entity.ID);
				}
			}
		}
		
		/// <summary>
		/// Handles the project deleted event and triggers the appropriate business functions.
		/// </summary>
		/// <param name="projectID">The ID of the project that was deleted.</param>
		public void HandleProjectDeleted(Guid projectID)
		{
			foreach (Suggestion suggestion in IndexStrategy.New<Suggestion>().IndexWithReference<Suggestion>("Project", "Project", projectID))
				DeleteStrategy.New<Suggestion>().Delete(suggestion);
			
			foreach (Task task in IndexStrategy.New<Task>().IndexWithReference<Task>("Project", "Project", projectID))
				DeleteStrategy.New<Task>().Delete(task);
			
			foreach (Milestone milestone in IndexStrategy.New<Milestone>().IndexWithReference<Milestone>("Project", "Project", projectID))
				DeleteStrategy.New<Milestone>().Delete(milestone);
		}
		
		public override ISiteMapManager GetSiteMapManager()
		{
			return new TasksSiteMapManager();
		}
	}
}
