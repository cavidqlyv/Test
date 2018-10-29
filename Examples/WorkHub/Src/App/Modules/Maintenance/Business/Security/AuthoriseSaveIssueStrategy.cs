using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Business.Security
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("AuthoriseSave", "Issue")]
	public class AuthoriseSaveIssueStrategy : AuthoriseSaveStrategy
	{
		public AuthoriseSaveIssueStrategy()
		{
		}
		
		public override bool IsAuthorised(IEntity entity)
		{
			// Anonymous users are authorised to save issues
			return true;
		}
		
		public override bool IsAuthorised(string shortTypeName)
		{
			// Anonymous users are authorised to save issues
			return true;
		}
	}
}
