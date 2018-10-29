using System;

namespace SoftwareMonkeys.WorkHub.Entities
{
	/// <summary>
	/// Defines the interface of entities which can be associated with multiple projects.
	/// </summary>
	public interface IMultiProjectItem : IAuthored, ISimple
	{
		IProject[] Projects { get;set; }
	}
}
