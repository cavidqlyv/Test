using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Web.Parts;
using SoftwareMonkeys.WorkHub.Web.Properties;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// 
	/// </summary>
	public class DynamicCatalogZoneLoader : BaseDynamicCatalogZoneLoader
	{
		public DynamicCatalogZoneLoader()
		{
		}
		
		public override CatalogPart[] LoadCatalogParts()
		{
			List<CatalogPart> list = new List<CatalogPart>();
			List<string> categories = new List<string>();
			
			// Get a list of the categories
			if (PartState.IsInitialized && PartState.Parts != null)
			{
				foreach (PartInfo part in PartState.Parts)
				{
					if (part != null)
					{
						if (part.MenuCategory != null && part.MenuCategory != String.Empty)
						{
							if (!categories.Contains(part.MenuCategory))
								categories.Add(part.MenuCategory);
						}
					}
				}
				
				// Turn the categories into catalog parts
				foreach (string category in categories)
				{
					CategoryCatalogPart part = new CategoryCatalogPart();
					part.Category = category;
					part.ID = category;
					
					list.Add(part);
				}
			}
			
			PageCatalogPart pageCatalogPart = new PageCatalogPart();
			pageCatalogPart.ID = "Closed";
			pageCatalogPart.Title = Language.Closed;
			list.Add(pageCatalogPart);
			
			return list.ToArray();
		}
	}
}
