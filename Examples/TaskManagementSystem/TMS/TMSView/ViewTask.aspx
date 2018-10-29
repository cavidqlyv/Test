<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewTask.aspx.cs" Inherits="TMSView.ViewTask" %>
<%@ Register src="Controls/ViewTaskUC.ascx" tagname="ViewTaskUC" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:ViewTaskUC ID="ViewTaskUC1" runat="server" />
</asp:Content>
