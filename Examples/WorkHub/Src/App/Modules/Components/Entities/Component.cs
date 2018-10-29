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
	public class Component : BaseAuthoredEntity, IMultiProjectItem
	{	
		private string name;
		/// <summary>
		/// Gets/sets the name of the component.
		/// </summary>
		public string Name
		{
			get { return name; }
			set { name = value;
			}
		}

		private string summary;
		/// <summary>
		/// Gets/sets the summary of the component.
		/// </summary>
		public string Summary
		{
			get { return summary; }
			set { summary = value; }
		}
		
		private ISimple[] planningEntities;
		/// <summary>
		/// Gets/sets the planning entities that this component is part of.
		/// </summary>
		[Reference(TypeName="ProjectEntity")]
		[XmlIgnore]
		public ISimple[] PlanningEntities
		{
			get { return planningEntities; }
			set { planningEntities = value; }
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
		
		private ComponentType componentType;
		/// <summary>
		/// Gets/sets the component type.
		/// </summary>
		[Reference(MirrorPropertyName="Components")]
		[XmlIgnore]
		public ComponentType ComponentType
		{
			get { return componentType; }
			set { componentType = value; }
		}
		
		private Component[] subComponents;
		/// <summary>
		/// Gets/sets the sub components.
		/// </summary>
		[Reference(MirrorPropertyName="ParentComponents")]
		[XmlIgnore]
		public Component[] SubComponents
		{
			get { return subComponents; }
			set { subComponents = value; }
		}
		
		
		private Component[] parentComponents;
		/// <summary>
		/// Gets/sets the parent components.
		/// </summary>
		[Reference(MirrorPropertyName="SubComponents")]
		[XmlIgnore]
		public Component[] ParentComponents
		{
			get { return parentComponents; }
			set { parentComponents = value; }
		}
		
		private Component[] relatedComponents;
		/// <summary>
		/// Gets/sets the related components.
		/// </summary>
		[Reference(MirrorPropertyName="RelatedComponents")]
		[XmlIgnore]
		public Component[] RelatedComponents
		{
			get { return relatedComponents; }
			set { relatedComponents = value; }
		}

		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Component()
		{}

		/// <summary>
		/// Sets the ID of the component.
		/// </summary>
		/// <param name="componentID">The ID of the component.</param>
		public Component(Guid componentID)
		{
			ID = componentID;
		}

		/// <summary>
		/// Gets the name of the component
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
		
		string ISimple.Description {
			get {
				return Summary;
			}
			set {
				Summary = value;
			}
		}
	}
}
