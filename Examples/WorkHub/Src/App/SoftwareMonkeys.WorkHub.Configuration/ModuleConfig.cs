using System;
using System.Collections.Generic;
using System.Text;
using System.Xml.Serialization;
using System.Collections;

namespace SoftwareMonkeys.WorkHub.Configuration
{
    [System.Xml.Serialization.XmlType("Module")]
    [Serializable]
    public class ModuleConfig : BaseConfig, IModuleConfig
    {
        private string name = String.Empty;
        /// <summary>
        /// Gets/sets the name of the module.
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        private string moduleID;
        /// <summary>
        /// Gets/sets the ID of the module.
        /// </summary>
        public string ModuleID
        {
            get { return moduleID; }
            set { moduleID = value; }
        }

        private string title = String.Empty;
        /// <summary>
        /// Gets/sets the title of the module.
        /// </summary>
        public string Title
        {
            get {
                if (title == String.Empty)
                    return name;
                return title; }
            set { title = value; }
        }
        
        public string PathVariation
        {
        	get {return String.Empty; }
        	set{}
        }


        private Guid universalProjectID = Guid.Empty;
        /// <summary>
        /// Gets/sets the universal project ID of the module.
        /// </summary>
        public Guid UniversalProjectID
        {
            get{
                return universalProjectID;
            }
            set { universalProjectID = value; }
        }

        private Dictionary<string, object> components;
        /// <summary>
        /// Gets/sets the components of this module.
        /// </summary>
        [XmlIgnore]
        public Dictionary<string, object> Components
        {
            get { return components; }
            set { components = value; }
        }

    }
}
