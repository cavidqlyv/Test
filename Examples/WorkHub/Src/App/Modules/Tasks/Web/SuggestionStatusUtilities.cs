using System;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Properties;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web
{
	public class SuggestionStatusUtilities
	{
		static public string GetStatusText(SuggestionStatus status)
		{
			return GetStatusText(status, true);
		}
		
		static public string GetStatusText(SuggestionStatus status, bool allowHtml)
		{
			string output = String.Empty;
			
			switch (status)
			{
				case SuggestionStatus.Pending:
					output = Language.Pending;
					break;
				case SuggestionStatus.Accepted:
					output = Language.Accepted;
					break;
				case SuggestionStatus.Implemented:
					output = Language.Implemented;
					break;
			}
			
			if (allowHtml)
				output = "<span class='" + status.ToString() + "'>" + output + "</span>";
			
			return output;
		}
	}
}
