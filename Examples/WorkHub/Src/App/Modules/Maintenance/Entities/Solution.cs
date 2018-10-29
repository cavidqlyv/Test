using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Represents a solution.
	/// </summary>
	[Serializable]
	public class Solution : BaseAuthoredEntity, IProjectItem
	{		
		private string title;
		/// <summary>
		/// Gets/sets the title of the solution.
		/// </summary>
		[Required]
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string instructions;
		/// <summary>
		/// Gets/sets the instructions for the solution.
		/// </summary>
		public string Instructions
		{
			get { return instructions; }
			set { instructions = value; }
		}

		private DateTime dateCreated;
		/// <summary>
		/// Gets/sets the date the solution was created.
		/// </summary>
		public DateTime DateCreated
		{
			get { return dateCreated; }
			set { dateCreated = value; }
		}
		
		private string projectVersion;
		/// <summary>
		/// Gets/sets the version of the project (or range of versions) that the solution applies to.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
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
		
		private Bug[] bugs;
		/// <summary>
		/// Gets/sets the bugs associated with the solution.
		/// </summary>
		[Reference(MirrorPropertyName="Solutions")]
		public Bug[] Bugs
		{
			get { return bugs; }
			set { bugs = value; }
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
			set { totalEffectiveVotes  = value; }
		}


		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Solution()
		{ }

		/// <summary>
		/// Sets the ID of the solution.
		/// </summary>
		/// <param name="solutionID">The ID of the solution.</param>
		public Solution(Guid solutionID)
		{
			ID = solutionID;
		}
		#endregion

		public override string ToString()
		{
			return Title;
		}
		
		
		string ISimple.Description {
			get {
				return this.Instructions;
			}
			set {
				Instructions = value;
			}
		}
	}
}
