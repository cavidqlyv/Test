using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace SoftwareMonkeys.WorkHub.Web
{
	public class BasePage : Page
	{
		private bool autoExecute = true;
		public bool AutoExecute
		{
			get { return autoExecute; }
			set { autoExecute = value; }
		}
		
		public bool RenderAsXml = false;
		
		private Navigation.Navigator navigator;
		public Navigation.Navigator Navigator
		{
			get {
				if (navigator == null)
					navigator = new Navigation.Navigator(this);
				return navigator;
			}
			set { navigator = value; }
		}

		public Control XmlControl = null;

		/// <summary>
		/// Gets/sets the title displayed in the window.
		/// </summary>
		public string WindowTitle
		{
			get
			{
				if (Context == null)
					return String.Empty;
				if (Context.Items["WindowTitle"] == null)
					Context.Items["WindowTitle"] = "WorkHub";
				return (string)Context.Items["WindowTitle"];
			}
			set { Context.Items["WindowTitle"] = value; }
		}
		
		protected override void OnInit(EventArgs e)
		{
			if (Request != null && Request.ServerVariables["http_user_agent"] != null)
			{
				// This is necessary because Safari and Chrome browsers don't display the Menu control correctly.
				// All webpages displaying an ASP.NET menu control must inherit this class.
				if (Request.ServerVariables["http_user_agent"].IndexOf("Safari", StringComparison.CurrentCultureIgnoreCase) != -1)
					Page.ClientTarget = "uplevel";
			}
			
			base.OnInit(e);
		}
		
	}
}