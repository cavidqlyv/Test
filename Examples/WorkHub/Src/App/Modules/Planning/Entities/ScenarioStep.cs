using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents a scenario step.
    /// </summary>
    [Serializable]
    public class ScenarioStep : BaseEntity, ISubProjectItem
    {
        private string text;
        /// <summary>
        /// Gets/sets a short description of the step.
        /// </summary>
        public string Text
        {
            get { return text; }
            set { text = value; }
        }

        private Action action;
        /// <summary>
        /// Gets/sets the action that the step is associated with.
        /// </summary>
        [Reference]
        public Action Action
        {
            get { return action; }
            set { action = value; }
        }

        private string comments;
        /// <summary>
        /// Gets/sets additional comments about the step.
        /// </summary>
        public string Comments
        {
            get { return comments; }
            set { comments = value; }
        }

        private Scenario scenario;
        /// <summary>
        /// Gets/sets the scenario that the step belongs to.
        /// </summary>
        [Reference(MirrorPropertyName="Steps")]
        public Scenario Scenario
        {
            get { return scenario; }
            set { scenario = value; }
        }

        private int stepNumber = 0;
        /// <summary>
        /// Gets/sets the number of this step in relation to the whole scenario.
        /// </summary>
        public int StepNumber
        {
            get { return stepNumber; }
            set { stepNumber = value; }
        }
        
        IEntity ISubEntity.Parent
        {
        	get { return Scenario; }
        	set { Scenario = (Scenario)value; }
        }
        
        string ISubEntity.ParentPropertyName
        {
        	get { return "Scenario"; }
        }
        
        string ISubEntity.ParentTypeName
        {
        	get { return "Scenario"; }
        }
        
        string ISubEntity.ItemsPropertyName
        {
        	get { return "Steps"; }
        }
        
        int ISubEntity.Number
        {
        	get { return StepNumber; }
        	set { StepNumber = value; }
        }
        
        string ISubEntity.NumberPropertyName
        {
        	get { return "StepNumber"; }
        }
        
        
        #region Constructors
        /// <summary>
        /// Empty constructor.
        /// </summary>
        public ScenarioStep()
        { }

        /// <summary>
        /// Sets the ID of the step.
        /// </summary>
        /// <param name="stepID">The ID of the step.</param>
        public ScenarioStep(Guid stepID)
        {
            ID = stepID;
        }
        #endregion
        
    }
}
