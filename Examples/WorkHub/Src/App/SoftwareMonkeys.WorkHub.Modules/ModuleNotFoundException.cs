using System;
using System.Collections.Generic;
using System.Text;

namespace SoftwareMonkeys.WorkHub.Entities
{
    public class ModuleNotFoundException : Exception
    {
        public ModuleNotFoundException(string moduleName) : base(@"The required module was not found.\nModule Name: " + moduleName)
        {
        }
    }
}
