<%@ Page Language="C#" MasterPageFile="~/Site.master" validaterequest="false" %>

<%@ Register Src="Parts/Welcome.ascx" TagName="Welcome" TagPrefix="uc2" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<script runat="server">
    
    private void Page_Load(object sender, EventArgs e)
    {
            if (!Projector.FoundProjection)
            {
            	// TODO: Review whether a friendly error should be displayed
                Response.Redirect("Default.aspx");
            }
    }


	private string GetEditUrl()
	{
		if (Projector.DataSource.Name != String.Empty)
			return Request.ApplicationPath + "/Admin/EditProjection.aspx?Projection=" + Projector.DataSource.Name;
		else
			throw new Exception("No name specified for projection.");
	}
	

</script>
<asp:Content ID="PageBody" ContentPlaceHolderID="Body" Runat="Server">
<% if (Authorisation.IsInRole("Administrator")){ %>
<div class="ProjectorMenu">[<a href='<%= GetEditUrl() %>'><%= Resources.Language.EditThisProjection %></a>]</div>
<% } %>
<cc:ProjectorControl runat="server" id="Projector"></cc:ProjectorControl>
</asp:Content>

