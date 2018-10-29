using System;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Properties;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web
{
	/// <summary>
	/// Description of TaskStatusUtilities.
	/// </summary>
	public class TaskStatusUtilities
	{
		static public string GetStatusText(TaskStatus status)
		{
			return GetStatusText(status, true);
		}
			
		static public string GetStatusText(TaskStatus status, bool allowHtml)
		{
			string output = String.Empty;
			
			switch (status)
			{
				case TaskStatus.Pending:
					output = Language.Pending;
					break;
				case TaskStatus.OnHold:
					output = Language.OnHold;
					break;
				case TaskStatus.InProgress:
					output = Language.InProgress;
					break;
				case TaskStatus.Completed:
					output = Language.Completed;
					break;
				case TaskStatus.Tested:
					output = Language.Tested;
					break;
			}
			
			if (allowHtml)
				output = "<span class='" + status.ToString() + "'>" + output + "</span>";
			
			return output;
		}
	}
}
