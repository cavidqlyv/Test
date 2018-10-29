<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
  public override void InitializeInfo()
  {
  		MenuTitle = Language.Guide;
  		MenuCategory = Language.Projects;
	  	ShowOnMenu = true;
  }    
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Projects Guide</h1>
<h2>Introduction</h2>
<p>The projects module is the centre of the project management suite. Data in other modules can be associated to specific projects and so they'll be organized/grouped accordingly.</p>
<p>Once a project is created it can be selected/activated using the menu at the top left of each page. Most pages will refresh (or redirect) to display information specific to the currently selected project.</p>
<h2>Getting Started...</h2>
<p><i>Note: If you have not logged in you will need to do so by clicking <a href='<%= new UrlCreator().CreateUrl("SignIn", "User") %>' target="_blank">Sign In</a> at the top right of the page.</i></p>
<ol>
	<li><a href='<%= Navigator.GetLink("Create", "Project") %>' target="_blank">Create a project</a>
		<ul>
			<li>
				Click Projects -> <a href='<%= Navigator.GetLink("Create", "Project") %>' target="_blank">Create</a> item on the menu.<br/>
			</li>
		</ul>
	</li>
	<li>Add more data to the project
		<ul>
			<li>Select a feature from the menu on the left</li>
			<li>Create data and it will be associated with the current selected project</li>
		</ul>
	</li>
	<li>Select your project to view related data (if not already selected)
		<ul>
			<li>Use the "Current Project" drop-down list (top left)</li>
		</ul>
	</li>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>