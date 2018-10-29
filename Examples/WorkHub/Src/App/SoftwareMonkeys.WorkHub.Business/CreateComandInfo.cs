using System;

namespace SoftwareMonkeys.WorkHub.Business
{
	/// <summary>
	/// 
	/// </summary>
	public class CreateComandInfo : CommandInfo
	{
		public CreateComandInfo(string typeName) : base("Create", typeName, "Save")
		{}
	}
}
