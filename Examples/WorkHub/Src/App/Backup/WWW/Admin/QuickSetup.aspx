<%@ Page language="c#" AutoEventWireup="true" MasterPageFile="~/Site.master" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.State	" %>
<%@ Import namespace="System.Reflection" %>
<%@ Register TagPrefix="cc" Assembly="SoftwareMonkeys.WorkHub.Web" Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="System.IO" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>

<script language="C#" runat="server">

private void Page_Load(object sender, EventArgs e)
{
    if (!IsPostBack)
    {
        Response.Redirect("Setup.aspx?a=QuickSetup");
       // Setup1();
    }
    
}

</script>
<asp:Content ContentPlaceHolderID="Body" runat="Server" ID="Body">
</asp:Content>
