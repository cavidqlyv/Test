<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
  public override void InitializeInfo()
  {
  		MenuTitle = Language.Guide;
  		MenuCategory = Language.Development;
	  	ShowOnMenu = true;
  }    
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Roadmap Guide</h1>
<h2>Introduction</h2>
<p>The TaskRoadmap module helps to organize and assign project tasks, divide them into sub tasks, and then define the various milestones, to form a detailed project work roadmap.</p>
<p>The the roadmap and the detailed breakdown of tasks available for anyone who needs to know what's going on.</p>
<p>The features include:
<ul>
<li><a href='<%= new UrlCreator().CreateUrl("Index", "Suggestion") %>' target="_blank">Suggestions</a> - Feedback can be posted about projects by users and anonymous visitors.</li>
<li><a href='<%= new UrlCreator().CreateUrl("Index", "Task") %>' target="_blank">Tasks</a> - An archive of all tasks that need to be completed in relation to the project.</li>
<li><a href='<%= new UrlCreator().CreateUrl("Index", "Milestone") %>' target="_blank">Milestones</a> - Definable points along the project life cycle such as releases, versions, sprints or whatever suits the project.</li>
<li><a href='<%= new UrlCreator().CreateUrl("Roadmap") %>' target="_blank">Roadmap</a> - An overview of the project milestones and the tasks required to reach them.</li>
</ul>
</p>
<h2>Getting Started...</h2>
<p><i>Notes:
<ul>
<li>If you have not logged in you will need to do so by clicking <a href='<%= new UrlCreator().CreateUrl("SignIn", "User") %>' target="_blank">Sign In</a> at the top right of the page.</li>
<li>A project must be created and selected/activated (from the current project menu at top left) before planning data can be created.</li>
<li>Exception: These restrictions do not apply to posting suggestions; suggestions can be posted by anonymous visitors and don't require a current project to be selected (though it is recommended where applicable).</li>
</ul>
</i></p>
<ol>
<li>Publish the "post suggestion" link
    <ol>
        <li>Click Feedback -> <a href='<%= new UrlCreator().CreateUrl("Index", "Suggestion") %>' target="_blank" id="IndexSuggestionsLink1">Suggestions</a> on the menu on the left.</li>
        <li>Click the <a href='<%= new UrlCreator().CreateUrl("ViewLinkInfo", "Suggestion") %>' target="_blank" id="SuggestionLinkInfoLink">Link Info</a> button.</li>
		<li>If the link is for a specific project then ensure that it's selected/activated in the current project list.</li>
		<li>Publish the post suggestion link where it's easy for users of your project(s) to follow it.</li>
		<li>Anyonymous or identified/registered users can quickly and easily post suggestions/feedback by following the link.</li>
    </ol>
</li>
<li>Post suggestions
    <ol>
        <li>Click Feedback -> <a href='<%= new UrlCreator().CreateUrl("Index", "Suggestion") %>' target="_blank" id="IndexSuggestionsLink2">Suggestions</a> on the menu (left).</li>
        <li>Click the <a href='<%= new UrlCreator().CreateUrl("Post", "Suggestion") %>' target="_blank" id="PostSuggestionLink">Post Suggestion</a> button.</li>
    </ol>
</li>
    <li>Create and assign tasks
        <ol>
            <li>Click Development -&gt; <a href='<%= new UrlCreator().CreateUrl("Index", "Task") %>' target="_blank" id="IndexTasksLink">Tasks</a> on the menu (left).</li>
            <li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Task") %>' target="_blank" id="CreateTaskLink">Create Task</a> button.</li>
            <li>Complete the form.</li>
        </ol>
    </li>
    <li>Define milestones
        <ol>
            <li>Click Development -&gt; <a href='<%= new UrlCreator().CreateUrl("Index", "Milestone") %>' target="_blank" id="IndexMilestonesLink">Milestones</a> on the menu (left).</li>
            <li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Milestone") %>' target="_blank" id="IndexMilestoneLink">Create Milestone</a> button.</li>
            <li>Complete the form.</li>
        </ol>
    </li>
    <li>Re-order project milestones if necessary
        <ol>
            <li>Click Development -&gt; <a href='<%= new UrlCreator().CreateUrl("Index", "Milestone") %>' target="_blank" id="IndexMilestonesLink">Milestones</a> on the menu (left).</li>
            <li>Click the Up or Down links to re-position milestones.</li>
        </ol>
    </li>
    <li>View project roadmap
    <ol>
            <li>Click Development -&gt; <a href='<%= new UrlCreator().CreateUrl("Roadmap") %>' target="_blank" id="RoadmapLink">Roadmap</a> on the menu (left).</li>
            <li>Browse the milestones and corresponding tasks in the roadmap.</li>
        </ol>
    </li>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>