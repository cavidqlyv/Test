
using System;
using System.Web.UI.WebControls.WebParts;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// 
	/// </summary>
	public abstract class BaseDynamicCatalogZoneLoader
	{
		public BaseDynamicCatalogZoneLoader()
		{
		}
		
		public abstract CatalogPart[] LoadCatalogParts();
	}
}
