using System;
using System.Collections.Generic;
using System.Text;

namespace SoftwareMonkeys.WorkHub.Configuration
{
    public class ModuleConfigCollection : List<IModuleConfig>
    {
        /// <summary>
        /// Gets/sets the module configuration object with the provided name.
        /// </summary>
        /// <param name="name">The name of the module.</param>
        /// <returns>The module with the provided name.</returns>
        public ModuleConfig this[string name]
        {
            get
            {
                foreach (ModuleConfig config in this)
                    if (config.Name == name)
                        return config;

                return null;
            }
            set
            {
                if (value == null)
                {
                    for (int i = 0; i < Count; i++)
                    {
                        if (this[i].Name == name)
                            RemoveAt(i);
                    }
                }
                else
                {
                    for (int i = 0; i < Count; i++)
                    {
                        if (this[i].Name == name)
                        {
                            this[i] = value;
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Checks whether the specified module exists in the collection.
        /// </summary>
        /// <param name="name">The name of the module to check for.</param>
        /// <returns>A flag indicating whether the module was fond.</returns>
        public bool Contains(string name)
        {
            foreach (ModuleConfig config in this)
                if (config.Name == null)
                    return true;
            return false;
        }

        /// <summary>
        /// Retrieves the physical file path to the configuration file of the specified module.
        /// </summary>
        /// <param name="moduleID">The ID of the module to retrieve the configuration file for.</param>
        /// <returns>The physical file path to the specified configuration file.</returns>
        public string GetConfigFilePath(string moduleID)
        {
            return Config.Application.PhysicalApplicationPath + @"\Modules\" + moduleID + @"\Module.config";
        }

        /// <summary>
        /// Commits all the module configurations to file.
        /// </summary>
        public void Commit()
        {
            throw new NotImplementedException();
        }

    }
}
