using System;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web
{
	/// <summary>
	/// Description of BugTypeUtilities.
	/// </summary>
	public class BugTypeUtilities
	{
		static public string GetTypeText(BugType status)
		{
			switch (status)
			{
				case BugType.NotSet:
					return Language.NotSet;
				case BugType.Cosmetic:
					return Language.Cosmetic;
				case BugType.Functional:
					return Language.Functional;
				case BugType.Security:
					return Language.Security;
				case BugType.Performance:
					return Language.Performance;
				case BugType.Hidden:
					return Language.Hidden;
			}
			return Language.NotSet;
		}
	}
}
