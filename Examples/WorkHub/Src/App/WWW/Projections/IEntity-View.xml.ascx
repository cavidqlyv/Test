<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseXmlViewProjection" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<script runat="server">
	
	private void Page_Init(object sender, EventArgs e)
	{
		// Get the type from the query string
		Type type = EntitiesUtilities.GetType(QueryStrings.Type);
	
		// Initialize
		Initialize(type);
	}
                    
</script>