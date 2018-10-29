using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
	/// <summary>
	/// Represents a action.
	/// </summary>
	[Serializable]
	public class Action : BaseAuthoredEntity, IProjectItem, ISimple
	{
		private string name;
		/// <summary>
		/// Gets/sets the name of the action.
		/// </summary>
		public string Name
		{
			get { return name; }
			set { name = value;
			}
		}

		private string summary;
		/// <summary>
		/// Gets/sets a summary of the action.
		/// </summary>
		public string Summary
		{
			get { return summary; }
			set { summary = value; }
		}
		
		private ActionStep[] steps = new ActionStep[]{};
		/// <summary>
		/// Gets/sets the associated steps.
		/// </summary>
		[Reference(MirrorPropertyName="Parent")]
		public ActionStep[] Steps
		{
			get { return steps; }
			set
			{
				steps = value;
			}
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
		/// Gets/sets the version of the project that the action is part of.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}

		private Feature[] features = new Feature[]{};
		/// <summary>
		/// Gets/sets the associated features.
		/// </summary>
		[Reference(MirrorPropertyName="Actions")]
		public Feature[] Features
		{
			get { return features; }
			set
			{
				features = value;
			}
		}

		private Actor[] actors = new Actor[]{};
		/// <summary>
		/// Gets/sets the associated actors.
		/// </summary>
		[Reference]
		public Actor[] Actors
		{
			get { return actors; }
			set
			{
				actors = value;
			}
		}

		private ProjectEntity[] entities = new ProjectEntity[]{};
		/// <summary>
		/// Gets/sets the associated entities.
		/// </summary>
		[Reference]
		//[XmlIgnore()]
		public ProjectEntity[] Entities
		{
			get { return entities; }
			set
			{
				entities = value;
			}
		}
		
		private Goal[] goals = new Goal[]{};
		/// <summary>
		/// Gets/sets the associated goals.
		/// </summary>
		[Reference]
		//[XmlIgnore()]
		public Goal[] Goals
		{
			get { return goals; }
			set
			{
				goals = value;
			}
		}
		
		private Restraint[] restraints = new Restraint[]{};
		/// <summary>
		/// Gets/sets the associated actions.
		/// </summary>
		[Reference(MirrorPropertyName="Actions")]
		public Restraint[] Restraints
		{
			get { return restraints; }
			set
			{
				restraints = value;
			}
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Bugs", TypeName="Task")]
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
		public Action()
		{ }

		/// <summary>
		/// Sets the ID of the action.
		/// </summary>
		/// <param name="actionID">The ID of the action.</param>
		public Action(Guid actionID)
		{
			ID = actionID;
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
