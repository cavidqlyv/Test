<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register TagPrefix="cc" Assembly="SoftwareMonkeys.WorkHub.Web" Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>

<h1>Getting started...</h1>

<cc:Result runat="server"/>
<% if (Request.QueryString["a"] == "SetupComplete"){ %>
<h2>Setup Complete</h2>
<p style="color:green;"><strong>Welcome! The WorkHub application has been installed and is now ready to use.</strong></p>
<% } %>

<h2>Introduction</h2>
<p>The following guides should help you get started.</p>
<ol>
<li><a href='BrainstormGuide.aspx'>Brain-storm and document your ideas.</a>
</li>
<li><a href='ProjectsGuide.aspx'>Start new projects and collaborate online.</a>
</li>
<li><a href='PlanningGuide.aspx'>Plan the requirements of your project and the interaction between users and systems.</a>
</li>
<li><a href='TechnicalPlanningGuide.aspx'>Plan the relationships of technical components of your project.</a>
</li>
<li><a href='RoadmapGuide.aspx'>Receive feedback, create and assign tasks, define milestones and organise tasks into a project roadmap.</a>
</li>
<li><a href='MaintenanceGuide.aspx'>Receive issue reports about your project from users, identify and track bugs, and document common solutions.</a>
</li>
<li><a href='LinksGuide.aspx'>Bookmark useful resources ready for easy access and sharing.</a>
</li>
</ol>
<p>&nbsp;
</p>