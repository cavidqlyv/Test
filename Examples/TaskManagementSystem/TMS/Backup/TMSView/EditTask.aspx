<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditTask.aspx.cs" Inherits="TMSView.EditTask" %>
<%@ Register src="Controls/TaskUC.ascx" tagname="TaskUC" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:TaskUC ID="TaskUC1" runat="server" />
</asp:Content>
