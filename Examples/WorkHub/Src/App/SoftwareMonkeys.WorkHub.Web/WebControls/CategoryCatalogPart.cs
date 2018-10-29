using System;
using System.Web.Caching;
using System.ComponentModel;
using System.Collections.Generic;
using System.Xml;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules;
using SoftwareMonkeys.WorkHub.Web.Modules;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Business;
using System.Collections.Specialized;
using SoftwareMonkeys.WorkHub.Web.Parts;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// Catalog for reading WebParts with a specific category.
	/// </summary>
	public class CategoryCatalogPart : CatalogPart
	{

		XmlDocument document;

		WebPartDescriptionCollection _description;

		Dictionary<string, WebPart> _loadedWebparts;
		
		public string Category
		{
			get {
				if (ViewState["Category"] == null)
					ViewState["Category"] = String.Empty;
				return (string)ViewState["Category"];
			}
			set { ViewState["Category"] = value; }
		}



		///

		/// Overrides the Title to display Xml Catalog Part by default

		///

		public override string Title
		{

			get
			{
				// TODO: Clean up
				string title = base.Title;

				return Category;//string.IsNullOrEmpty(title) ? "Module Parts Catalog" : title;

			}

			set
			{

				base.Title = value;

			}

		}



		///

		/// Specifies the Path for the Xml File that contains the declaration of the WebParts,

		///     more specifically the WebPartDescriptions

		///

		[

			UrlProperty(),

			DefaultValue("")]

		public string DataFile
		{

			get
			{

				object o = ViewState["DataFile"];

				return o == null ? "" : (string)o;

			}

			set
			{

				ViewState["DataFile"] = value;

			}

		}



		///

		/// Creates a new instance of the class

		///

		public CategoryCatalogPart()
		{



		}





		///

		/// Returns the WebPartDescriptions

		///

		public override WebPartDescriptionCollection GetAvailableWebPartDescriptions()
		{

			if (this.DesignMode)
			{

				return new WebPartDescriptionCollection(new object[] {

				                                        	new WebPartDescription("1", "Xml WebPart 1", String.Empty, String.Empty),

				                                        	new WebPartDescription("2", "Xml WebPart 2", String.Empty, String.Empty),

				                                        	new WebPartDescription("3", "Xml WebPart 3", String.Empty, String.Empty)});

			}



			if (_description == null)

				this.GetWebParts();



			return this._description;

		}





		private void GetWebParts()
		{

			List<WebPartDescription> list = new List<WebPartDescription>();

			this._loadedWebparts = new Dictionary<string, WebPart>();
			
			foreach (PartInfo webPartInfo in PartState.Parts)
			{
				if (webPartInfo.Enabled)
				{
					if (IsInCategory(webPartInfo))
					{
						
						WebPart webPart = (WebPart)webPartInfo.Load(Page, this.WebPartManager);
						
						if ((webPart != null) && ((base.WebPartManager == null) || base.WebPartManager.IsAuthorized(webPart)))
						{

							WebPartDescription description = new WebPartDescription(webPart);

							list.Add(description);

							try
							{
								this._loadedWebparts.Add(description.ID, webPart);
							}
							catch (ArgumentException ex)
							{
								if (ex.Message == "An item with the same key has already been added.")
								{
									throw new Exception("The part ID of '" + description.ID + "' is already in the list.");
								}
							}

						}
					}
				}
			}
			
			// TODO: Remove if not needed
			/*
			if (ModuleState.IsEnabled(ModuleID))
			{
				ModuleCatalogPart catalogPart = new ModuleCatalogPart();
				
				ModuleContext module = ModuleState.Modules[ModuleID];
				
				foreach (ModulePartConfig part in module.Config.Parts)
				{
					WebPart webPart = CreateWebPart(module, part);

					if ((webPart != null) && ((base.WebPartManager == null) || base.WebPartManager.IsAuthorized(webPart)))
					{

						WebPartDescription description = new WebPartDescription(webPart);

						list.Add(description);

						this._loadedWebparts.Add(description.ID, webPart);

					}
					
				}
			}*/
			
			

			
			this._description = new WebPartDescriptionCollection(list);

		}

		public bool IsInCategory(PartInfo part)
		{
			return part.MenuCategory == Category;
		}
		
		public String GetModuleID(PartInfo info)
		{
			return ModuleWebUtilities.GetModuleID(info);
		}


		// TODO: Remove if not needed
		/*private WebPart CreateWebPart(ModuleContext module, ModulePartConfig partConfig)
		{
			WebPart webPart = null;

			if (partConfig.ID == Guid.Empty)
				partConfig.ID = Guid.NewGuid();

			string webPartPath = CreateWebPartPath(module, partConfig);//element.GetAttribute("type");

			string webpartId = partConfig.ID.ToString();//moduleConfig.Name + "." + partConfig.ControlID;



			//if (webPartType.LastIndexOf(".ascx") > 0)
			//{

			Control control = this.Page.LoadControl(webPartPath);

			control.ID = webpartId;



			if (base.WebPartManager != null)

				webPart = base.WebPartManager.CreateWebPart(control);

			//}

			//else
			//{

			//    Type type = Type.GetType(webPartType);

			//    webPart = Activator.CreateInstance(type, null) as WebPart;

			//}



			webPart.ID = webpartId;

			webPart.Title = partConfig.Title;// element.GetAttribute("title");

			// TODO: Enable image URL and auth filter
			//webPart.CatalogIconImageUrl = element.GetAttribute("imageUrl");

			// TODO: Add support for authorization filter
			//webPart.AuthorizationFilter = element.GetAttribute("authorizationFilter");

			return webPart;
		}*/

		private WebPart CreateWebPart(XmlElement element)
		{
			WebPart webPart = null;

			//if (partConfig.ID == Guid.Empty)
			//    partConfig.ID = Guid.NewGuid();

			string webPartPath = CreateWebPartPath(element.GetAttribute("Path"));

			string webpartId = element.GetAttribute("ControlID");



			//if (webPartType.LastIndexOf(".ascx") > 0)
			//{

			Control control = this.Page.LoadControl(webPartPath);

			control.ID = webpartId;



			if (base.WebPartManager != null)

				webPart = base.WebPartManager.CreateWebPart(control);

			//}

			//else
			//{

			//    Type type = Type.GetType(webPartType);

			//    webPart = Activator.CreateInstance(type, null) as WebPart;

			//}



			webPart.ID = webpartId;

			webPart.Title = element.GetAttribute("Title");

			// TODO: Enable image URL and auth filter
			//webPart.CatalogIconImageUrl = element.GetAttribute("imageUrl");

			// TODO: Add support for authorization filter
			//webPart.AuthorizationFilter = element.GetAttribute("authorizationFilter");

			return webPart;
		}

		// TODO: Remove if not needed
		/*private string CreateWebPartPath(ModuleContext module, ModulePartConfig part)
		{
			return Config.Application.ApplicationPath + "/Modules/" + module.ModuleID + "/Parts/" + part.ControlID + ".ascx";
		}*/


		private string CreateWebPartPath(string partPath)
		{
			if (partPath.IndexOf("~") == 0)
				return Config.Application.ApplicationPath.TrimEnd('/') + partPath.TrimStart('~');
			else
				return partPath;
		}

		// TODO: Remove if not needed
		/*private WebPart CreateWebPartFromElement(XmlElement element)
        {

            WebPart webPart = null;



            string webPartType = element.GetAttribute("type");

            string webpartId = element.GetAttribute("id");



            if (webPartType.LastIndexOf(".ascx") > 0)
            {

                Control control = this.Page.LoadControl(webPartType);

                control.ID = webpartId;



                if (base.WebPartManager != null)

                    webPart = base.WebPartManager.CreateWebPart(control);

            }

            else
            {

                Type type = Type.GetType(webPartType);

                webPart = Activator.CreateInstance(type, null) as WebPart;

            }



            webPart.ID = webpartId;

            webPart.Title = element.GetAttribute("title");

            webPart.CatalogIconImageUrl = element.GetAttribute("imageUrl");

            webPart.AuthorizationFilter = element.GetAttribute("authorizationFilter");



            return webPart;

        }*/







		///

		/// Returns a new instance of the WebPart specified by the description

		///

		public override WebPart GetWebPart(WebPartDescription description)
		{
			if (description == null)
				throw new ArgumentNullException("description");

			if (this._loadedWebparts == null)

				this.GetWebParts();



			return this._loadedWebparts[description.ID];

		}




		
		protected override void RenderContents(HtmlTextWriter writer)
		{
		}
	}
}