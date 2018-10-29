using System;
using System.Web;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Web.Navigation
{
	/// <summary>
	///
	/// </summary>
	public class ExternalNavigator
	{
		public ExternalNavigator()
		{
		}
		
		private ExternalUrlCreator current;
		/// <summary>
		/// Gets/sets the external URL creator used to create URLs.
		/// </summary>
		public ExternalUrlCreator Current
		{
			get {
				if (current == null)
					current = new ExternalUrlCreator();
				return current; }
			set { current = value; }
		}
		
		
		public string GetExternalLink(string action, IEntity entity)
		{
			return new ExternalUrlCreator(
				HttpContext.Current.Request.ApplicationPath,
				HttpContext.Current.Request.Url.ToString()
				)
				.CreateExternalUrl(
					action,
					entity
				);
		}
		
		public string GetExternalLink(string action, string type)
		{
			return new ExternalUrlCreator(
				HttpContext.Current.Request.ApplicationPath,
				HttpContext.Current.Request.Url.ToString()
				)
				.CreateExternalUrl(
					action,
					type
				);
		}
		
		public string GetExternalLink(string action, string type, string propertyName, string value)
		{
			return new ExternalUrlCreator(
				HttpContext.Current.Request.ApplicationPath,
				HttpContext.Current.Request.Url.ToString()
				)
				.CreateExternalUrl(action, type, propertyName, value);
		}
		
		
	}
}
