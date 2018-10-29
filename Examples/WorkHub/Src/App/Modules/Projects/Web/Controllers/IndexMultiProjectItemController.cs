using System;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using SoftwareMonkeys.WorkHub.Web.State;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.Controllers
{
	/// <summary>
	///
	/// </summary>
	[Controller("Index", "IMultiProjectItem")]
	public class IndexMultiProjectItemController : IndexController
	{
		public override SoftwareMonkeys.WorkHub.Entities.IEntity[] PrepareIndex()
		{
			IEntity[] entities = new IEntity[]{};
			if (ProjectsState.ProjectSelected)
				entities = Indexer.IndexWithReference("Projects", "Project", ProjectsState.ProjectID);
			else
				entities = Indexer.Index();
			
			entities = Authorise(entities);
			
			return entities;
		}
		
		public override SoftwareMonkeys.WorkHub.Entities.IEntity[] PrepareIndex(string propertyName, object propertyValue)
		{
			FilterGroup filterGroup = DataAccess.Data.CreateFilterGroup();
			
			Type type = EntityState.GetType(Command.TypeName);
			
			if (ProjectsState.ProjectSelected)
			{
				ReferenceFilter referenceFilter = DataAccess.Data.CreateReferenceFilter();
				referenceFilter.AddType(type);
				referenceFilter.PropertyName = "Projects";
				referenceFilter.ReferenceType = EntityState.GetType("Project");
				referenceFilter.ReferencedEntityID = ProjectsState.ProjectID;
				
				filterGroup.Add(referenceFilter);
			}
			
			PropertyFilter propertyFilter = DataAccess.Data.CreatePropertyFilter();
			propertyFilter.AddType(type);
			propertyFilter.PropertyName = propertyName;
			propertyFilter.PropertyValue = propertyValue;
			
			filterGroup.Add(propertyFilter);
			
			IEntity[] entities = Indexer.Index(filterGroup);
			
			entities = Authorise(entities);
			
			return entities;
		}
		
		public override IEntity[] PrepareIndex(System.Collections.Generic.Dictionary<string, object> filterValues)
		{
			FilterGroup filterGroup = DataAccess.Data.CreateFilterGroup();
			
			Type type = EntityState.GetType(Command.TypeName);
			
			if (ProjectsState.ProjectSelected)
			{
				ReferenceFilter referenceFilter = DataAccess.Data.CreateReferenceFilter();
				referenceFilter.AddType(type);
				referenceFilter.PropertyName = "Projects";
				referenceFilter.ReferenceType = EntityState.GetType("Project");
				referenceFilter.ReferencedEntityID = ProjectsState.ProjectID;
				
				filterGroup.Add(referenceFilter);
			}
			
			foreach (string key in filterValues.Keys)
			{
				PropertyFilter propertyFilter = DataAccess.Data.CreatePropertyFilter();
				propertyFilter.AddType(type);
				propertyFilter.PropertyName = key;
				propertyFilter.PropertyValue = filterValues[key];
				
				filterGroup.Add(propertyFilter);
			}
			
			IEntity[] entities = Indexer.Index(filterGroup);
			
			entities = Authorise(entities);
			
			return entities;
		}
		
	}
}
