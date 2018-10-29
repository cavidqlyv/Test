using System;
using SoftwareMonkeys.WorkHub.Web;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Projections;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Web
{
	/// <summary>
	/// Used to add planning menu items to the site map.
	/// </summary>
	public class PlanningSiteMapManager : SiteMapManager
	{
		public PlanningSiteMapManager()
		{
		}
		
		/// <summary>
		/// Retrieves the site map items that this manager is responsible for adding/removing.
		/// </summary>
		/// <returns></returns>
		public override ISiteMapNode[] GetSiteMapItems()
		{
			List<ISiteMapNode> list = new List<ISiteMapNode>();
			
			// TODO: Load info from menu properties on actual projections
			list.Add(new SiteMapNode(ProjectionState.Projections["PlanningGuide"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["PlanningOverview"]));
			list.Add(new SiteMapNode(ProjectionState.Projections["Index", "Goal"]));
			list.Add(new SiteMapNode("Planning/Requirements", "Scenarios", "Index", "Scenario"));
			list.Add(new SiteMapNode("Planning/Requirements", "Features", "Index", "Feature"));
			list.Add(new SiteMapNode("Planning/Requirements", "Actors", "Index", "Actor"));
			list.Add(new SiteMapNode("Planning/Requirements", "Actions", "Index", "Action"));
			list.Add(new SiteMapNode("Planning/Requirements", "Entities", "Index", "ProjectEntity"));
			list.Add(new SiteMapNode("Planning/Requirements", "Restraints", "Index", "Restraint"));
			
			return list.ToArray();
		}
	}
}
