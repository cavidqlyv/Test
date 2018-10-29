using SoftwareMonkeys.WorkHub.Web.Properties;
using System;
using System.Reflection;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Description of LanguageHelper.
	/// </summary>
	public class LanguageHelper
	{
		public LanguageHelper()
		{
			
		}
			public string GetString(string key)
			{
				return Language.ResourceManager.GetString(key);
			}
	}
}
