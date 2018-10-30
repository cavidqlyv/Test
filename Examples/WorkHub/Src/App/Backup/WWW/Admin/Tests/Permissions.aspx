<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="Backup" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="System.Xml" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import Namespace="System.Reflection" %>
<script runat="server">

private void Page_Load(object sender, EventArgs e)
{
	using (LogGroup logGroup = LogGroup.Start("Testing the permissions/security checks when editing a restricted project.", NLog.LogLevel.Debug))
	{
		using (Batch batch = BatchState.StartBatch())
		{
			CreateTestProjects(1);
			
			User user = CreateTestUser(1);
			
			LogIn(user);
			
			bool exceptionOccurred = false;
			
			//try{
			
			EditRestrictedProject();
			//}
			
		}
	}
}

private void EditRestrictedProject()
{
	Project[] projects = IndexStrategy.New<Project>().Index<Project>();
	
	if (projects.Length == 0)
		throw new Exception("No projects found. Create at least one project before calling this function.");
	
	Project project = projects[0];
	
	project.Name = "Edit Worked";
	
	UpdateStrategy.New<Project>().Update(project);
}

private void LogIn(User user)
{
	Authentication.SetAuthenticatedUsername(user.Username);
}

private void CreateTestUsers(int count)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestUser(i);
	}
}

private User CreateTestUser(int number)
{

	User user = new User();
	user.ID = Guid.NewGuid();
	user.FirstName = "Test #" + number.ToString();
	user.LastName = "User #" + number.ToString();
	user.Username = "TestUser" + number.ToString ();
	user.Password = Crypter.EncryptPassword("pass");
	user.Email = "test" + number.ToString() + "@softwaremonkeys.net";
	user.IsApproved = true;
	
	SaveStrategy.New<User>().Save(user);
	
	return user;
}

private void CreateTestProjects(int count)
{
	using (LogGroup logGroup = LogGroup.Start("Creating " + count + " mock projects.", NLog.LogLevel.Debug))
	{
		for (int i = 1; i <= count; i++)
		{
			CreateTestProject(i);
		}
	}
}

private void CreateTestProject(int number)
{
	using (LogGroup logGroup = LogGroup.Start("Creating test project #" + number, NLog.LogLevel.Debug))
	{
		Project project = new Project();
		project.ID = Guid.NewGuid();
		project.Name = "Test Project #" + number.ToString();
		project.Summary = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
		project.MoreInfo = "More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info ";
		project.CompanyName = "Test Company " + number.ToString();
		project.CurrentVersion = "1.0.0.1";
		
		LogWriter.Debug("Project name: " + project.Name);
		
		SaveStrategy.New<Project>().Save(project);
		
		// IMPORTANT: All types must implement IProjectItem
		string[] relatedTypes = new string[] {
			//"Feature",
			"Goal"
			//"Action",
			//"Actor",
			//"Scenario",
			//"ProjectEntity",
			//"Restraint",
			//"Task",
			//"Suggestion",
			//"Milestone",
			//"Issue",
			//"Bug",
			//"Solution",
			};
		
		CreateTestEntities(relatedTypes, 1, project);
	}
}

private void CreateTestEntities(string[] typeNames, int count, Project project)
{
	using (LogGroup logGroup = LogGroup.Start("Creating mock entities for project '" + project.Name + "'.", NLog.LogLevel.Debug))
	{
		foreach (string name in typeNames)
		{
			using (LogGroup logGroup2 = LogGroup.Start("Creating mock entities of type '" + name + "'.", NLog.LogLevel.Debug))
			{
				for (int i = 1; i <= count; i++)
				{
					CreateTestEntity(name, i, project);
				}
			}
		}
	}
}

private void CreateTestEntity(string typeName, int number, Project project)
{
	using (LogGroup logGroup = LogGroup.Start("Creating mock entity #" + number + " of type " + typeName + ".", NLog.LogLevel.Debug))
	{
		IProjectItem entity = (IProjectItem)CreateStrategy.New(typeName, false).Create();
		entity.ID = Guid.NewGuid();
		entity.Title = "Test " + typeName + " #" + number.ToString();
		entity.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
		entity.Project = project;
		
		LogWriter.Debug("Entity title: " + entity.Title);
		
		SaveStrategy.New(typeName).Save(entity);
	}
}
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
Done
</asp:Content>

