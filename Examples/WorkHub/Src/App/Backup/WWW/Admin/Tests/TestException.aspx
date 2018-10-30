<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="Backup" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="System.Xml" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import Namespace="System.Reflection" %>
<script runat="server">

private void Page_Load(object sender, EventArgs e)
{
	throw new Exception("Test exception");
}
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
Done
</asp:Content>

