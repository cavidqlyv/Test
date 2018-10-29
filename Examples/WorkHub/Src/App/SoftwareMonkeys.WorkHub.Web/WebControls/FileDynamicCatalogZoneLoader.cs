using System;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using System.Xml;
using System.Web.Caching;
using System.Web;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// 
	/// </summary>
	public class FileDynamicCatalogZoneLoader  : BaseDynamicCatalogZoneLoader
	{
		private string filePath;
		public string FilePath
		{
			get { return filePath;  }
			set { filePath = value; }
		}
		public FileDynamicCatalogZoneLoader()
		{
		}
		
		public FileDynamicCatalogZoneLoader(string path)
		{
			FilePath = path;
		}
		
		
		public override CatalogPart[] LoadCatalogParts()
		{
			List<CatalogPart> list = new List<CatalogPart>();

			GeneralCatalogPart part = new GeneralCatalogPart();
			part.ID = "General";
			part.DataFile = filePath;
			
			
			list.Add(part);
			
			PageCatalogPart pageCatalogPart = new PageCatalogPart();
			pageCatalogPart.ID = "Closed";
			pageCatalogPart.Title = "Closed";
			list.Add(pageCatalogPart);
			
			return list.ToArray();
		}
		
	}
}
