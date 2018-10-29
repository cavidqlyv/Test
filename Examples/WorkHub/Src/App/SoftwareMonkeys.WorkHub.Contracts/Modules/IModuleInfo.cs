using System;
using System.Collections.Generic;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules
{
	public interface IModuleInfo
	{		
        string ModuleID { get; set; }
        string Name { get; set; }
	}
}
