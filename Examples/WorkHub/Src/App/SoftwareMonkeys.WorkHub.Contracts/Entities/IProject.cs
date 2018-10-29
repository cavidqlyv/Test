using System;

namespace SoftwareMonkeys.WorkHub.Entities
{
	/// <summary>
	/// Defines the interface of all project entities (from either the default or custom module).
	/// </summary>
	public interface IProject : IEntity, ISimple
	{
		string Name { get;set; }
		string Summary { get;set; }
		string CurrentVersion { get;set; }
		
		bool HasManager(Guid userID);
		bool HasContributor(Guid userID);
	}
}
