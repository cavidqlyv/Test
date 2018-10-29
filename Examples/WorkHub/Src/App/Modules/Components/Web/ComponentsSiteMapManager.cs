using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Components.Web
{
	/// <summary>
	/// Used to add components module menu items to the site map.
	/// </summary>
	public class ComponentsSiteMapManager : SiteMapManager
	{
		public ComponentsSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Component"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "ComponentType"]));
			
			return list.ToArray();
		}
	}
}
