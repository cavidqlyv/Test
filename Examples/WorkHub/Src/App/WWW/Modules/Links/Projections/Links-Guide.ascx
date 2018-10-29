<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<h1>Links Guide</h1>
<h2>Introduction</h2>
<p>The OpenLinks module is the centre of the project management suite. Data in other modules can be associated to specific files and so they'll be organized/grouped accordingly.</p>
<p>Once a project is created it can be selected/activated using the menu at the top left of each page. Most pages will refresh (or redirect) to display information specific to the currently selected project.</p>
<h2>Getting Started...</h2>
<p><i>Note: If you have not logged in you will need to do so by clicking "Sign in" at the top right of the page.</i></p>
<ol>
<li>Create a project (or as many as you need)
<ol>
<li>Click Links -> <a href='<%= Request.ApplicationPath + "/Link/Index.aspx" %>' target="_blank">Index</a> on the menu to the left.</li>
<li>Click the <a href='<%= Request.ApplicationPath + "/Link/Create.aspx" %>' target="_blank">Create Link</a> button.</li>
<li>Enter the name of the project into the form.</li>
<li>Provide a project summary. (optional)</li>
<li>Enter the name of the company/group responsible for the project. (optional)</li>
<li>Specify the current project version. (optional)</li>
<li>Select the managers and contributors of the project. (optional)</li>
<li>Click the Save button.</li>
</ol>
</li>
<li>Browse files
<ol>
<li>Click Links -> <a href='<%= Request.ApplicationPath + "/Link/Index.aspx" %>' target="_blank">Index</a> on the menu to the left.</li>
<li>Browse and manage files in the index</li>
</ol>
</li>
<li>Select a current project
<ol>
<li>Choose a project from the "Current Link" list to the top left of each page.</li>
<li>Most pages will display data for the project that has been selected.</li>
</ol>
</li>
<li>Use features available in other modules to add more data to the project
<ol>
	<li><a href='<%= Request.ApplicationPath + "/Guide.aspx" %>'>Back to index</a></li>
</ol>
</li>
</ol>