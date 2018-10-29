<%@ Control Language="C#" ClassName="Menu" %>
<script runat="server">
private void Page_Load(object sender, EventArgs e)
{
	string scriptPath = Request.ApplicationPath + "/js/Menu.aspx";

	Page.ClientScript.RegisterClientScriptInclude(GetType(), "MenuScript", scriptPath);
}
</script>
<script type="text/javascript">
loadMenu('MenuContainer');
</script>
<span id="MenuContainer"></span>