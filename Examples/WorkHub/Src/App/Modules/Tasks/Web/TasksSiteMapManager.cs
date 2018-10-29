using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Projections;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web
{
	/// <summary>
	/// Used to add tasks module menu items to the site map.
	/// </summary>
	public class TasksSiteMapManager : SiteMapManager
	{
		public TasksSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["RoadmapGuide"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Roadmap"]));
			list.Add(new SiteMapNode("Development", "Milestones", "Index", "Milestone"));
			list.Add(new SiteMapNode("Development", "Tasks", "Index", "Task"));
			list.Add(new SiteMapNode("Feedback", "Suggestions", "Index", "Suggestion"));
			
			return list.ToArray();
		}
	}
}
