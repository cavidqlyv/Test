using System;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web
{
	public class BugStatusUtilities
	{
		static public string GetStatusText(BugStatus status)
		{
			return GetStatusText(status, true);
		}
		
		static public string GetStatusText(BugStatus status, bool allowHtml)
		{
			string output = String.Empty;
			
			switch (status)
			{
				case BugStatus.Pending:
					output = Language.Pending;
					break;
				case BugStatus.InProgress:
					output = Language.InProgress;
					break;
				case BugStatus.OnHold:
					output = Language.OnHold;
					break;
				case BugStatus.Fixed:
					output = Language.Fixed;
					break;
				case BugStatus.Tested:
					output = Language.Tested;
					break;
			}
			
			if (allowHtml)
				output = "<span class='" + status.ToString() + "'>" + output + "</span>";
			
			return output;
		}
	}
}
