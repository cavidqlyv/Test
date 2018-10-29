<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
    public override void InitializeInfo()
    {
    	MenuTitle = Language.Guide;
    	MenuCategory = Language.Planning + "/" + Language.Requirements;
    	ShowOnMenu=true;
    }
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Planning Guide</h1>
<h2>Introduction</h2>
<p>The SystemPlanner module helps teams to define, organize, maintain and share project requirements 
    specifications. Project requirements specifications should comprehensively explain what the project will be capable of doing and describe all possible interactions.</p>
    <p>Project requirements do not include any technical information about
    how the requirements are achieved unless those technical details are part of the fundamental requirements of the system. For example, the need to connect and communicate with existing systems using a specific protocol or technology may be included in requirements despite the information being technical in nature.
    </p>
<p>Project requirements specifications can be accessed via XML and be 
    displayed on other web sites, or consumed by other development and/or business systems.</p>
<p>The features include:
<ul>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Goal") %>' target="_blank">Goals</a> - The end goals/benefits of the project once it's ready for use.</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Scenario") %>' target="_blank">Scenarios</a> - Detailed, step by step scenarios of the most common ways to use the project (once they're implemented).</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Feature") %>' target="_blank">Features</a> - The various parts of the system either physically or conceptually divided into sections based on the functionality involved.</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Action") %>' target="_blank">Actions</a> - Step by step descriptions of the actions that will be possible in the project.</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Actor") %>' target="_blank">Actors</a> - The types/roles of the users and other systems that will interact with the project.</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "ProjectEntity") %>' target="_blank">Entities</a> - The various data/business types that the project interacts with.</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Index", "Restraint") %>' target="_blank">Restraints</a> - The limitations and restrictions enforced for reasons of security, validation, etc.</li>
</ul>
</p>
<h2>Getting Started...</h2>
<p><i>Notes:
<ul>
<li>If you have not logged in you will need to do so by clicking <a href='<%= new UrlCreator().CreateUrl("SignIn", "User") %>' target="_blank">Sign In</a> at the top right of the page.</li>
<li>A project must be created and selected/activated (from the current project menu at top left) before planning data can be created.</li>
</ul>
</i></p>
<ol>
	<li><a href='<%= new UrlCreator().CreateUrl("Create", "Goal") %>' target="_blank">Create goals</a> for what the project will achieve.
		<ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Goal") %>' target="_blank">Goals</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Goal") %>' target="_blank">Create Goal</a> button.</li>
		</ul>
	</li>	
    <li><a href='<%= new UrlCreator().CreateUrl("Create", "Scenario") %>' target="_blank">Document common scenarios</a> for how the project will be used, along with the steps involved.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Scenario") %>' target="_blank">Scenarios</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Scenario") %>' target="_blank">Create Scenario</a> button.</li>
		</ul>
	</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Create", "Feature") %>' target="_blank">Define features</a> in the project to group organise related functionality.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Feature") %>' target="_blank">Features</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Feature") %>' target="_blank">Create Feature</a> button.</li>
		</ul>
	</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Create", "Actor") %>' target="_blank">Identify each type of actor/user</a> able to interact with the project.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Actor") %>' target="_blank">Actors</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Actor") %>' target="_blank">Create Actor</a> button.</li>
		</ul>
	</li>
    <li><a href='<%= new UrlCreator().CreateUrl("Create", "Action") %>' target="_blank">Document each of the possible actions</a> that the project can perform or be part of, along with the steps involved.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Action") %>' target="_blank">Actions</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Action") %>' target="_blank">Create Action</a> button.</li>
		</ul>
	</li>
    <li>
    	<a href='<%= new UrlCreator().CreateUrl("Create", "Restraint") %>' target="_blank">Define restraints</a> that limit or restrict certain actions under certain conditions.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "Restraint") %>' target="_blank">Restraints</a> on the menu (left)</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Restraint") %>' target="_blank">Create Restraint</a> button.</li>
		</ul>
	</li>
    <li>
    	<a href='<%= new UrlCreator().CreateUrl("Create", "ProjectEntity") %>' target="_blank">Outline conceptual entities</a> that the project will deal with (such as data/business objects) along with the corresponding proeprties.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("Index", "ProjectEntity") %>' target="_blank">Entities</a> on the menu (left)</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "ProjectEntity") %>' target="_blank">Create Entity</a> button.</li>
		</ul>
	</li>
    <li>
    	<a href='<%= new UrlCreator().CreateUrl("PlanningOverview") %>' target="_blank">View the planning overview</a> to put the project and its plans into perspective.
    <ul>
		<li>Click Planning -> Requirements -> <a href='<%= new UrlCreator().CreateUrl("PlanningOverview") %>' target="_blank">Overview</a> on the menu (left).</li>
		</ul>
	</li>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>