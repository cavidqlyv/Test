<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="WorkHub" ValidateRequest="false" %>
<%@ Register Src="Controls/Parts.ascx" TagName="Parts" TagPrefix="uc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<script runat="server">

</script>
<asp:Content ID="PageBody" ContentPlaceHolderID="Body" Runat="Server">

<ss:Result runat="Server" id="HomeResult"/>
      <uc:Parts runat="server"/>

</asp:Content>