using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business.Security
{
	/// <summary>
	/// Authorises reference between an suggestion and associated project.
	/// </summary>
	[AuthoriseReferenceStrategy("Suggestion", "Project", "Project", "")]
	public class AuthoriseReferenceSuggestionProjectStrategy : BaseAuthoriseReferenceStrategy
	{
		public AuthoriseReferenceSuggestionProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// Anyone can post a suggestion without having to be authenticated
			return true;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			// Anyone can post a suggestion without having to be authenticated
			return true;
		}
	}
}
