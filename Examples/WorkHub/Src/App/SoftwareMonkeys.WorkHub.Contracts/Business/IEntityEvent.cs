using System;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Business
{
	/// <summary>
	/// Defines the interface of all entity events.
	/// </summary>
	public interface IEntityEvent
	{
		IEntity Entity {get;set;}
		string EventName {get;set;}
	}
}
