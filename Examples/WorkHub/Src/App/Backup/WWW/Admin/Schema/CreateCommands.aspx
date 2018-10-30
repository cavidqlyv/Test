
<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="CreateCommands" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="System.IO" %>
<%@ Import namespace="System.Xml" %>
<%@ Import namespace="System.Xml.Serialization" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Data" %>
<script runat="server">

private void Page_Load(object sender, EventArgs e)
{
	RenamePropertyCommand renameManagerPropertyCommand = new RenamePropertyCommand();
	renameManagerPropertyCommand.TypeName = "Project";
	renameManagerPropertyCommand.PropertyName = "Manager";
	renameManagerPropertyCommand.NewPropertyName = "Managers";
	
	DataSchemaCommandCollection commands = new DataSchemaCommandCollection();
	commands.Add(renameManagerPropertyCommand);
	
	DataAccess.Data.Schema.SaveCommands(commands, "Projects", new Version(2,4,0,0));
}
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
Done
</asp:Content>

