using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Activate", "Scenario")]
	[Serializable]
	public class ActivateScenarioStrategy : ActivateStrategy
	{
		public ActivateScenarioStrategy()
		{
		}
		
		#region Activate functions
		public override void Activate(IEntity entity)
		{
			base.Activate(entity);
			
			if (entity is Scenario)
			{
				Scenario scenario = (Scenario)entity;
				
				scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
				
				scenario.RefreshStepNumbers();
			}
			else
				throw new ArgumentException("Entity is not a scenario: " + entity.GetType().FullName);
		}
		
		public override void Activate(IEntity[] entities)
		{
			foreach (IEntity entity in entities)
			{
				Activate(entity);
			}
		}
		
		public override void Activate(IEntity[] entities, string propertyName)
		{
			if (entities  == null)
				throw new ArgumentNullException("entities");
			
			foreach (IEntity entity in entities)
			{
				Activate(entity, propertyName);
			}
		}
		
		
		public override void Activate(IEntity entity, string propertyName)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			base.Activate(entity, propertyName);
			
			if (entity is Scenario)
			{
				Scenario scenario = (Scenario)entity;
				
				if (propertyName == "Steps")
				{
					scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
					
					scenario.RefreshStepNumbers();
				}
			}
			else
				throw new ArgumentException("Entity is not a scenario: " + entity.GetType().FullName);
		}
		
		/*public override void Activate(IEntity[] entities, int depth)
		{
			Activate(Collection<Scenario>.ConvertAll(entities), depth);
		}*/
		
		public override void Activate(IEntity entity, int depth)
		{
			if (entity == null)
				throw new ArgumentNullException("entity");
			
			base.Activate(entity, depth);
			
			if (entity is Scenario)
			{
				Scenario scenario = (Scenario)entity;
				
				
				scenario.Steps = Collection<ScenarioStep>.Sort(scenario.Steps, "StepNumberAscending");
				
				scenario.RefreshStepNumbers();
				
			}
			else
				throw new ArgumentException("Entity is not a scenario: " + entity.GetType().FullName);
		}
		#endregion
	}
}
