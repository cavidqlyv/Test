using System;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business.Security
{
	/// <summary>
	/// Authorises reference between an issue and associated project.
	/// </summary>
	[AuthoriseReferenceStrategy("Issue", "Project", "Project", "")]
	public class AuthoriseReferenceIssueProjectStrategy : BaseAuthoriseReferenceStrategy
	{
		public AuthoriseReferenceIssueProjectStrategy()
		{
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// Anyone can report an issue without having to be authenticated
			return true;
		}
		
		public override bool IsAuthorised(SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			// Anyone can report an issue without having to be authenticated
			return true;
		}
	}
}
