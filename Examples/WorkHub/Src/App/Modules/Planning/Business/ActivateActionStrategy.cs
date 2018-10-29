using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Activate", "Action")]
	[Serializable]
	public class ActivateActionStrategy : ActivateStrategy
	{
		public ActivateActionStrategy()
		{
		}
		
		#region Activate functions
		public override void Activate(IEntity[] entities)
		{
			Activate(Collection<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>.ConvertAll(entities));
		}
		
		
		public void Activate(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[] actions, string propertyName)
		{
			base.Activate(actions, propertyName);
			
			if (actions.GetType().GetElementType() == typeof(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action))
			{
				if (propertyName == "Steps")
				{
					foreach (SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action in actions)
					{
						action.Steps = Collection<ActionStep>.Sort(action.Steps, "StepNumberAscending");
					}
				}
			}
			
		}
		
		public void Activate(SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action[] actions, int depth)
		{
			base.Activate(actions, depth);
			
			foreach (SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action action in actions)
			{
					action.Steps = Collection<ActionStep>.Sort(action.Steps, "StepNumberAscending");
			}
		}
		#endregion
	}
}
