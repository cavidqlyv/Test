using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Web.State;
using System.Web;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// 
	/// </summary>
	public class ExternalUrlCreator
	{

		private string applicationPath;
		/// <summary>
		/// Gets/sets the relative path to the root of the application.
		/// </summary>
		public string ApplicationPath
		{
			get { return applicationPath; }
			set { applicationPath = value; }
		}
		
		private string currentUrl;
		/// <summary>
		/// Gets/sets the URL of the current request.
		/// </summary>
		public string CurrentUrl
		{
			get { return currentUrl; }
			set { currentUrl = value; }
		}
		
		private bool enableFriendlyUrls = true;
		/// <summary>
		/// Gest/sets a value indicating whether friendly URLs are enabled. (Using URL rewriting behind the scenes.)
		/// </summary>
		public bool EnableFriendlyUrls
		{
			get { return enableFriendlyUrls; }
			set { enableFriendlyUrls = value; }
		}
		
		private UrlConverter converter;
		public UrlConverter Converter
		{
			get {
				if (converter == null)
					converter = new UrlConverter();
				return converter; }
			set { converter = value; }
		}
		
		/// <summary>
		/// Sets the provided application path.
		/// </summary>
		/// <param name="applicationPath">The relative path to the root of the application.</param>
		/// <param name="currentUrl">The URL of the current request.</param>
		public ExternalUrlCreator(string applicationPath, string currentUrl)
		{
			Initialize(applicationPath,
			           new UrlCreator(applicationPath, currentUrl).GetEnableFriendlyUrlsSetting(),
			           currentUrl);
		}
		
		/// <summary>
		/// Sets the provided application path.
		/// </summary>
		/// <param name="applicationPath">The relative path to the root of the application.</param>
		/// <param name="currentUrl">The URL of the current request.</param>
		public ExternalUrlCreator(string applicationPath, bool enableFriendlyUrls, string currentUrl)
		{
			Initialize(applicationPath,
			           new UrlCreator(applicationPath, enableFriendlyUrls, currentUrl).GetEnableFriendlyUrlsSetting(),
			           currentUrl);
		}
		
		public ExternalUrlCreator()
		{
			Initialize();
		}
		
		public virtual void Initialize()
		{
			Initialize(
				HttpContext.Current.Request.ApplicationPath,
				new UrlCreator(
					HttpContext.Current.Request.ApplicationPath,
					HttpContext.Current.Request.Url.ToString()
				).GetEnableFriendlyUrlsSetting(),
				HttpContext.Current.Request.Url.ToString()
			);
		}
		
		public virtual void Initialize(string applicationPath, bool enableFriendlyUrls, string currentUrl)
		{
			ApplicationPath = applicationPath;
			EnableFriendlyUrls = enableFriendlyUrls;
			CurrentUrl = currentUrl;
		}
		
		#region External URL functions
		/// <summary>
		/// Creates an external URL to the provided action and type.
		/// </summary>
		/// <param name="action">The action to be performed by following the URL.</param>
		/// <param name="type">The type that the specified action is dealing with.</param>
		/// <returns>The external URL to the specified action and specified type.</returns>
		public string CreateExternalUrl(string action, string type)
		{
			UrlCreator creator = new UrlCreator(ApplicationPath, EnableFriendlyUrls, CurrentUrl);
			
			string url = creator.CreateFriendlyUrl(action, type);
			
			url = AddStateValues(url);
			
			if (url.IndexOf(":") == -1)
			{
				
				url = Converter.ToAbsolute(url);
			}
			
			return url;
		}
		
		/// <summary>
		/// Creates an external URL to the provided action and type.
		/// </summary>
		/// <param name="action">The action to be performed by following the URL.</param>
		/// <param name="entity"></param>
		/// <returns>The external URL to the specified action and specified type.</returns>
		public string CreateExternalUrl(string action, IEntity entity)
		{
			UrlCreator creator = new UrlCreator(ApplicationPath, EnableFriendlyUrls, CurrentUrl);
			
			string url = creator.CreateFriendlyUrl(action, entity);
			
			url = AddStateValues(url);

			if (url.IndexOf(":") == -1)
			{
				url = Converter.ToAbsolute(url);
			}
			
			return url;
		}
		
		/// <summary>
		/// Creates an external URL to the provided action and type.
		/// </summary>
		/// <param name="action">The action to be performed by following the URL.</param>
		/// <param name="type">The type that the specified action is dealing with.</param>
		/// <param name="propertyName">The name of the property to filter the specified type by.</param>
		/// <param name="dataKey">The value of the property to filter the specified type by.</param>
		/// <returns>The external URL to the specified action and specified type.</returns>
		public string CreateExternalUrl(string action, string type, string propertyName, string dataKey)
		{
			
			UrlCreator creator = new UrlCreator(ApplicationPath, EnableFriendlyUrls, CurrentUrl);
			
			string url = creator.CreateFriendlyUrl(action, type, propertyName, dataKey);
			
			url = AddStateValues(url);
			
			if (url.IndexOf(":") == -1)
			{
				url = Converter.ToAbsolute(url);
			}
			
			return url;
		}
		
		
		/// <summary>
		/// Creates an external URL to the XML page that handles the specified action and type.
		/// </summary>
		/// <param name="action">The action that is handled by the target page.</param>
		/// <param name="type">The type that the specified action deals with.</param>
		/// <returns>The external URL to the XML file.</returns>
		public string CreateExternalXmlUrl(string action, string type)
		{
			string url = new UrlCreator(ApplicationPath, EnableFriendlyUrls, CurrentUrl).CreateXmlUrl(action, type);
			
			url = AddStateValues(url);

			url = Converter.ToAbsolute(url);
			
			return url;
		}
		
		public string CreateExternalUrl()
		{
			string url = string.Empty;
			
			url = (string)HttpContext.Current.Items["OriginalUrl"];
				
			url = AddStateValues(url);
			
			return url;
		}
		#endregion
		
		public string AddStateValues(string url)
		{
			
			string separator = "?";
			if (url.IndexOf("?") > -1)
				separator = "&";
			
			bool projectIDAlreadyFound = url.IndexOf("?ProjectID=") > -1
				|| url.IndexOf("&ProjectID=") > -1
				|| url.IndexOf("?CurrentProjectID=") > -1
				|| url.IndexOf("&CurrentProjectID=") > -1;
			
			bool typeIsProject = QueryStrings.Type == "Project";
			
			if (ProjectsState.IsEnabled
			    && ProjectsState.ProjectSelected
			   	&& !projectIDAlreadyFound
				&& !typeIsProject)
			{
				url = url + separator + "ProjectID=" + ProjectsState.ProjectID.ToString();
			}
			
			return url;
		}
		
		public string PrepareForUrl(string original)
		{
			return new UrlCreator(ApplicationPath, EnableFriendlyUrls, CurrentUrl).PrepareForUrl(original);
		}
	}
}
