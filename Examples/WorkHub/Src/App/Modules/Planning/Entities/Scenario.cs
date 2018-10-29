using System;
using SoftwareMonkeys.WorkHub.Entities;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Collections.Generic;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents a scenario.
    /// </summary>
    [Serializable]
    public class Scenario : BaseAuthoredEntity, IProjectItem, ISimple
    {
        private string name;
        /// <summary>
        /// Gets/sets the name of the scenario.
        /// </summary>
        public string Name
        {
            get { return name; }
            set { name = value;
            }
        }

        private string description;
        /// <summary>
        /// Gets/sets a description of the scenario.
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
        /// Gets/sets the project version that the scenario should be available.
        /// </summary>
        public string ProjectVersion
        {
            get { return projectVersion; }
            set { projectVersion = value; }
        }

       private ScenarioStep[] steps = new ScenarioStep[]{};
        /// <summary>
        /// Gets/sets the associated steps.
        /// </summary>
        [Reference(MirrorPropertyName="Scenario")]
       public ScenarioStep[] Steps
        {
            get { return steps; }
            set
            {
                steps = value;
            }
        }

		private ISimple[] tasks = new ISimple[]{};
		[Reference(MirrorPropertyName="Scenarios", TypeName="Task")]
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
        public Scenario()
        { }

        /// <summary>
        /// Sets the ID of the scenario.
        /// </summary>
        /// <param name="scenarioID">The ID of the scenario.</param>
        public Scenario(Guid scenarioID)
        {
            ID = scenarioID;
        }
        #endregion

        /// <summary>
        /// Refreshes all the step numbers based on their position.
        /// </summary>
        public void RefreshStepNumbers()
        {
            if (Steps != null)
            {
                for (int i = 0; i < Steps.Length; i++)
                {
                    Steps[i].StepNumber = i + 1;
                }
            }
        }
    	
		string ISimple.Title {
			get {
				return Name;
			}
			set {
				Name = value;
			}
		}
        
        public override string ToString()
		{
			return Name;
    }

    }
}
