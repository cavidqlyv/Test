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
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Business;
using System.Collections.Specialized;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// Catalog for reading WebParts from an Xml Document
	/// </summary>
	public class GeneralCatalogPart : CatalogPart
	{

		XmlDocument document;

		WebPartDescriptionCollection _description;

		Dictionary<string, WebPart> _loadedWebparts;
		


		///

		/// Overrides the Title to display Xml Catalog Part by default

		///

		public override string Title
		{

			get
			{
				// TODO: Clean up
				string title = base.Title;

				return "General";//GeneralID;//string.IsNullOrEmpty(title) ? "General Parts Catalog" : title;

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

		public GeneralCatalogPart()
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

			
			// Load the default parts
			XmlDocument document = GetDocument();


			//List<WebPartDescription> list = new List<WebPartDescription>();




			foreach (XmlElement element in document.SelectNodes("/Parts/Part"))
			{

				WebPart webPart = CreateWebPart(element);



				if ((webPart != null) && ((base.WebPartManager == null) || base.WebPartManager.IsAuthorized(webPart)))
				{

					WebPartDescription description = new WebPartDescription(webPart);



					list.Add(description);

					this._loadedWebparts.Add(description.ID, webPart);

				}

			}

			
			

			
			this._description = new WebPartDescriptionCollection(list);

		}



		/*private WebPart CreateWebPart(GeneralContext module, GeneralPartConfig partConfig)
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

		//private string CreateWebPartPath(GeneralContext module, GeneralPartConfig part)
		//{
		//	return Config.Application.ApplicationPath + "/Generals/" + module.GeneralID + "/Parts/" + part.ControlID + ".ascx";
		//}


		private string CreateWebPartPath(string partPath)
		{
			if (partPath.IndexOf("~") == 0)
				return Config.Application.ApplicationPath.TrimEnd('/') + partPath.TrimStart('~');
			else
				return partPath;
		}

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




		///

		/// private function to load the document and cache it

		///

		private XmlDocument GetDocument()
		{
			string file = HttpContext.Current.Server.MapPath(this.DataFile);

			string key = "__xmlCatalog:" + file.ToLower();

			XmlDocument document = HttpContext.Current.Cache[key] as XmlDocument;

			if (document == null)
			{

				using (CacheDependency dependency = new CacheDependency(file))
				{

					document = new XmlDocument();

					document.Load(file);

					Context.Cache.Add(key, document, dependency,

					                  Cache.NoAbsoluteExpiration, Cache.NoSlidingExpiration, CacheItemPriority.Normal, null);

				}

			}

			return document;

		}

		
		protected override void RenderContents(HtmlTextWriter writer)
		{
		}
	}
}