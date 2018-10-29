<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
    public override void InitializeInfo()
    {
    	MenuTitle = Language.Guide;
    	MenuCategory = Language.Maintenance;
    	ShowOnMenu=true;
    }
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Maintenance Guide</h1>
<h2>Introduction</h2>
<p>The RapidResolution module helps teams to manage issue reports, identify and track bugs, and to document and reuse solutions.</p>
<p>The features include:
<ul>
<li>Report and archive issues - Similar to tickets in a support system, issues include all problems that people run into while using the project. </li>
<li>Track and review bugs - Detailed reports of all functional, cosmetic, security, and other technical faults and flaws in a system.</li>
<li>Document and reuse common solutions - Known ways of solving problems can be documented and assigned to the relevant bugs and/or issues. The knowledge base of solutions can then be reused when appropriate.</li>
</ul>
</p>
<h2>Getting Started...</h2>
<p><i>Notes:
<ul>
<li>If you have not logged in you will need to do so by clicking <a href='<%= new UrlCreator().CreateUrl("SignIn", "User") %>' target="_blank">Sign In</a> at the top right of the page.</li>
<li>A project must be created and selected/activated (from the current project menu at top left) before planning data can be created.</li>
<li>Exception: These restrictions do not apply to reporting issues; issues can be reported by anonymous visitors and don't require a current project to be selected (though it is recommended where applicable).</li>
</ul>
</i></p>
<ol>
	<li>Publish the "report issue" link
		<ol>
			<li>Click Support -> <a href='<%= Request.ApplicationPath + "/Issue-Index.aspx" %>' target="_blank">Issues</a> on the menu to the left.</li>
			<li>Click the <a href='<%= Request.ApplicationPath + "/Issue-ViewLinkInfo.aspx" %>' target="_blank">Link Info</a> button</li>
			<li>If the link is for a specific project then ensure that it's selected/activated in the current project list.</li>
			<li>Publish the report issue link where it's easy for users of your project(s) to follow it</li>
			<li>Anyonymous or identified/registered users can quickly and easily report issues by following the link</li>
		</ol>
	</li>
	<li>Report issues
		<ol>
			<li>Click Support -> <a href='<%= Request.ApplicationPath + "/Report-Issue.aspx" %>' target="_blank">Report Issue</a> on the menu to the left (or follow the link published in the previous step).</li>
			<li>Fill out the form.</li>
		</ol>
	</li>
	<li>Track bugs
		<ol>
			<li>Click Maintenance -> <a href='<%= Request.ApplicationPath + "/Bug-Index.aspx" %>' target="_blank">Bugs</a> on the menu to the left.</li>
			<li>Click the <a href='<%= Request.ApplicationPath + "/Report-Bug.aspx" %>' target="_blank">Report Bug</a> button</li>
			<li>Complete the form.</li>
		</ol>
	</li>
	<li>Define and reuse solutions
	<ol>
		<li>Click Maintenance -> <a href='<%= Request.ApplicationPath + "/Solution-Index.aspx" %>' target="_blank">Solutions</a> on the menu to the left.</li>
		<li>Click the <a href='<%= Request.ApplicationPath + "/Create-Solution.aspx" %>' target="_blank">Create Solution</a> button</li>
		<li>Complete the form.</li>
	</ol>
	</li>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>