using System;

namespace SoftwareMonkeys.WorkHub.Entities
{
	/// <summary>
	/// Defines the interface of all entities that are part of a project.
	/// </summary>
	public interface IProjectItem : IAuthored, ISimple
	{
		IProject Project { get;set; }
	}
}
