<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<script runat="server">
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Guide;
  	MenuCategory = Language.Planning + "/" + Language.Technical;
  }
                    
</script>
<div class="Trail"><a href='<%= Request.ApplicationPath %>'>Home</a> &gt; <a href='<%= Request.ApplicationPath + "/Admin/QuickStart.aspx" %>'>Getting started</a></div>
<h1>Components Guide</h1>
<h2>Introduction</h2>
<p>//TODO</p>