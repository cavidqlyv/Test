using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Projections;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web
{
	/// <summary>
	/// Used to add maintenance module menu items to the site map.
	/// </summary>
	public class MaintenanceSiteMapManager : SiteMapManager
	{
		public MaintenanceSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["Report", "Issue"]));
			list.Add(new SiteMapNode("Support", "Issues", "Index", "Issue"));
			list.Add(new SiteMapNode(ProjectionState.Projections["MaintenanceGuide"]));
			list.Add(new SiteMapNode("Maintenance", "Bugs", "Index", "Bug"));
			list.Add(new SiteMapNode("Maintenance", "Solutions", "Index", "Solution"));
			
			return list.ToArray();
		}
	}
}
