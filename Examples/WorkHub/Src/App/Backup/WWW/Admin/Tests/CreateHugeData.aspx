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
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="System.Xml" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">

private void Page_Load(object sender, EventArgs e)
{
	using (Batch batch = BatchState.StartBatch())
	{
		CreateTestUsers(1);
		CreateTestProjects(1);
	}
}

private void CreateTestUsers(int count)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestUser(i);
	}
}

private void CreateTestUser(int number)
{

	User user = new User();
	user.ID = Guid.NewGuid();
	user.FirstName = "Test #" + number.ToString();
	user.LastName = "User #" + number.ToString();
	user.Username = "TestUser" + number.ToString();
	user.Password = Crypter.EncryptPassword("pass");
	user.Email = "test" + number.ToString() + "@softwaremonkeys.net";
	user.IsApproved = true;
	
	SaveStrategy.New<User>().Save(user);
}

private void CreateTestProjects(int count)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestProject(i);
	}
}

private void CreateTestProject(int number)
{
	Project project = new Project();
	project.ID = Guid.NewGuid();
	project.Name = "Test Project #" + number.ToString();
	project.Summary = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	project.MoreInfo = "More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info More info ";
	project.CompanyName = "Test Company " + number.ToString();
	project.CurrentVersion = "1.0.0.1";
	
	if (number == 2)
		project.Visibility = ProjectVisibility.Private;
	
	SaveStrategy.New<Project>().Save(project);
	
	// IMPORTANT: All types must implement IProjectItem
	string[] relatedTypes = new string[] {
		"Feature",
		"Goal",
		"Action",
		"Actor",
		"Scenario",
		"ProjectEntity",
		"Restraint",
		"Task",
		"Suggestion",
		"Milestone",
		"Issue",
		"Bug",
		"Solution"};
	
	CreateTestEntities(relatedTypes, 21, project);
	
}

private void CreateTestEntities(string[] typeNames, int count, Project project)
{
	foreach (string name in typeNames)
	{
		for (int i = 1; i <= count; i++)
		{
			CreateTestEntity(name, i, project);
		}
	}
}

private void CreateTestEntity(string typeName, int number, Project project)
{
	IProjectItem entity = (IProjectItem)CreateStrategy.New(typeName, false).Create();
	entity.ID = Guid.NewGuid();
	entity.Title = "Test " + typeName + " #" + number.ToString();
	entity.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	entity.Project = project;
	
	SaveStrategy.New<ProjectEntity>().Save(entity);
}
/*

private void CreateTestFeatures(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestFeature(i, project);
	}
}

private void CreateTestFeature(int number, Project project)
{
	Feature feature = new Feature();
	feature.ID = Guid.NewGuid();
	feature.Name = "Test Feature #" + number.ToString();
	feature.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	feature.Project = project;
	
	SaveStrategy.New<Feature>().Save(feature);
}

private void CreateTestGoals(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestGoal(i, project);
	}
}

private void CreateTestGoal(int number, Project project)
{
	Goal goal = new Goal();
	goal.ID = Guid.NewGuid();
	goal.Title = "Test Goal #" + number.ToString();
	goal.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	goal.Project = project;
	
	SaveStrategy.New<Goal>().Save(goal);
}


private void CreateTestActions(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestAction(i, project);
	}
}

private void CreateTestAction(int number, Project project)
{
	Action action = new Action();
	action.ID = Guid.NewGuid();
	action.Name = "Test Action #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	action.Project = project;
	
	SaveStrategy.New<Action>().Save(action);
}


private void CreateTestActors(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestActor(i, project);
	}
}

private void CreateTestActor(int number, Project project)
{
	Actor actor = new Actor();
	actor.ID = Guid.NewGuid();
	actor.Name = "Test Actor #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	actor.Project = project;
	
	SaveStrategy.New<Actor>().Save(actor);
}


private void CreateTestScenarios(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestScenario(i, project);
	}
}

private void CreateTestScenario(int number, Project project)
{
	Scenario scenario= new Scenario();
	scenario.ID = Guid.NewGuid();
	scenario.Name = "Test Scenario #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	scenario.Project = project;
	
	SaveStrategy.New<Scenario>().Save(scenario);
}

private void CreateTestRestraints(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestRestraint(i, project);
	}
}

private void CreateTestRestraint(int number, Project project)
{
	Restraint restraint = new Restraint();
	restraint.ID = Guid.NewGuid();
	restraint.Title = "Test Restraint #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	restraint.Project = project;
	
	SaveStrategy.New<Restraint>().Save(restraint);
}

private void CreateTestEntities(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestEntity(i, project);
	}
}

private void CreateTestEntity(int number, Project project)
{
	ProjectEntity entity = new ProjectEntity();
	entity.ID = Guid.NewGuid();
	entity.Name = "Test Entity #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	entity.Project = project;
	
	SaveStrategy.New<ProjectEntity>().Save(entity);
}

private void CreateTestTasks(int count, Project project)
{
	for (int i = 1; i <= count; i++)
	{
		CreateTestTask(i, project);
	}
}

private void CreateTestTask(int number, Project project)
{
	Task task = new Task();
	task.ID = Guid.NewGuid();
	task.Title = "Test Task #" + number.ToString();
	//action.Description = "Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary Test Summary";
	task.Project = project;
	task.Status = TaskStatus.Pending;
	
	SaveStrategy.New<Task>().Save(task);
}*/
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
Done
</asp:Content>

