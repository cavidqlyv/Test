using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Represents a bug.
	/// </summary>
	[Serializable]
	public class Bug : BaseAuthoredEntity, IProjectItem, ISimple
	{
		private string title;
		/// <summary>
		/// Gets/sets the title of the bug.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string description;
		/// <summary>
		/// Gets/sets the description of the bug.
		/// </summary>
		public string Description
		{
			get { return description; }
			set { description = value; }
		}

		private DateTime dateReported;
		/// <summary>
		/// Gets/sets the date the bug was reported.
		/// </summary>
		public DateTime DateReported
		{
			get { return dateReported; }
			set { dateReported = value; }
		}

		private BaseEntity reporter;
		/// <summary>
		/// Gets/sets the user who reported the bug.
		/// </summary>
		[Reference(TypeName="User")]
		[XmlIgnore]
		public BaseEntity Reporter
		{
			get { return reporter; }
			set { reporter = value; }
		}
		
		private Issue[] issues;
		/// <summary>
		/// Gets/sets the issues associated with the bug.
		/// </summary>
		[Reference(MirrorPropertyName="Bugs",
		          CountPropertyName = "TotalIssues")]
		public Issue[] Issues
		{
			get { return issues; }
			set { issues = value; }
		}
		
		private int totalIssues;
		/// <summary>
		/// Gets/sets the total number of issues associated with this bug.
		/// </summary>
		public int TotalIssues
		{
			get { return totalIssues; }
			set { totalIssues = value; }
		}

		private string version;
		/// <summary>
		/// Gets/sets the versions this bug applies to.
		/// </summary>
		public string Version
		{
			get { return version; }
			set { version = value; }
		}

		private string fixVersion;
		/// <summary>
		/// Gets/sets the version that the bug will be fixed in.
		/// </summary>
		public string FixVersion
		{
			get { return fixVersion; }
			set { fixVersion = value; }
		}
		
		private string url;
		/// <summary>
		/// Gets/sets the URL that the bug occurred at.
		/// </summary>
		public string Url
		{
			get { return url; }
			set { url = value; }
		}

		private BugStatus status = BugStatus.Pending;
		/// <summary>
		/// Gets/sets the status of the bug.
		/// </summary>
		public BugStatus Status
		{
			get {
				if (status == BugStatus.Fixed || status == BugStatus.Tested)
					PercentFixed = 100;
				return status; }
			set { status = value; }
		}

		private Priority priority = SoftwareMonkeys.WorkHub.Entities.Priority.Moderate;
		/// <summary>
		/// Gets/sets the priority of the bug.
		/// </summary>
		public Priority Priority
		{
			get { return priority; }
			set { priority = value; }
		}
		
		private Difficulty difficulty = SoftwareMonkeys.WorkHub.Entities.Difficulty.Moderate;
		/// <summary>
		/// Gets/sets the difficulty of this task.
		/// </summary>
		public Difficulty Difficulty
		{
			get { return difficulty; }
			set { difficulty = value; }
		}

		private int percentFixed;
		/// <summary>
		/// Gets/sets the percentage of the bug that has been fixed.
		/// </summary>
		public int PercentFixed
		{
			get { return percentFixed; }
			set { percentFixed = value; }
		}

		private BugType type;
		/// <summary>
		/// Gets/sets the type of bug.
		/// </summary>
		public BugType Type
		{
			get { return type; }
			set { type = value; }
		}

		private SoftwareMonkeys.WorkHub.Entities.User[] assignedTo;
		/// <summary>
		/// Gets/sets the users that the bug is assigned to.
		/// </summary>
		[Reference(TypeName="User")]
		[XmlIgnore]
		public SoftwareMonkeys.WorkHub.Entities.User[] AssignedTo
		{
			get
			{
				if (assignedTo == null)
					assignedTo = new SoftwareMonkeys.WorkHub.Entities.User[] { };
				return assignedTo; }
			set
			{
				assignedTo = value;
			}
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

		private Solution[] solutions = new Solution[]{};
		/// <summary>
		/// Gets/sets the solutions to this bug.
		/// </summary>
		[Reference(MirrorPropertyName="Bugs",
		          CountPropertyName="TotalSolutions")]
		[XmlIgnore]
		public Solution[] Solutions
		{
			get { return solutions; }
			set
			{
				solutions = value;
			}
		}
		
		private int totalSolutions;
		/// <summary>
		/// Gets/sets the total number of solutions associated with this bug.
		/// </summary>
		public int TotalSolutions
		{
			get { return totalSolutions; }
			set { totalSolutions = value; }
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Bugs", TypeName="Task")]
		[XmlIgnore]
		public ISimple[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
		}

		private int confirmedVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'confirmed' votes.
		/// </summary>
		public int ConfirmedVotesBalance
		{
			get { return confirmedVotesBalance; }
			set { confirmedVotesBalance = value; }
		}
		
		private int totalConfirmedVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'confirmed' votes.
		/// </summary>
		public int TotalConfirmedVotes
		{
			get { return totalConfirmedVotes; }
			set { totalConfirmedVotes = value; }
		}

		private int resolvedVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'resolved' votes.
		/// </summary>
		public int ResolvedVotesBalance
		{
			get { return resolvedVotesBalance; }
			set { resolvedVotesBalance = value; }
		}
		
		private int totalResolvedVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'resolved' votes.
		/// </summary>
		public int TotalResolvedVotes
		{
			get { return totalResolvedVotes; }
			set { totalResolvedVotes = value; }
		}

		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Bug()
		{}

		/// <summary>
		/// Sets the ID of the bug.
		/// </summary>
		/// <param name="bugID">The ID of the bug.</param>
		public Bug(Guid bugID)
		{
			ID = bugID;
		}

		public override string ToString()
		{
			return Title;
		}
		
	}
}
