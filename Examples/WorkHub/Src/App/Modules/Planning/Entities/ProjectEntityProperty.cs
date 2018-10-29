using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents a property.
    /// </summary>
    [Serializable]
    public class ProjectEntityProperty : BaseAuthoredEntity, ISubProjectItem
    {    	
        private string name;
        /// <summary>
        /// Gets/sets the name of the property.
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value;
            }
        }

        private ProjectEntityPropertyType type;
        /// <summary>
        /// Gets/sets the value type of the property.
        /// </summary>
        public ProjectEntityPropertyType Type
        {
            get { return type; }
            set { type = value; }
        }

        private string otherType;
        /// <summary>
        /// Gets/sets the custom value type of the property.
        /// </summary>
        public string OtherType
        {
            get { return otherType; }
            set { otherType = value; }
        }
        
        private string description;
        /// <summary>
        /// Gets/sets a description of the property.
        /// </summary>
        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        private ProjectEntity entity;
        /// <summary>
        /// Gets/sets the entity that the property belongs to.
        /// </summary>
        [Reference(MirrorPropertyName="Properties")]
        public ProjectEntity Entity
        {
            get { return entity; }
            set { entity = value; }
        }
        
        string ISubEntity.ItemsPropertyName
        {
        	get { return "Properties"; }
        }

        IEntity ISubEntity.Parent
        {
        	get { return Entity; }
        	set { Entity = (ProjectEntity)value; }
        }
        
        string ISubEntity.ParentPropertyName
        {
        	get { return "Entity"; }
        }
        
        string ISubEntity.ParentTypeName
        {
        	get { return "ProjectEntity"; }
        }
        
        int ISubEntity.Number
        {
        	get { return 0; }
        	set {}
        }
        
        string ISubEntity.NumberPropertyName
        {
        	get { return String.Empty; }
        }
        
        
        #region Constructors
        /// <summary>
        /// Empty constructor.
        /// </summary>
        public ProjectEntityProperty()
        { }

        /// <summary>
        /// Sets the ID of the property.
        /// </summary>
        /// <param name="propertyID">The ID of the property.</param>
        public ProjectEntityProperty(Guid propertyID)
        {
            ID = propertyID;
        }
        #endregion
        
        
        
    }
}
