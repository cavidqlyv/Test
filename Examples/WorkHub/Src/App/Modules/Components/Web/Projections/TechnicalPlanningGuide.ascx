<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Guide;
  	MenuCategory = Language.Planning + "/" + Language.Technical;
  }
                    
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Guide.aspx" %>' id="GettingStartedLink">Getting started</a></div>
<h1>Technical Planning Guide</h1>
<h2>Introduction</h2>
<p>Components are general way of representing various structures in projects such as classes, namespaces, assemblies, etc.</p>
<h2>Getting started...</h2>
<ol>
	<li><a href='<%= new UrlCreator().CreateUrl("Create", "ComponentType") %>' target="_blank">Identify types of components</a> that will be represented by the technical plans.
	<ol>
		<li>Click Planning -> Technical -> <a href='<%= new UrlCreator().CreateUrl("Index", "ComponentType") %>' target="_blank">Component Types</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "ComponentType") %>' target="_blank">Create Component Type</a> button.</li>
	</ol>
	<li><a href='<%= new UrlCreator().CreateUrl("Create", "Component") %>' target="_blank">Define each component</a> and reference others that are related.
	<ol>
		<li>Click Planning -> Technical -> <a href='<%= new UrlCreator().CreateUrl("Index", "Component") %>' target="_blank">Components</a> on the menu (left).</li>
		<li>Click the <a href='<%= new UrlCreator().CreateUrl("Create", "Component") %>' target="_blank">Create Component</a> button.</li>
	</ol>
	</li>
	<li><a href='<%= new UrlCreator().CreateUrl("Index", "ComponentType") %>' target="_blank">Browse the component types</a>.
		<ol>
			<li>Click Planning -> Technical -> <a href='<%= new UrlCreator().CreateUrl("Index", "ComponentType") %>' target="_blank">Component Types</a> on the menu (left).</li>
		</ol>
	</li>
	<li>Select a component type to view the details, along with corresponding components.</li>
	<li>Select a component to view the details, along with referenced components.</li>
</ol>
<p><a href='<%= new UrlCreator().CreateUrl("Guide") %>'>&laquo; Return</a></p>