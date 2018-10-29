using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Data;
using System.Collections;

namespace SoftwareMonkeys.WorkHub.Business
{
	/// <summary>
	/// Description of PrerequisiteSorter.
	/// </summary>
	public class PrerequisiteSorter
	{
		private string prerequisitesPropertyName;
		public string PrerequisitesPropertyName
		{
			get { return prerequisitesPropertyName; }
			set { prerequisitesPropertyName = value; }
		}
		
		public PrerequisiteSorter(string prerequisitesPropertyName)
		{
			PrerequisitesPropertyName = prerequisitesPropertyName;
		}
		
		public T[] Sort<T>(T[] entities)
			where T : IEntity
		{
			//ReferenceValidator validator = new ReferenceValidator();
			//validator.CheckForCircularReference(entities);
			
			return null;
		}
		
	}
}
