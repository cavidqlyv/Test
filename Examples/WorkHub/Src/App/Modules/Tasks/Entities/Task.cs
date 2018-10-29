using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Entities
{
	/// <summary>
	/// Represents a task.
	/// </summary>
	[Serializable]
	public class Task : BaseAuthoredEntity, IProjectItem, ISimple
	{
		private string title = String.Empty;
		/// <summary>
		/// Gets/sets the title of the task.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string description = String.Empty;
		/// <summary>
		/// Gets/sets the description of the task.
		/// </summary>
		public string Description
		{
			get { return description; }
			set { description =  value; }
		}

		private bool enableTimeframe;
		/// <summary>
		/// Gets/sets a value indicating whether the start and end dates are enabled.
		/// </summary>
		public bool EnableTimeframe
		{
			get { return enableTimeframe; }
			set { enableTimeframe = value; }
		}

		private DateTime startDate = DateTime.MinValue;
		/// <summary>
		/// Gets/sets the start date of the task.
		/// </summary>
		public DateTime StartDate
		{
			get { return startDate; }
			set { startDate = value; }
		}

		private DateTime endDate = DateTime.MinValue;
		/// <summary>
		/// Gets/sets the end date of the task.
		/// </summary>
		public DateTime EndDate
		{
			get { return endDate; }
			set { endDate = value; }
		}

		private TaskStatus status = TaskStatus.Pending;
		/// <summary>
		/// Gets/sets the status of the task.
		/// </summary>
		public TaskStatus Status
		{
			get { return status; }
			set { status = value; }
		}

		private int percentComplete;
		/// <summary>
		/// Gets/sets the amount of this task that completed as a percentage.
		/// </summary>
		public int PercentComplete
		{
			get { return percentComplete; }
			set { percentComplete = value; }
		}

		private Priority priority = SoftwareMonkeys.WorkHub.Entities.Priority.Moderate;
		/// <summary>
		/// Gets/sets the priority of this task.
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

		private SoftwareMonkeys.WorkHub.Entities.User creator;
		/// <summary>
		/// Gets/sets the name of the creator of the feature.
		/// </summary>
		[Reference]
		[XmlIgnore]
		// TODO: Remove this and use the Author property from BaseAuthoredEntity
		public SoftwareMonkeys.WorkHub.Entities.User Creator
		{
			get { return creator; }
			set
			{
				creator = value;
			}
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

		private string projectVersion = String.Empty;
		/// <summary>
		/// Gets/sets the project version this task is to be completed for.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}

		private DateTime dateCreated = DateTime.MinValue;
		/// <summary>
		/// Gets/sets the date that this task was created.
		/// </summary>
		public DateTime DateCreated
		{
			get { return dateCreated; }
			set { dateCreated = value; }
		}

		#region Tree properties
		private Task[] subTasks = new Task[]{};
		/// <summary>
		/// Gets/sets the tasks within this task.
		/// </summary>
		[Reference]
		public Task[] SubTasks
		{
			get { return subTasks; }
			set { subTasks = value; }
		}
		#endregion

		private Task[] prerequisites = new Task[]{};
		/// <summary>
		/// Gets/sets the tasks within this task.
		/// </summary>
		[Reference(CountPropertyName="TotalPrerequisites")]
		public Task[] Prerequisites
		{
			get { return subTasks; }
			set { subTasks = value; }
		}
		
		private int totalPrerequisites;
		/// <summary>
		/// Gets/sets the total number of prerequisites assigned to this task.
		/// </summary>
		public int TotalPrerequisites
		{
			get { return totalPrerequisites; }
			set { totalPrerequisites = value; }
		}

		private Milestone[] milestones = new Milestone[]{};
		/// <summary>
		/// Gets/sets the milestones related to this task.
		/// </summary>
		// [IgnoreProperty()]
		[Reference(MirrorPropertyName="Tasks",
		          CountPropertyName="TotalMilestones")]
		public Milestone[] Milestones
		{
			get { return milestones; }
			set
			{
				milestones = value;
			}
		}
		
		private int totalMilestones;
		/// <summary>
		/// Gets/sets the total number of milestones that this task is assigned to.
		/// </summary>
		public int TotalMilestones
		{
			get { return totalMilestones; }
			set { totalMilestones = value; }
		}
		
		private SoftwareMonkeys.WorkHub.Entities.User[] assignedUsers = new SoftwareMonkeys.WorkHub.Entities.User[]{};
		/// <summary>
		/// Gets/sets the associated assignedUsers.
		/// </summary>
		[Reference(CountPropertyName="TotalAssignedUsers")]
		public SoftwareMonkeys.WorkHub.Entities.User[] AssignedUsers
		{
			get { return assignedUsers; }
			set
			{
				assignedUsers = value;
			}
		}
		
		private int totalAssignedUsers;
		/// <summary>
		/// Gets/sets the total number of assigned users.
		/// </summary>
		public int TotalAssignedUsers
		{
			get { return totalAssignedUsers; }
			set { totalAssignedUsers = value; }
		}

		private ISimple[] goals = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated goals.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="Goal")]
		[XmlIgnore]
		public ISimple[] Goals
		{
			get { return goals; }
			set
			{
				goals = value;
			}
		}
		
		private ISimple[] scenarios = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated scenarios.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="Scenario")]
		[XmlIgnore]
		public ISimple[] Scenarios
		{
			get { return scenarios; }
			set
			{
				scenarios = value;
			}
		}
		
		private ISimple[] features = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated features.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="Feature")]
		[XmlIgnore]
		public ISimple[] Features
		{
			get { return features; }
			set
			{
				features = value;
			}
		}
		
		private ISimple[] actions = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated actions.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="Action")]
		[XmlIgnore]
		public ISimple[] Actions
		{
			get { return actions; }
			set
			{
				actions = value;
			}
		}
		
		private ISimple[] planningEntities = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated planning entities.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="ProjectEntity")]
		[XmlIgnore]
		public ISimple[] PlanningEntities
		{
			get { return planningEntities; }
			set
			{
				planningEntities = value;
			}
		}
		
		private ISimple[] restraints = new ISimple[]{};
		/// <summary>
		/// Gets/sets the associated restraints.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks", TypeName="Restraint")]
		[XmlIgnore]
		public ISimple[] Restraints
		{
			get { return restraints; }
			set
			{
				restraints = value;
			}
		}
		
		private Suggestion[] suggestions = new Suggestion[]{};
		/// <summary>
		/// Gets/sets the associated suggestions.
		/// </summary>
		[Reference(MirrorPropertyName="Tasks",
		          CountPropertyName="TotalSuggestions")]
		public Suggestion[] Suggestions
		{
			get { return suggestions; }
			set
			{
				suggestions = value;
			}
		}
		
		private int totalSuggestions;
		/// <summary>
		/// Gets/sets the total number of suggestions assigned to this task.
		/// </summary>
		public int TotalSuggestions
		{
			get { return totalSuggestions; }
			set { totalSuggestions = value; }
		}
		
		private ISimple[] bugs = new ISimple[]{};
		[Reference(MirrorPropertyName="Tasks", TypeName="Bug",
		          CountPropertyName="TotalBugs")]
		[XmlIgnore]
		public ISimple[] Bugs
		{
			get { return bugs; }
			set { bugs = value; }
		}
		
		private int totalBugs;
		/// <summary>
		/// Gets/sets the total number of bugs assigned to this task.
		/// </summary>
		public int TotalBugs
		{
			get { return totalBugs; }
			set { totalBugs = value; }
		}
		
		private ISimple[] issues = new ISimple[]{};
		[Reference(MirrorPropertyName="Tasks", TypeName="Issue")]
		[XmlIgnore]
		public ISimple[] Issues
		{
			get { return issues; }
			set { issues = value; }
		}
		
		private int demandVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of votes indicating demand.
		/// </summary>
		public int DemandVotesBalance
		{
			get { return demandVotesBalance; }
			set { demandVotesBalance = value; }
		}
		
		private int totalDemandVotes = 0;
		/// <summary>
		/// Gets/sets the total number of votes indicating demand.
		/// </summary>
		public int TotalDemandVotes
		{
			get { return totalDemandVotes; }
			set { totalDemandVotes = value; }
		}
		
		private int completeVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of votes indicating that the task is complete.
		/// </summary>
		public int CompleteVotesBalance
		{
			get { return completeVotesBalance; }
			set { completeVotesBalance = value; }
		}
		
		private int totalCompleteVotes = 0;
		/// <summary>
		/// Gets/sets the total number of votes indicating that the task is complete.
		/// </summary>
		public int TotalCompleteVotes
		{
			get { return totalCompleteVotes; }
			set { totalCompleteVotes = value; }
		}
		
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Task()
		{}

		/// <summary>
		/// Sets the ID of the task.
		/// </summary>
		/// <param name="taskID">The ID of the task.</param>
		public Task(Guid taskID)
		{
			ID = taskID;
		}

		public override string ToString()
		{
			return Title;
		}
		
	}
}
