using System;

namespace SoftwareMonkeys.WorkHub.Configuration
{
	/// <summary>
	/// Defines the interface of all module configuration components.
	/// </summary>
	public interface IModuleConfig : IConfig
	{
        string ModuleID { get; set; }
        string Name { get; set; }
        string Title { get; set; }
        Guid UniversalProjectID { get; set; }
	}
}
