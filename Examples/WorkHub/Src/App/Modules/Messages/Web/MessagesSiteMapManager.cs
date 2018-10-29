using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Web
{
	/// <summary>
	/// Used to add s module menu items to the site map.
	/// </summary>
	public class MessagesSiteMapManager : SiteMapManager
	{
		public MessagesSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			list.Add(new SiteMapNode(ProjectionState.Projections["Create", "Message"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Message"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["IndexSent", "Message"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Discussions"]));
			
			return list.ToArray();
		}
	}
}
