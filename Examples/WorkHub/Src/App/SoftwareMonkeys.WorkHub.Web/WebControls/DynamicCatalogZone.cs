using System;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// 
	/// </summary>
	public class DynamicCatalogZone : CatalogZoneBase
	{
		public DynamicCatalogZone()
		{
		}
		
		protected override void OnInit(EventArgs e)
		{
			
			base.OnInit(e);
		}
		
		protected override void OnLoad(EventArgs e)
		{
			
			base.OnLoad(e);
		}
		
		protected override bool LoadPostData(string postDataKey, System.Collections.Specialized.NameValueCollection postCollection)
		{
			
			bool posted = base.LoadPostData(postDataKey, postCollection);
			
			
			return posted;
		}
		
		protected override CatalogPartCollection CreateCatalogParts()
		{
			List<CatalogPart> list = new List<CatalogPart>();
			
			foreach (BaseDynamicCatalogZoneLoader loader in GetLoaders())
			{
				foreach (CatalogPart part in loader.LoadCatalogParts())
				{					
					list.Add(part);
				}
			}
				
			return new CatalogPartCollection(list.ToArray());
		}
		
		protected BaseDynamicCatalogZoneLoader[] GetLoaders()
		{
			return new BaseDynamicCatalogZoneLoader[]
			{
				new DynamicCatalogZoneLoader()
			};
		}
	}
}
