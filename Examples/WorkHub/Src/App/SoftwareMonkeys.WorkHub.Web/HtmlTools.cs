using System;
using System.Web;
using System.Text.RegularExpressions;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Description of HtmlTools.
	/// </summary>
	public class HtmlTools
	{
		static public string FormatText(string text)
		{
			string output = text;
			output = HttpContext.Current.Server.HtmlEncode(output);
			output = output.Replace("\r\n", "\n").Replace("\n", "<br/>"); // Two replace calls are made so both \r\n AND \n on its own will be replaced with <br/>
			
			return output;
		}
		
		

        /// <summary>
        /// Strips all the HTML from the provided text.
        /// </summary>
        /// <param name="val">The text to strip HTML from.</param>
        /// <returns>The provided text without any HTML tags.</returns>
        static public string StripHTML(string val)
        {
            return Regex.Replace(val, "<[^>]*>", "");
        }
	}
}
