using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Entities
{
    /// <summary>
    /// Represents an action step.
    /// </summary>
    [Serializable]
    public class ActionStep : BaseEntity, ISubProjectItem
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

        private Action parent;
        /// <summary>
        /// Gets/sets the action that the step belongs to.
        /// </summary>
        [Reference(MirrorPropertyName="Steps")]
        public Action Parent
        {
            get { return parent; }
            set { parent = value; }
        }

        private int stepNumber = 0;
        /// <summary>
        /// Gets/sets the number of this step in relation to the whole action.
        /// </summary>
        public int StepNumber
        {
            get { return stepNumber; }
            set { stepNumber = value; }
        }
        
        IEntity ISubEntity.Parent
        {
        	get { return ((ActionStep)this).Parent; }
        	set { Parent = (Action)value; }
        }
        
        string ISubEntity.ParentPropertyName
        {
        	get { return "Parent"; }
        }
        
        string ISubEntity.ParentTypeName
        {
        	get { return "Action"; }
        }
        
        string ISubEntity.ItemsPropertyName
        {
        	get { return "Steps"; }
        }
        
        string ISubEntity.NumberPropertyName
        {
        	get { return "StepNumber"; }
        }
        
        int ISubEntity.Number
        {
        	get { return StepNumber; }
        	set { StepNumber = value; }
        }
        
        #region Constructors
        /// <summary>
        /// Empty constructor.
        /// </summary>
        public ActionStep()
        { }

        /// <summary>
        /// Sets the ID of the step.
        /// </summary>
        /// <param name="stepID">The ID of the step.</param>
        public ActionStep(Guid stepID)
        {
            ID = stepID;
        }
        #endregion

        public override string ToString()
        {
            return Text;
        }
        
    }
}
