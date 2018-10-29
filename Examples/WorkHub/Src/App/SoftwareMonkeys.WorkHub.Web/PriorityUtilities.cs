using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.Properties;

namespace SoftwareMonkeys.WorkHub.Web
{
	/// <summary>
	/// Description of PriorityUtilities.
	/// </summary>
	public class PriorityUtilities
	{
		
		static public string GetPriorityText(Priority priority)
		{
			return GetPriorityText(priority, true);
		}
		
		static public string GetPriorityText(Priority priority, bool allowHtml)
		{
			string output = Language.NotSet;
			
			string cssClass = priority.ToString();
			
			switch (priority)
			{
				case Priority.Extreme:
					output = Language.Extreme;
					break;
				case Priority.High:
					output = Language.High;
					break;
				case Priority.Moderate:
					output = Language.Moderate;
					break;
				case Priority.Low:
					output = Language.Low;
					break;
				case Priority.VeryLow:
					output = Language.VeryLow;
					break;
			}
			
			if (allowHtml)
				output  = "<span class='" + cssClass + "'>" + output + "</span>";
			
			return output;
		}
	}
}
