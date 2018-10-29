using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web
{
	/// <summary>
	/// Used to add projects module menu items to the site map.
	/// </summary>
	public class ProjectsSiteMapManager : SiteMapManager
	{
		public ProjectsSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["ProjectsGuide"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Create", "Project"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Project"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["View", "Project"]));
			
			return list.ToArray();
		}
	}
}
