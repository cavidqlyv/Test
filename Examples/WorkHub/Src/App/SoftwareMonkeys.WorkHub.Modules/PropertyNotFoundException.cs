using System;
using System.Collections.Generic;
using System.Text;

namespace SoftwareMonkeys.WorkHub.Entities
{
    public class PropertyNotFoundException : Exception
    {
        public PropertyNotFoundException(string moduleName, string componentName, string propertyName)
            : base(@"The required property was not found.\nModule Name: " + moduleName + @"\nComponent Name: " + componentName + @"\nProperty Name: " + propertyName)
        {
        }
    }
}
