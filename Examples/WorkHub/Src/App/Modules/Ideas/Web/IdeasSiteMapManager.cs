using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Ideas.Web
{
	/// <summary>
	/// Used to add ideas module menu items to the site map.
	/// </summary>
	public class IdeasSiteMapManager : SiteMapManager
	{
		public IdeasSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["Create", "Idea"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Idea"]));
			
			return list.ToArray();
		}
	}
}
