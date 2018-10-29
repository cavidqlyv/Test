using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
	/// <summary>
	/// Represents a restraint.
	/// </summary>
	[Serializable]
	public class Restraint : BaseAuthoredEntity, IProjectItem, ISimple
	{
		private string title;
		/// <summary>
		/// Gets/sets the title of the restraint.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string details;
		/// <summary>
		/// Gets/sets the details of the restraint.
		/// </summary>
		public string Details
		{
			get { return details; }
			set { details = value; }
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

		private Action[] actions = new Action[] { };
		/// <summary>
		/// Gets/sets the associated actions.
		/// </summary>
		[Reference(MirrorPropertyName="Restraints")]
		public Action[] Actions
		{
			get { return actions; }
			set
			{
				actions = value;
			}
		}

		private Actor[] actors = new Actor[] { };
		/// <summary>
		/// Gets/sets the associated actors.
		/// </summary>
		[Reference(MirrorPropertyName="Restraints")]
		public Actor[] Actors
		{
			get { return actors; }
			set
			{
				actors = value;
			}
		}
		
		
		private string projectVersion;
		/// <summary>
		/// Gets/sets the version of the project that the restraint is introduced.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Goals", TypeName="Task")]
		[XmlIgnore]
		public ISimple[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
		}
		
		private int votesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of votes.
		/// </summary>
		public int VotesBalance
		{
			get { return votesBalance; }
			set { votesBalance = value; }
		}

		private int totalVotes = 0;
		/// <summary>
		/// Gets/sets the total number of votes.
		/// </summary>
		public int TotalVotes
		{
			get { return totalVotes; }
			set { totalVotes  = value; }
		}

		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Restraint()
		{ }

		/// <summary>
		/// Sets the ID of the restraint.
		/// </summary>
		/// <param name="restraintID">The ID of the restraint.</param>
		public Restraint(Guid restraintID)
		{
			ID = restraintID;
		}
		#endregion
		
		public override string ToString()
		{
			return Title;
		}
		
		string ISimple.Description {
			get {
				return this.Details;
			}
			set {
				Details = value;
			}
		}
	}
}
