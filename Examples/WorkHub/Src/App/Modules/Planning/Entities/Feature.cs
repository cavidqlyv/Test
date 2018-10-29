using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
	/// <summary>
	/// Represents a feature.
	/// </summary>
	[Serializable]
	public class Feature : BaseAuthoredEntity, IProjectItem
	{
		private string name;
		/// <summary>
		/// Gets/sets the name of the feature.
		/// </summary>
		public string Name
		{
			get { return name; }
			set { name = value;
			}
		}

		private string description;
		/// <summary>
		/// Gets/sets a description of the feature.
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
		[Reference(TypeName="Project")]
		[XmlIgnore]
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
		/// Gets/sets the version of the project that the feature is part of.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}

		private Goal[] goals = new Goal[]{};
		/// <summary>
		/// Gets/sets the associated goals.
		/// </summary>
		[Reference(MirrorPropertyName="Features")]
		//[XmlIgnore()]
		public Goal[] Goals
		{
			get { return goals; }
			set
			{
				goals = value;
			}
		}

		private Action[] actions = new Action[]{};
		/// <summary>
		/// Gets/sets the associated actions.
		/// </summary>
		[Reference(MirrorPropertyName="Features")]
		//[XmlIgnore]
		public Action[] Actions
		{
			get { return actions; }
			set
			{
				actions = value;
			}
		}

		private ProjectEntity[] entities = new ProjectEntity[]{};
		/// <summary>
		/// Gets/sets the associated entities.
		/// </summary>
		[Reference(MirrorPropertyName="Features")]
		//[XmlIgnore]
		public ProjectEntity[] Entities
		{
			get { return entities; }
			set
			{
				entities = value;
			}
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Features", TypeName="Task")]
		[XmlIgnore]
		public ISimple[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
		}
		
		private int demandVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'demand' votes.
		/// </summary>
		public int DemandVotesBalance
		{
			get { return demandVotesBalance; }
			set { demandVotesBalance = value; }
		}
		
		private int totalDemandVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'demand' votes.
		/// </summary>
		public int TotalDemandVotes
		{
			get { return totalDemandVotes; }
			set { totalDemandVotes = value; }
		}

		private int effectiveVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'effective' votes.
		/// </summary>
		public int EffectiveVotesBalance
		{
			get { return effectiveVotesBalance; }
			set { effectiveVotesBalance = value; }
		}
		
		private int totalEffectiveVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'effective' votes.
		/// </summary>
		public int TotalEffectiveVotes
		{
			get { return totalEffectiveVotes; }
			set { totalEffectiveVotes = value; }
		}
		
		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Feature()
		{ }

		/// <summary>
		/// Sets the ID of the feature.
		/// </summary>
		/// <param name="featureID">The ID of the feature.</param>
		public Feature(Guid featureID)
		{
			ID = featureID;
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
