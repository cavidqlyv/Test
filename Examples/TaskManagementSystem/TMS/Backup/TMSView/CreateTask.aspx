<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="CreateTask.aspx.cs" Inherits="TMSView.CreateTask" %>

<%@ Register Src="Controls/TaskUC.ascx" TagName="TaskUC" TagPrefix="uc1" %>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p>
        <uc1:TaskUC ID="TaskUC1" runat="server" />
    </p>
</asp:Content>
