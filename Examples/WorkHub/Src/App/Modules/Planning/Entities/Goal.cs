using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
	/// <summary>
	/// Represents a goal.
	/// </summary>
	[Serializable]
	public class Goal : BaseAuthoredEntity, IProjectItem
	{
		private string title = String.Empty;
		/// <summary>
		/// Gets/sets the title of the goal.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string description = String.Empty;
		/// <summary>
		/// Gets/sets a brief description of the goal.
		/// </summary>
		public string Description
		{
			get { return description; }
			set { description = value; }
		}
		
		private IProject project;
		/// <summary>
		/// Gets/sets the name of the project that the goal is part of.
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

		private string projectVersion = string.Empty;
		/// <summary>
		/// Gets/sets the version of the project that will achieve the goal.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}

		private Goal[] prerequisites = new Goal[] { };
		/// <summary>
		/// Gets/sets the associated prerequisites.
		/// </summary>
		[Reference]
		//[XmlIgnore()]
		public Goal[] Prerequisites
		{
			get { return prerequisites; }
			set
			{
				prerequisites = value;
			}
		}


		private Actor[] actors = new Actor[] {};
		/// <summary>
		/// Gets/sets the associated actors.
		/// </summary>
		[Reference(MirrorPropertyName="Goals")]
		//[XmlIgnore()]
		public Actor[] Actors
		{
			get { return actors; }
			set
			{
				actors = value;
				
			}
		}

		private Action[] actions = new Action[] {};
		/// <summary>
		/// Gets/sets the associated actions.
		/// </summary>
		[Reference]
		//[XmlIgnore()]
		public Action[] Actions
		{
			get { return actions; }
			set
			{
				actions = value;
			}
		}

		private Feature[] features = new Feature[]{};
		/// <summary>
		/// Gets/sets the features to this goal.
		/// </summary>
		[Reference(MirrorPropertyName="Goals")]
		//[XmlIgnore()]
		public Feature[] Features
		{
			get { return features; }
			set
			{
				features = value;
			}
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Goals", TypeName="Task")]
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

		private int achievedVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'achieved' votes.
		/// </summary>
		public int AchievedVotesBalance
		{
			get { return achievedVotesBalance; }
			set { achievedVotesBalance = value; }
		}
		
		private int totalAchievedVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'achieved' votes.
		/// </summary>
		public int TotalAchievedVotes
		{
			get { return totalAchievedVotes; }
			set { totalAchievedVotes = value; }
		}


		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Goal()
		{ }

		/// <summary>
		/// Sets the ID of the goal.
		/// </summary>
		/// <param name="goalID">The ID of the goal.</param>
		public Goal(Guid goalID)
		{
			ID = goalID;
		}
		#endregion

		public override string ToString()
		{
			return Title;
		}
	}
}
