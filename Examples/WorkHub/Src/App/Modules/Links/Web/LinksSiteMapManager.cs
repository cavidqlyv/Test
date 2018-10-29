using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Links.Web
{
	/// <summary>
	/// Used to add links module menu items to the site map.
	/// </summary>
	public class LinksSiteMapManager : SiteMapManager
	{
		public LinksSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Link"]));
			
			return list.ToArray();
		}
	}
}
