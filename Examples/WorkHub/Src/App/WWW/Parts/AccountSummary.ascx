<%@ Control Language="C#" ClassName="AccountSummary" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
       	DataBind();
    }
    
    public override void InitializeInfo()
    {
    	MenuTitle = Resources.Language.AccountSummary;
    	MenuCategory = Resources.Language.Users;
    }
                    
</script>
<asp:Panel runat="server" id="AuthenticatedUserPanel" visible='<%# AuthenticationState.IsAuthenticated %>'>
<%= Resources.Language.Username %>:&nbsp;<%= (AuthenticationState.IsAuthenticated && AuthenticationState.User != null) ? AuthenticationState.User.Username : String.Empty  %><br/>
<%= Resources.Language.Name %>:&nbsp;<%= (AuthenticationState.IsAuthenticated && AuthenticationState.User != null) ? AuthenticationState.User.Name : String.Empty  %><br/>
<%= Resources.Language.Email %>:&nbsp;<%= (AuthenticationState.IsAuthenticated && AuthenticationState.User != null && AuthenticationState.User.Email != String.Empty) ? AuthenticationState.User.Email : Resources.Language.NA  %><br/>
</asp:Panel>

<asp:Panel runat="server" id="AnonymousUserPanel" visible='<%# !AuthenticationState.IsAuthenticated %>'>
<%= Resources.Language.AnonymousGuest %>
</asp:Panel>