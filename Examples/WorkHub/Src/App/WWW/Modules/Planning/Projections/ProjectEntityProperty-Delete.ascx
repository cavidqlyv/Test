<%@ Control Language="C#" ClassName="DeleteProjection" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseDeleteProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

		private void Page_Init(object sender, EventArgs e)
		{
			// Get the type from the query string
			Type type = EntitiesUtilities.GetType(QueryStrings.Type);
		
			// Initialize
			Initialize(type);
		}
</script>