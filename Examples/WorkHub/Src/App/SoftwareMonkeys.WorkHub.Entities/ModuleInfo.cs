using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules;
using System.Collections;

namespace SoftwareMonkeys.WorkHub.Entities
{
    /// <summary>
    /// Represents a module within the application.
    /// </summary>
    public class ModuleInfo : BaseEntity, IModuleInfo
    {
        public string ModuleID
        {
            get
            {
                if (config == null)
                    return String.Empty;
                else
                    return Config.ModuleID;
            }
            set
            {
                if (config != null)
                    Config.ModuleID = value;
            }
        }

        public string Name
        {
            get
            {
                if (config == null)
                    return String.Empty;
                else
                    return Config.Name;
            }
            set
            {
                if (config != null)
                    Config.Name = value;
            }
        }

        public Guid UniversalProjectID
        {
            get
            {
                if (config == null)
                    return Guid.Empty;
                else
                    return Config.UniversalProjectID;
            }
            set
            {
                if (config != null)
                    Config.UniversalProjectID = value;
            }
        }

        public string Title
        {
            get
            {
                return Name;
            }
        }

        private ModuleConfig config;
        public ModuleConfig Config
        {
            get { return config; }
            //set { config = value; }
        }


        public ModuleInfo()
        {
        }

        public ModuleInfo(ModuleConfig config)
        {
            this.config = config;
        }

        public IEntity Clone()
        {
            throw new NotImplementedException();
        }
    }
}
