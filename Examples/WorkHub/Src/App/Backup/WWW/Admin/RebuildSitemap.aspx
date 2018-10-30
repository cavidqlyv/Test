<%@ Page language="C#" autoeventwireup="true" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">

private void Page_Load(object sender, EventArgs e)
{
	string fromPath = Request.ApplicationPath + "/App_Data/Menu.default.sitemap";
	fromPath = Server.MapPath(fromPath);
	string toPath = Request.ApplicationPath + "/App_Data/Menu.sitemap";
	toPath = Server.MapPath(toPath);
			
	SoftwareMonkeys.WorkHub.Web.SiteMap siteMap = SoftwareMonkeys.WorkHub.Web.SiteMap.Load(fromPath);

	foreach (ModuleContext module in ModuleState.Modules)
	{
		if (ModuleState.IsEnabled(module.ModuleID))
		{
            module.GetSiteMapManager().Add(siteMap);
		}
	}
	
	siteMap.Save(toPath);
	
	Response.Write("Done");
}

</script>
<html>
<head runat="Server">
</head>
<body>
<form runat="server">

</form>
</body>
</html>
