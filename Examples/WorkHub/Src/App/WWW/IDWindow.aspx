<%@ Page language="c#" AutoEventWireup="false" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<HTML>
	<HEAD runat="server">
		<title><%= Request.QueryString["Title"] %></title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="Styles/Content.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body MS_POSITIONING="FlowLayout">
		<form id="Form" method="post" runat="server">
		<div style="padding: 15px">
		<div class="Heading3"><%= Request.QueryString["Title"] %></div>
		<div class="Text"><input type="text" style="width: 100%" id="RecordID" value='<%= Request.QueryString["ID"] %>' readonly="true" class="SolidField" /></div>
		<div class="Text" align=right>[<a href="javascript:window.close()"><%= Resources.Language.Close %></a>]</div>
		</div>
		<script language="javascript">
		document.getElementById("RecordID").focus();
		document.getElementById("RecordID").select();
		</script>
		</form>
	</body>
</HTML>
