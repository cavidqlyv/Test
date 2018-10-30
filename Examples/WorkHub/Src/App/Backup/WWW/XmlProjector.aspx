<%@ Page Language="C#" Title="Untitled Page" ValidateRequest="false" %>

<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<script runat="server">
    
    private void Page_Load(object sender, EventArgs e)
    {
            if (!Projector.FoundProjection)
            {
            	// TODO: Review whether a friendly error should be displayed
                Response.Redirect("Default.aspx");
            }
    }


</script>
<cc:ProjectorControl runat="server" id="Projector"></cc:ProjectorControl>

