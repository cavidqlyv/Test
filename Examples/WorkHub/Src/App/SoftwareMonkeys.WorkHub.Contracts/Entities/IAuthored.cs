using System;

namespace SoftwareMonkeys.WorkHub.Entities
{
	/// <summary>
	/// 
	/// </summary>
	public interface IAuthored : IEntity
	{
		IUser Author { get;set; }
		bool IsPublic { get;set; }
	}
}
