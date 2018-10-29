using System;
using System.IO;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Data
{
	/// <summary>
	/// 
	/// </summary>
	public class ModuleVersionUtilities
	{
		static public Version GetModuleVersion(string moduleID)
		{
			string versionFilePath = StateAccess.State.PhysicalApplicationPath + Path.DirectorySeparatorChar
				+ "Modules" + Path.DirectorySeparatorChar
				+ moduleID + Path.DirectorySeparatorChar
				+ "Version.number";
			
			return VersionUtilities.LoadVersionFromFile(versionFilePath);
		}
	}
}
