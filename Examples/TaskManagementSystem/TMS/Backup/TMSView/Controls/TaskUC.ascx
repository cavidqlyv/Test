<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TaskUC.ascx.cs" Inherits="TMSView.Controls.TaskUC" %>
<link href="../Styles/CalenderControl.css" rel="stylesheet" type="text/css" />
<script src="../Scripts/CalendarControl.js" type="text/javascript" language="javascript"></script>
<script src="../Scripts/Validation.js" type="text/javascript" language="javascript"></script>
<script language="javascript" type="text/javascript">

    function Validate()//Fires when Submit Button Is Clicked
    {
        var append = "MainContent_TaskUC1_";

        var TaskCilentID = append + "txtTaskName";
        var PriorityClientID = append + "ddlPriority";
        var StatusClientID = append + "ddlStatus";
        var AssignedToClientID = append + "ddlAssignedTo";
        var TaskCreationClientID = append + "txtTaskCreationDate";
        var EstimatedTimeClientID = append + "txtEstimatedTime";


        if ((document.getElementById(TaskCilentID).value).length <= 0)//Check If Task Name Is given
        {
            alert("Task Name Cannot Be Empty");
            document.getElementById(TaskCilentID).focus();
            return false;
        }

        if (document.getElementById(PriorityClientID).selectedIndex == 0)//Must choose a Priority
        {
            alert("Please Choose a Priority");
            document.getElementById(PriorityClientID).focus();
            return false;
        }

        if (document.getElementById(StatusClientID).selectedIndex == 0)//Must choose a Status
        {
            alert("Please Choose a Status");
            document.getElementById(StatusClientID).focus();
            return false;
        }

        if (document.getElementById(AssignedToClientID).selectedIndex == 0)//Must choose a Assigne
        {
            alert("Please Choose a Assigne");
            document.getElementById(AssignedToClientID).focus();
            return false;
        }

        if ((document.getElementById(TaskCreationClientID).value).length <= 0)//Check If Task Name Is given
        {
            alert("Task Creation Cannot Be Empty");
            document.getElementById(TaskCreationClientID).focus();
            return false;
        }

        if ((document.getElementById(EstimatedTimeClientID).value).length <= 0)//Check If Estimated Time Is given
        {
            alert("Estimated Time Cannot Be Empty");
            document.getElementById(EstimatedTimeClientID).focus();
            return false;
        }

       else {

            if (CheckNumeric(EstimatedTimeClientID) == false)//If Estimated Time Is AlphaNumeric
            {
                alert("Estimated Time Should Be Numeric");
                document.getElementById(EstimatedTimeClientID).focus();
                return false;
            }
        }
    }
</script>
<table id="tabMain" bordercolor="#000000" cellspacing="0" width="776" height="200px"
    align="center" border="1">
    <tr>
        <td>
            <table id="tabTask" width="98%" align="center">
                <tr>
                    <td style="width: 704px" align="center" colspan="4">
                        <asp:Label runat="server" ID="lblTaskScreen" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblTaskName" runat="server">Task Name</asp:Label>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtTaskName" runat="server" Width="300px" MaxLength="200"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblPriority" Text="Priority" runat="server" />
                    </td>
                    <td align="left" style="width: 153px">
                        <asp:DropDownList ID="ddlPriority" runat="server" Width="145px" />
                    </td>
                    <td align="right">
                        <asp:Label ID="lblStatus" Text="Status" runat="server" />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlStatus" runat="server" Width="145px" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblAssignedTo" runat="server" Text="Assigned To" />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlAssignedTo" runat="server" Width="145px">
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblTaskCreationDate" runat="server" Text="Task Created On" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtTaskCreationDate" Width="145px" MaxLength="50"></asp:TextBox><asp:ImageButton
                            src="Images\Chrysanthemum.jpg" Width="18" border="0" alt="Calender" ID="calImgCreationDate"
                            runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <asp:Label ID="lblEstimatedTime" runat="server" Text="Estimated Time" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtEstimatedTime" Width="153px" MaxLength="50"></asp:TextBox>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblActualTime" runat="server" Text="Actual Time" />
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" ID="txtActualTime" Width="189px" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 704px" align="center" colspan="4">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                            onclick="btnSubmit_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="center" valign="top" colspan="4">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
