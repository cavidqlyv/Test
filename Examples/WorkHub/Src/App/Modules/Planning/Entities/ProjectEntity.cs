using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents a entity.
    /// </summary>
    [Serializable]
    public class ProjectEntity : BaseAuthoredEntity, IProjectItem, ISimple
    {
        private string name;
        /// <summary>
        /// Gets/sets the name of the entity.
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value;
            }
        }

        private string description;
        /// <summary>
        /// Gets/sets a description of the entity.
        /// </summary>
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        private IProject project;
        /// <summary>
        /// Gets/sets the name of the project that the feature is part of.
        /// </summary>
        [XmlIgnore]
        [Reference(TypeName="Project")]
        public IProject Project
        {
            get { return project; }
            set
            {
                project = value;
            }
        }

        private string projectVersion;
        /// <summary>
        /// Gets/sets the version of the project that the entity is part of.
        /// </summary>
        public string ProjectVersion
        {
            get { return projectVersion; }
            set { projectVersion = value; }
        }
         
        private ISimple[] technicalComponents;
		/// <summary>
		/// Gets/sets the technical components that this entity is associated with is part of.
		/// </summary>
		[Reference(TypeName="Component")]
		[XmlIgnore]
		public ISimple[] TechnicalComponents
		{
			get { return technicalComponents; }
			set { technicalComponents = value; }
		}
        
       private ProjectEntityProperty[] properties = new ProjectEntityProperty[]{};
        /// <summary>
        /// Gets/sets the associated properties.
        /// </summary>
        [Reference(MirrorPropertyName="Entity")]
        public ProjectEntityProperty[] Properties
        {
            get { return properties; }
            set
            {
                properties = value;
            }
        }

        private Feature[] features = new Feature[] { };
        /// <summary>
        /// Gets/sets the associated features.
        /// </summary>
        [Reference(MirrorPropertyName="Entities")]
        public Feature[] Features
        {
            get { return features; }
            set
            {
                features = value;
            }
        }

        private Action[] actions = new Action[] { };
        /// <summary>
        /// Gets/sets the associated actions.
        /// </summary>
        [Reference(MirrorPropertyName="Entities")]
        //[XmlIgnore()]
        public Action[] Actions
        {
            get { return actions; }
            set
            {
                actions = value;
            }
        }
        
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Entities", TypeName="Task")]
		[XmlIgnore]
		public ISimple[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
		}


        #region Constructors
        /// <summary>
        /// Empty constructor.
        /// </summary>
        public ProjectEntity()
        { }

        /// <summary>
        /// Sets the ID of the entity.
        /// </summary>
        /// <param name="entityID">The ID of the entity.</param>
        public ProjectEntity(Guid entityID)
        {
            ID = entityID;
        }
        #endregion

        public override string ToString()
        {
            return Name;
        }
    	
		string ISimple.Title {
			get {
				return Name;
			}
			set {
        		Name = value;
			}
		}
    }
}
