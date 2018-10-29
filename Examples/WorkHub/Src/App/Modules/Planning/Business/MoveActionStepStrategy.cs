using System;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Business
{
	/// <summary>
	/// Used to move an action step up or down in the list.
	/// </summary>
	[Strategy("Move", "ActionStep")]
	public class MoveActionStepStrategy : BaseStrategy
	{
		public MoveActionStepStrategy()
		{
		}
		
		public void MoveUp(Guid stepID)
		{
			ActionStep step = RetrieveStrategy.New<ActionStep>().Retrieve<ActionStep>("ID", stepID);
			
			if (step == null)
				throw new ArgumentException("Action step not found with the provided ID.");
			
			ActivateStrategy.New<ActionStep>().Activate(step);
			
			if (step.Parent == null)
				throw new InvalidOperationException("The loaded action step doesn't have a parent action associated with it.");
			
			ActivateStrategy.New<ActionStep>().Activate(step.Parent);
			
			if (step.Parent.Steps == null)
				step.Parent.Steps = new ActionStep[]{};
			//step.Action = GetAction(step.ActionID);
			//step.Action.Steps = GetActionSteps(step.Action.StepIDs);
			
			step.Parent.Steps = Collection<ActionStep>.Sort(step.Parent.Steps, "StepNumberAscending");

			int stepIndex = step.StepNumber - 1; // Adjust to index

			if (step.StepNumber <= 0)
			{
				throw new InvalidOperationException("The specified step is already at the top of the list.");
			}	


			ActionStep previousStep = step.Parent.Steps[stepIndex - 1];
			
			ActivateStrategy.New<ActionStep>().Activate(previousStep);
			
			if (previousStep.Parent == null)
				throw new InvalidOperationException("The previous action step doesn't have a parent action associated with it.");
			
			//DataAccess.Data.Activator.Activate(previousStep);
			// TODO: Remove if not necessary
			//previousStep.Parent = GetAction(previousStep.ParentID);

			if (step != null && previousStep != null)
			{
				step.StepNumber = step.StepNumber - 1;
				previousStep.StepNumber = previousStep.StepNumber + 1;
			}

			UpdateStrategy.New<ActionStep>().Update(step);
			UpdateStrategy.New<ActionStep>().Update(previousStep);
		}
		
		
		
		public void MoveDown(Guid stepID)
		{
			
			ActionStep step = RetrieveStrategy.New<ActionStep>().Retrieve<ActionStep>("ID", stepID);
			
			if (step == null)
				throw new ArgumentException("Action step not found with the provided ID.");
			
			ActivateStrategy.New<ActionStep>().Activate(step);
			
			if (step.Parent == null)
				throw new InvalidOperationException("The loaded action step doesn't have a parent action associated with it.");
			
			ActivateStrategy.New<ActionStep>().Activate(step.Parent);
			
			if (step.Parent.Steps == null)
				step.Parent.Steps = new ActionStep[]{};
			//step.Action = GetAction(step.ActionID);
			//step.Action.Steps = GetActionSteps(step.Action.StepIDs);
			
			step.Parent.Steps = Collection<ActionStep>.Sort(step.Parent.Steps, "StepNumberAscending");

			int stepIndex = step.StepNumber - 1; // Adjust to index

			if (step.StepNumber > step.Parent.Steps.Length)
			{
				throw new InvalidOperationException("The specified step is already at the bottom of the list.");
			}

			ActionStep nextStep = step.Parent.Steps[stepIndex + 1];
			
			ActivateStrategy.New<ActionStep>().Activate(nextStep);
			
			if (nextStep.Parent == null)
				throw new InvalidOperationException("The next action step doesn't have a parent action associated with it.");

			if (step != null && nextStep != null)
			{
				step.StepNumber = step.StepNumber + 1;
				nextStep.StepNumber = nextStep.StepNumber - 1;
			}

			UpdateStrategy.New<ActionStep>().Update(step);
			UpdateStrategy.New<ActionStep>().Update(nextStep);
		}
		
		static public MoveActionStepStrategy New()
		{
			return new MoveActionStepStrategy();
		}
	}
}
