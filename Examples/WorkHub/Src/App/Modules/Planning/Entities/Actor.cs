using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents a actor.
    /// </summary>
    [Serializable]
    public class Actor : BaseAuthoredEntity, IProjectItem, ISimple
    {
        private string name;
        /// <summary>
        /// Gets/sets the name of the actor.
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value;
            }
        }

        private string description;
        /// <summary>
        /// Gets/sets a description of the actor.
        /// </summary>
        public string Description
        {
            get { return description; }
            set { description = value; }
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
        /// Gets/sets the version of the project that the actor is involved in.
        /// </summary>
        public string ProjectVersion
        {
            get { return projectVersion; }
            set { projectVersion = value; }
        }

        private Goal[] goals = new Goal[]{};
        /// <summary>
        /// Gets/sets the associated goals.
        /// </summary>
        [Reference(MirrorPropertyName="Actors")]
        //[XmlIgnore()]
        public Goal[] Goals
        {
            get { return goals; }
            set
            {
                goals = value;
            }
        }

        private Action[] actions = new Action[]{};
        /// <summary>
        /// Gets/sets the associated actions.
        /// </summary>
        [Reference(MirrorPropertyName="Actors")]
        public Action[] Actions
        {
            get { return actions; }
            set
            {
                actions = value;
            }
        }
        
        private Restraint[] restraints = new Restraint[]{};
        /// <summary>
        /// Gets/sets the associated actions.
        /// </summary>
        [Reference(MirrorPropertyName="Actors")]
        public Restraint[] Restraints
        {
            get { return restraints; }
            set
            {
                restraints = value;
            }
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
        public Actor()
        { }

        /// <summary>
        /// Sets the ID of the actor.
        /// </summary>
        /// <param name="actorID">The ID of the actor.</param>
        public Actor(Guid actorID)
        {
            ID = actorID;
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
    }
}
