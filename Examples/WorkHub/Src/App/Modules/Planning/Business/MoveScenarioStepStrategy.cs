using System;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Business
{
	/// <summary>
	/// Used to move a scenario step up or down in the list.
	/// </summary>
	[Strategy("Move", "ActionStep")]
	public class MoveScenarioStepStrategy : BaseStrategy
	{
		public MoveScenarioStepStrategy()
		{
		}
		
		public void MoveUp(Guid stepID)
		{
			ScenarioStep step = RetrieveStrategy.New<ScenarioStep>().Retrieve<ScenarioStep>("ID", stepID);
			
			if (step == null)
				throw new ArgumentException("Scenario step not found with the provided ID.");
			
			ActivateStrategy.New<ScenarioStep>().Activate(step);
			
			if (step.Scenario == null)
				throw new InvalidOperationException("The loaded scenario step doesn't have a parent scenario associated with it.");
			
			ActivateStrategy.New<ScenarioStep>().Activate(step.Scenario);
			
			if (step.Scenario.Steps == null)
				step.Scenario.Steps = new ScenarioStep[]{};
			//step.Scenario = GetScenario(step.ScenarioID);
			//step.Scenario.Steps = GetScenarioSteps(step.Scenario.StepIDs);
			
			step.Scenario.Steps = Collection<ScenarioStep>.Sort(step.Scenario.Steps, "StepNumberAscending");

			Scenario scenario = step.Scenario;
			
			scenario.RefreshStepNumbers();
			
			int stepIndex = step.StepNumber - 1; // Adjust to index

			if (step.StepNumber <= 0)
			{
				throw new InvalidOperationException("The specified step is already at the top of the list.");
			}	


			ScenarioStep previousStep = step.Scenario.Steps[stepIndex - 1];
			
			ActivateStrategy.New<ScenarioStep>().Activate(previousStep);
			
			if (previousStep.Scenario == null)
				throw new InvalidOperationException("The previous scenario step doesn't have a parent scenario associated with it.");
			
			//DataAccess.Data.Activator.Activate(previousStep);
			// TODO: Remove if not necessary
			//previousStep.Parent = GetScenario(previousStep.ParentID);

			if (step != null && previousStep != null)
			{
				step.StepNumber = step.StepNumber - 1;
				previousStep.StepNumber = previousStep.StepNumber + 1;
			}
			
			scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
			
			scenario.RefreshStepNumbers();

			UpdateStrategy.New<ScenarioStep>().Update(step);
			UpdateStrategy.New<ScenarioStep>().Update(previousStep);
		}
		
		
		
		public void MoveDown(Guid stepID)
		{
			
			ScenarioStep step = RetrieveStrategy.New<ScenarioStep>().Retrieve<ScenarioStep>("ID", stepID);
			
			if (step == null)
				throw new ArgumentException("Scenario step not found with the provided ID.");
			
			ActivateStrategy.New<ScenarioStep>().Activate(step);
			
			if (step.Scenario == null)
				throw new InvalidOperationException("The loaded scenario step doesn't have a parent scenario associated with it.");
			
			ActivateStrategy.New<ScenarioStep>().Activate(step.Scenario);
			
			if (step.Scenario.Steps == null)
				step.Scenario.Steps = new ScenarioStep[]{};
			//step.Scenario = GetScenario(step.ScenarioID);
			//step.Scenario.Steps = GetScenarioSteps(step.Scenario.StepIDs);
			
			step.Scenario.Steps = Collection<ScenarioStep>.Sort(step.Scenario.Steps, "StepNumberAscending");

			Scenario scenario = step.Scenario;
			
			scenario.RefreshStepNumbers();
			
			int stepIndex = step.StepNumber - 1; // Adjust to index

			if (step.StepNumber > step.Scenario.Steps.Length)
			{
				throw new InvalidOperationException("The specified step is already at the bottom of the list.");
			}

			ScenarioStep nextStep = step.Scenario.Steps[stepIndex + 1];
			
			ActivateStrategy.New<ScenarioStep>().Activate(nextStep);
			
			if (nextStep.Scenario == null)
				throw new InvalidOperationException("The next scenario step doesn't have a parent scenario associated with it.");

			if (step != null && nextStep != null)
			{
				step.StepNumber = step.StepNumber + 1;
				nextStep.StepNumber = nextStep.StepNumber - 1;
			}
			
			scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
			
			scenario.RefreshStepNumbers();

			UpdateStrategy.New<ScenarioStep>().Update(step);
			UpdateStrategy.New<ScenarioStep>().Update(nextStep);
		}
		
		static public MoveScenarioStepStrategy New()
		{
			return new MoveScenarioStepStrategy();
		}
	}
}
