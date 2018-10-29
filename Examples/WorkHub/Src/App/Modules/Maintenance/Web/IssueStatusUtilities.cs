using System;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web
{
	public class IssueStatusUtilities
	{
		static public string GetStatusText(IssueStatus status)
		{
			return GetStatusText(status, true);
		}
		
		static public string GetStatusText(IssueStatus status, bool allowHtml)
		{
			string output = String.Empty;
			
			switch (status)
			{
				case IssueStatus.Pending:
					output = Language.Pending;
					break;
				case IssueStatus.Resolved:
					output = Language.Resolved;
					break;
				case IssueStatus.Closed:
					output = Language.Closed;
					break;
			}
			
			if (allowHtml)
				output = "<span class='" + status.ToString() + "'>" + output + "</span>";
			
			return output;
		}
	}
}
