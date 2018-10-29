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
	public class Milestone : BaseAuthoredEntity, IProjectItem
	{		
		private int milestoneNumber;
		/// <summary>
		/// Gets/sets the number of the milestone on the list.
		/// </summary>
		public int MilestoneNumber
		{
			get { return milestoneNumber;  }
			set { milestoneNumber = value; }
		}
		
		private string title = String.Empty;
		/// <summary>
		/// Gets/sets the title of the milestone.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string description = String.Empty;
		/// <summary>
		/// Gets/sets the description of the milestone.
		/// </summary>
		public string Description
		{
			get { return description; }
			set { description =  value; }
		}

		private bool enableDeadline;
		/// <summary>
		/// Gets/sets a value indicating whether the deadline is enabled.
		/// </summary>
		public bool EnableDeadline
		{
			get { return enableDeadline; }
			set { enableDeadline = value; }
		}

		private DateTime deadline;
		/// <summary>
		/// Gets/sets the end date of the milestone.
		/// </summary>
		public DateTime Deadline
		{
			get { return deadline; }
			set { deadline = value; }
		}

		private MilestoneStatus status = MilestoneStatus.Pending;
		/// <summary>
		/// Gets/sets the status of the milestone.
		/// </summary>
		public MilestoneStatus Status
		{
			get { return status; }
			set { status = value; }
		}

		private IProject project;
		/// <summary>
		/// Gets/sets the name of the project that the milestone is part of.
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
		/// Gets/sets the version of the projec that the milestone is associated with.
		/// </summary>
		public string ProjectVersion
		{
			get { return projectVersion; }
			set { projectVersion = value; }
		}

		#region Tree properties
		private Milestone[] subMilestones = new Milestone[]{};
		/// <summary>
		/// Gets/sets the milestones within this milestone.
		/// </summary>
		[Reference]
		public Milestone[] SubMilestones
		{
			get { return subMilestones; }
			set { subMilestones = value; }
		}
		#endregion

		private Milestone[] prerequisites = new Milestone[]{};
		/// <summary>
		/// Gets/sets the postrequisites to this milestone.
		/// </summary>
		// [IgnoreProperty()]
		[Reference(MirrorPropertyName="Postrequisites")]
		public Milestone[] Prerequisites
		{
			get { return postrequisites; }
			set
			{
				postrequisites = value;
			}
		}
		
	
		private Milestone[] postrequisites = new Milestone[]{};
		/// <summary>
		/// Gets/sets the postrequisites to this milestone.
		/// </summary>
		// [IgnoreProperty()]
		[Reference(MirrorPropertyName="Prerequisites")]
		public Milestone[] Postrequisites
		{
			get { return postrequisites; }
			set
			{
				postrequisites = value;
			}
		}

		private Task[] tasks = new Task[]{};
		/// <summary>
		/// Gets/sets the tasks within this task.
		/// </summary>
		[Reference(MirrorPropertyName="Milestones",
		          CountPropertyName="TotalTasks")]
		public Task[] Tasks
		{
			get { return tasks; }
			set { tasks = value; }
		}
		
		private int totalTasks = 0;
		/// <summary>
		/// Gets/sets the total number of tasks assigned to the milestone.
		/// </summary>
		public int TotalTasks
		{
			get { return totalTasks; }
			set { totalTasks = value; }
		}
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Milestone()
		{}

		/// <summary>
		/// Sets the ID of the milestone.
		/// </summary>
		/// <param name="milestoneID">The ID of the milestone.</param>
		public Milestone(Guid milestoneID)
		{
			ID = milestoneID;
		}

		public override string ToString()
		{
			return Title;
		}
		
	}
}
