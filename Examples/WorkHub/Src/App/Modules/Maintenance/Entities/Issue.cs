using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities
{
	/// <summary>
	/// Represents a issue.
	/// </summary>
	[Serializable]
	public class Issue : BaseAuthoredEntity, IProjectItem, ISimple
	{
		private string subject;
		/// <summary>
		/// Gets/sets the subject of the issue.
		/// </summary>
		public string Subject
		{
			get { return subject; }
			set { subject = value;
			}
		}

		private string reporterName;
		/// <summary>
		/// Gets/sets the name of the person who reported the issue.
		/// </summary>
		public string ReporterName
		{
			get { return reporterName; }
			set { reporterName = value; }
		}

		private string reporterEmail;
		/// <summary>
		/// Gets/sets the email address of the person who reported the email.
		/// </summary>
		public string ReporterEmail
		{
			get { return reporterEmail; }
			set { reporterEmail = value; }
		}

		private string reporterPhone;
		/// <summary>
		/// Gets/sets the phone number of the person who reported the issue.
		/// </summary>
		public string ReporterPhone
		{
			get { return reporterPhone; }
			set { reporterPhone = value; }
		}

		private string description;
		/// <summary>
		/// Gets/sets the description of the issue.
		/// </summary>
		public string Description
		{
			get { return description; }
			set { description = value; }
		}

		private string howToRecreate;
		/// <summary>
		/// Gets/sets a set of instructions on how to recreate the issue.
		/// </summary>
		public string HowToRecreate
		{
			get { return howToRecreate; }
			set { howToRecreate = value; }
		}

		private DateTime dateReported;
		/// <summary>
		/// Gets/sets the date that the issue was reported.
		/// </summary>
		public DateTime DateReported
		{
			get { return dateReported; }
			set { dateReported = value; }
		}

		private DateTime dateResolved;
		/// <summary>
		/// Gets/sets the date that the issue was resolved.
		/// </summary>
		public DateTime DateResolved
		{
			get { return dateResolved; }
			set { dateResolved = value; }
		}

		private bool needsReply;
		/// <summary>
		/// Gets/sets a flag indicating whether the reporter expects a reply regarding the issue.
		/// </summary>
		public bool NeedsReply
		{
			get { return needsReply; }
			set { needsReply = value; }
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
		
		private IssueStatus status = IssueStatus.Pending;
		/// <summary>
		/// Gets/sets the status of the issue.
		/// </summary>
		public IssueStatus Status
		{
			get { return status; }
			set { status = value; }
		}

		private Bug[] bugs;
		/// <summary>
		/// Gets/sets the bugs associated with the solution.
		/// </summary>
		[Reference(MirrorPropertyName="Issues",
		          CountPropertyName="TotalBugs")]
		public Bug[] Bugs
		{
			get { return bugs; }
			set { bugs = value; }
		}
		
		private int totalBugs;
		/// <summary>
		/// Gets/sets the total bugs associated with this issue.
		/// </summary>
		public int TotalBugs
		{
			get { return totalBugs; }
			set { totalBugs = value; }
		}

		private SoftwareMonkeys.WorkHub.Entities.User reporter;
		/// <summary>
		/// Gets/sets the reporter of the issue.
		/// </summary>
		[Reference]
		[XmlIgnore]
		public SoftwareMonkeys.WorkHub.Entities.User Reporter
		{
			get { return reporter; }
			set { reporter = value; }
		}
		
		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Bugs", TypeName="Task")]
		[XmlIgnore]
		public ISimple[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
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
		
		private string projectVersion;
		/// <summary>
		/// Gets/sets the version of the project (or range of versions) that the solution applies to.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
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


		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Issue()
		{ }

		/// <summary>
		/// Sets the ID of the issue.
		/// </summary>
		/// <param name="issueID">The ID of the issue.</param>
		public Issue(Guid issueID)
		{
			ID = issueID;
		}
		#endregion
		
		public override string ToString()
		{
			return this.Subject;
		}
		
		
		
		string ISimple.Title {
			get {
				return Subject;
			}
			set {
				Subject = value;
			}
		}
	}
}
