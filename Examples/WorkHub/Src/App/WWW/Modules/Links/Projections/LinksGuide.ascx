<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
  public override void InitializeInfo()
  {
  		MenuTitle = Language.Guide;
  		MenuCategory = Language.Links;
	  	ShowOnMenu = true;
  }    
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>'>Getting started</a></div>
<h1>Links Guide</h1>
<h2>Introduction</h2>
<p>Links can be created to any accessible resource with a URL.</p>
<h2>Getting Started</h2>
<ol>
<li><a href="Create-Link.aspx" target="_blank">Create new links</a> and (optionally) assign them to specified projects</li>
		<ol>
			<li>Click Links -> <a href='<%= Request.ApplicationPath + "/Index-Link.aspx" %>' target="_blank">Index</a> on the menu (left).</li>
			<li>Click the <a href='<%= Request.ApplicationPath + "/Create-Link.aspx" %>' target="_blank">Create Link</a> button.</li>
			<li>Fill out the form.</li>
		</ol>
<li><a href="Index-Link.aspx" target="_blank">Browse and use links</a>
<ol>
			<li>Click Links -> <a href='<%= Request.ApplicationPath + "/Index-Link.aspx" %>' target="_blank">Index</a> on the menu (left).</li>
			<li>Select a link to view it, and/or go to the URL.</li>
		</ol>
</li>
<li><a href="Default.aspx" target="_blank">Add the links part to the home page</a> for quick access</li>
<ol>
			<li>Click <a href='<%= Request.ApplicationPath + "/Index-Link.aspx" %>' target="_blank">Home</a> on the menu (left).</li>
			<li>Switch to Catalog mode.</li>
			<li>Select the Links category.</li>
			<li>Check the Links checkbox</li>
			<li>Choose the zone from the "Add to" drop down list</li>
			<li>Click Add</li>
			<li>Switch back to Browse mode</li>
		</ol>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>