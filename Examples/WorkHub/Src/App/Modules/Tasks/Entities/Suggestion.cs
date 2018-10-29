using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Entities
{
    /// <summary>
    /// Represents a suggestion.
    /// </summary>
    [Serializable]
    public class Suggestion : BaseAuthoredEntity, IProjectItem, ISimple
    {
        private string subject = String.Empty;
        /// <summary>
        /// Gets/sets the subject of the suggestion.
        /// </summary>
        public string Subject
        {
            get { return subject; }
            set { subject = value; 
            }
        }

        private string description = String.Empty;
        /// <summary>
        /// Gets/sets the email address of the person who reported the email.
        /// </summary>
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        
        private string authorName = String.Empty;
        /// <summary>
        /// Gets/sets the name of the person who reported the suggestion.
        /// </summary>
        public string AuthorName
        {
            get { return authorName; }
            set { authorName = value; }
        }


        private string authorEmail = String.Empty;
        /// <summary>
        /// Gets/sets the email address of the person who reported the email.
        /// </summary>
        public string AuthorEmail
        {
            get { return authorEmail; }
            set { authorEmail = value; }
        }

        private DateTime datePosted;
        /// <summary>
        /// Gets/sets the date that the suggestion was posted.
        /// </summary>
        public DateTime DatePosted
        {
            get { return datePosted; }
            set { datePosted = value; }
        }

        private DateTime dateImplemented;
        /// <summary>
        /// Gets/sets the date that the suggestion was implemented.
        /// </summary>
        public DateTime DateImplemented
        {
            get { return dateImplemented; }
            set { dateImplemented = value; }
        }

        private string applicationVersion = String.Empty;
        /// <summary>
        /// Gets/sets the version of the application that the suggestion was found in.
        /// </summary>
        public string ApplicationVersion
        {
            get { return applicationVersion; }
            set { applicationVersion = value; }
        }

        private bool needsReply;
        /// <summary>
        /// Gets/sets a flag indicating whether the reporter expects a reply regarding the suggestion.
        /// </summary>
        public bool NeedsReply
        {
            get { return needsReply; }
            set { needsReply = value; }
        }

        private SuggestionStatus status = SuggestionStatus.Pending;
        /// <summary>
        /// Gets/sets the status of the suggestion.
        /// </summary>
        public SuggestionStatus Status
        {
            get { return status; }
            set { status = value; }
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

        private Task[] tasks = new Task[]{};
        /// <summary>
        /// Gets/sets the tasks of this suggestion.
        /// </summary>
        [Reference(MirrorPropertyName="Suggestions",
                  CountPropertyName="TotalTasks")]
        //[XmlIgnore()]
        public Task[] Tasks
        {
            get { return tasks; }
            set
            {
                tasks = value;
            }
        }
        
        private int totalTasks;
        /// <summary>
        /// Gets/sets the total number of tasks assigned to this suggestion.
        /// </summary>
        public int TotalTasks
        {
        	get { return totalTasks; }
        	set { totalTasks = value; }
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
		
		private int implementedVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of votes indicating that the suggestion has been implemented.
		/// </summary>
		public int ImplementedVotesBalance
		{
			get { return implementedVotesBalance; }
			set { implementedVotesBalance = value; }
		}
		
		private int totalImplementedVotes = 0;
		/// <summary>
		/// Gets/sets the total number of votes indicating that the suggestion has been implemented.
		/// </summary>
		public int TotalImplementedVotes
		{
			get { return totalImplementedVotes; }
			set { totalImplementedVotes = value; }
		}
		
        #region Constructors
        /// <summary>
        /// Empty constructor.
        /// </summary>
        public Suggestion()
        { }

        /// <summary>
        /// Sets the ID of the suggestion.
        /// </summary>
        /// <param name="suggestionID">The ID of the suggestion.</param>
        public Suggestion(Guid suggestionID)
        {
            ID = suggestionID;
        }
        #endregion
        
		public override string ToString()
		{
			return Subject;
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
