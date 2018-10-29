using System;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Business
{
	/// <summary>
	/// Sets the default property values of each new entity immediately after it's created.
	/// </summary>
	[Reaction("Create", "IEntity")]
	public class CreateEntityReaction : BaseCreateReaction
	{
		public CreateEntityReaction()
		{
		}
		
		public override void React(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			entity.ID = Guid.NewGuid();
			entity.DateCreated = DateTime.Now;	
			
			base.React(entity);
		}
	}
}
