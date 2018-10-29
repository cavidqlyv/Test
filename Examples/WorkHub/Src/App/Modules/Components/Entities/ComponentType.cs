using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Components.Entities
{
	/// <summary>
	/// Represents a component.
	/// </summary>
	[Serializable]
	public class ComponentType : BaseAuthoredEntity, IMultiProjectItem
	{	
		private string name;
		/// <summary>
		/// Gets/sets the title of the component.
		/// </summary>
		public string Name
		{
			get { return name;}
			set { name = value;
			}
		}

		private string description;
		/// <summary>
		/// Gets/sets the description of the component.
		/// </summary>
		public string Description
		{
			get { return description;; }
			set { description = value; }
		}
				
		private IProject[] projects;
		/// <summary>
		/// Gets/sets the project that this component is part of.
		/// </summary>
		[Reference(TypeName="Project")]
		[XmlIgnore]
		public IProject[] Projects
		{
			get { return projects; }
			set { projects = value; }
		}
		
		private Component[] components;
		/// <summary>
		/// Gets/sets the components.
		/// </summary>
		[Reference(MirrorPropertyName="ComponentType")]
		[XmlIgnore]
		public Component[] Components
		{
			get { return components; }
			set { components = value; }
		}

		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public ComponentType()
		{}

		/// <summary>
		/// Sets the ID of the component type.
		/// </summary>
		/// <param name="componentID">The ID of the component.</param>
		public ComponentType(Guid componentID)
		{
			ID = componentID;
		}

		/// <summary>
		/// Gets the name of the component type
		/// </summary>
		/// <returns>The name of the component.</returns>
		public override string ToString()
		{
			return Name;
		}
		#endregion
	
		
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
