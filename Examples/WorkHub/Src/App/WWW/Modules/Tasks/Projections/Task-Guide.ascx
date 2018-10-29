<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<h1>Tasks Guide</h1>
<h2>Introduction</h2>
<p>The TaskRoadmap module helps to organize and assign project tasks, divide them into sub tasks, and then define the various milestones, to form a detailed project work roadmap.</p>
<p>The the roadmap and the detailed breakdown of tasks available for anyone who needs to know what's going on.</p>
<p>The features include:
<ul>
<li>Suggestions - Feedback can be posted about projects by users and anonymous visitors.</li>
<li>Task list - An archive of all tasks that need to be completed in relation to the project.</li>
<li>Milestones - Definable points along the project life cycle such as releases, versions, sprints or whatever suits the project.</li>
<li>Roadmap - An overview of the project milestones and the tasks required to reach them.</li>
</ul>
</p>
<h2>Getting Started...</h2>
<p><i>Notes:
<ul>
<li>If you have not logged in you will need to do so by clicking "Sign in" at the top right of the page.</li>
<li>A project must be created and selected/activated (from the current project menu at top left) before planning data can be created.</li>
<li>Exception: These restrictions do not apply to posting suggestions; suggestions can be posted by anonymous visitors and don't require a current project to be selected (though it is recommended where applicable).</li>
</ul>
</i></p>
<ol>
<li>Publish the "post suggestion" link
    <ol>
        <li>Click Feedback -> <a href='<%= Request.ApplicationPath + "/Suggestion/Index.aspx" %>' target="_blank">Suggestions</a> on the menu on the left.</li>
        <li>Click the <a href='<%= Request.ApplicationPath + "/Suggestion/ViewLinkInfo.aspx" %>' target="_blank">Link Info</a> button</li>
		<li>If the link is for a specific project then ensure that it's selected/activated in the current project list.</li>
		<li>Publish the post suggestion link where it's easy for users of your project(s) to follow it</li>
		<li>Anyonymous or identified/registered users can quickly and easily post suggestions/feedback by following the link</li>
    </ol>
</li>
<li>Post suggestions
    <ol>
        <li>Click Feedback -> <a href='<%= Request.ApplicationPath + "/Suggestion/Index.aspx" %>' target="_blank">Suggestions</a> on the menu on the left.</li>
        <li>Click the Post Suggestion button</li>
        <li>Fill out the form and click Save.</li>
    </ol>
</li>
    <li>Define and order project milestones
        <ol>
            <li>Click Development -&gt; <a href='<%= Request.ApplicationPath + "/Milestone/Index.aspx" %>' target="_blank">Milestones</a> on the menu to the left.</li>
            <li>Click the Create Milestone button</li>
            <li>Fill out the form.</li>
            <li>If the milestone includes any existing tasks then select them in the list.</li>
            <li>Click Save.</li>
            <li>If necessary, click move the milestone into place using the Up and Down 
                links on the index.</li>
        </ol>
    </li>
    <li>View project roadmap<ol>
            <li>Click Development -&gt; <a href='<%= Request.ApplicationPath + "/Roadmap/View.aspx" %>' target="_blank">Roadmap</a> on the menu to the left.</li>
            <li>Browse the roadmap</li>
            <li>Click a task or a milestone to view more information.</li>
        </ol>
    </li>
	<li>Continue using other modules to add data to your project
		<ol>
			<li><a href='<%= Request.ApplicationPath + "/Guide.aspx" %>'>Back to index</a></li>
		</ol>
	</li>
</ol>

