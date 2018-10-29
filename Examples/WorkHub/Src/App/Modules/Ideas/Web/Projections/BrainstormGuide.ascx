<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
  public override void InitializeInfo()
  {
  		MenuTitle = Language.Guide;
  		MenuCategory = Language.Brainstorm;
	  	ShowOnMenu = true;
  }    
</script>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules" %>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Brainstorm Guide</h1>
<h2>Introduction</h2>
<p>Ideas can be documented when they're still in their early, rough draft stage, then made available for review and discussion. These ideas can then be used as inspiration and turned into projects.</p>
<h2>Getting Started...</h2>
<ol>
<li>
Brainstorm new ideas either by yourself or as part of a group.
</li>
<li>
<a href='Create-Idea.aspx' target="_blank">Post your ideas</a> and share them with others.
<ul>
<li>Click Brainstorm -> <a href='Create-Idea.aspx' target="_blank">Create Idea</a> on the menu (left)</li>
</ul>
</li>
<li>
<a href="Idea-Index.aspx" target="_blank">Browse all the ideas</a> that have been posted.
<ul>
<li>Click Brainstorm -> <a href='Index-Idea.aspx' target="_blank">Ideas</a> on the menu (left)</li>
</ul>
</li>
<% if (ModuleState.IsEnabled("Projects")) { %>
<li>
<a href="ProjectsGuide.aspx" target="_blank">Start projects</a> inspired by the ideas.
<ul>
<li>Click Projects -> <a href='ProjectsGuide.aspx' target="_blank">Guide</a> on the menu (left)</li>
</ul>
</li>
<% } %>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>