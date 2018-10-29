using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Entities
{
	/// <summary>
	/// Represents a project (such as a software or other business project).
	/// </summary>
	[Serializable]
	public class Project : BaseAuthoredEntity, IProject
	{		
		private string originalName;
		public string OriginalName
		{
			get { return originalName; }
			set { originalName = value; }
		}
		
		private string name;
		/// <summary>
		/// Gets/sets the name of the project.
		/// </summary>
		[Required]
		[Unique]
		public string Name
		{
			get { return name; }
			set { name = value;
			}
		}

		private string summary;
		/// <summary>
		/// Gets/sets the summary of the project.
		/// </summary>
		public string Summary
		{
			get { return summary; }
			set { summary = value; }
		}

		private string moreInfo;
		/// <summary>
		/// Gets/sets additional info about the project.
		/// </summary>
		public string MoreInfo
		{
			get { return moreInfo; }
			set { moreInfo = value; }
		}

		private string companyName;
		/// <summary>
		/// Gets/sets the name of the company responsible for the project.
		/// </summary>
		public string CompanyName
		{
			get { return companyName; }
			set { companyName = value; }
		}

		private string currentVersion;
		/// <summary>
		/// Gets/sets the current version of the project.
		/// </summary>
		public string CurrentVersion
		{
			get { return currentVersion; }
			set { currentVersion = value; }
		}

		private ProjectVisibility visibility;
		/// <summary>
		/// Gets/sets the visibility of the project.
		/// </summary>
		public ProjectVisibility Visibility
		{
			get { return visibility; }
			set { visibility = value; }
		}
		
		private Project relatedProjects;
		[Reference(MirrorPropertyName="RelatedProjects")]
		public Project RelatedProjects
		{
			get { return relatedProjects; }
			set { relatedProjects = value; }
		}
		
		private Project subProjects;
		[Reference(MirrorPropertyName="ParentProjects")]
		public Project SubProjects
		{
			get { return subProjects; }
			set { subProjects = value; }
		}
		
		private Project parentProjects;
		[Reference(MirrorPropertyName="SubProjects")]
		public Project ParentProjects
		{
			get { return parentProjects; }
			set { parentProjects = value; }
		}
		
		private SoftwareMonkeys.WorkHub.Entities.User[] managers;
		/// <summary>
		/// Gets/sets the manager of the project.
		/// </summary>
		[Reference()]
		[XmlIgnore]
		public SoftwareMonkeys.WorkHub.Entities.User[] Managers
		{
			get { return managers; }
			set { managers = value; }
		}
		
		private SoftwareMonkeys.WorkHub.Entities.User[] contributors;
		/// <summary>
		/// Gets/sets the manager of the project.
		/// </summary>
		[Reference()]
		[XmlIgnore]
		public SoftwareMonkeys.WorkHub.Entities.User[] Contributors
		{
			get { return contributors; }
			set { contributors = value; }
		}

		private ProjectStatus status;
		/// <summary>
		/// Gets/sets the status of the project.
		/// </summary>
		public ProjectStatus Status
		{
			get { return status; }
			set { status = value; }
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
			set { totalVotes = value; }
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
		public Project()
		{}

		/// <summary>
		/// Sets the ID of the project.
		/// </summary>
		/// <param name="projectID">The ID of the project.</param>
		public Project(Guid projectID)
		{
			ID = projectID;
		}

		/// <summary>
		/// Gets the name of the project.
		/// </summary>
		/// <returns>The name of the project.</returns>
		public override string ToString()
		{
			return Name;
		}
		#endregion
		
		
		/// <summary>
		/// Checks whether the project has a contributor with the provided ID.
		/// </summary>
		/// <param name="userID">The ID of the alleged contributing user.</param>
		/// <returns>A value indicating whether the user with the provided ID is a contributor of the project.</returns>
		public bool HasContributor(Guid userID)
		{
			Collection<User> contributors = new Collection<User>(
				Contributors != null
				? Contributors
				: new User[]{}
			);
			
			return contributors.Contains(userID);
		}
		
		/// <summary>
		/// Checks whether the project has a manager with the provided ID.
		/// </summary>
		/// <param name="userID">The ID of the alleged manager.</param>
		/// <returns>A value indicating whether the user with the provided ID is a manager of the project.</returns>
		public bool HasManager(Guid userID)
		{
			Collection<User> managers = new Collection<User>(
				Managers != null
				? Managers
				: new User[]{}
			);
			
			return managers.Contains(userID);
		}
		
		string ISimple.Title
		{
			get { return Name; }
			set { Name = value; }
		}
		
		string ISimple.Description
		{
			get { return Summary; }
			set { Summary = value; }
		}
	}

}
