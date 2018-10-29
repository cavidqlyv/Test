using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("AuthoriseSave", "Suggestion")]
	public class AuthoriseSaveSuggestionStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveSuggestionStrategy()
		{
		}
		
		public override bool IsAuthorised(IEntity entity)
		{
			if (entity is Suggestion)
			{
				// Suggestions can be saved anonymously
				return true;
			}
			else
				throw new ArgumentException("Invalid type: " + entity.ShortTypeName);
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			if (shortTypeName == "Suggestion")
			{
				// Suggestions can be saved anonymously
				return true;
			}
			else
				throw new ArgumentException("Invalid type: " + shortTypeName);
		}
	}
}
