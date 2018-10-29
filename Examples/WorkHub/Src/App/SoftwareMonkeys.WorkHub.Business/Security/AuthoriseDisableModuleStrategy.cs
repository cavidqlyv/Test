using System;
using SoftwareMonkeys.WorkHub.Business;

namespace SoftwareMonkeys.WorkHub.Business.Security
{
	[Strategy("AuthoriseDisable", "Module")]
	[Strategy("AuthoriseDisable", "IModuleContext")]
	public class AuthoriseDisableModuleStrategy : AuthoriseEnableModuleStrategy
	{
	}
}
