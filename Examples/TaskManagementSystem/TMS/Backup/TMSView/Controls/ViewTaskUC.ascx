<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewTaskUC.ascx.cs" Inherits="TMSView.Controls.ViewTaskUC" %>
<script language="javascript" type="text/javascript">

    function OpenEditTask(objQueryString) {
        window.open(objQueryString, 'PopUp', 'left=100,top=100,toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, directories=no, status=no,width=850,height=500');
        return false;
    } 
    </script>
<asp:Panel HorizontalAlign="Center" Width="800px" runat="server" ID="panHouse">

       <table id="tblMain" cellspacing="0" border="1" style="width:100%; border-color: #000000";>
          <tr>
              <td align="center"><asp:Label runat="server" ID="lblViewTask" Width="238px" >View Task</asp:Label></td>
          </tr>  
            </table>
        </asp:Panel>

        <asp:Panel ID="panViewTask" runat="server" HorizontalAlign="center" Width="800px">
        <table id="tblGrid" cellspacing="0" border="1" style="width:100%;border-color:#000000";>
            <tr>
                <td>
                      <asp:GridView ID="dgTask" runat="server" Width="100%" 
                          AutoGenerateColumns="False" 
                           AllowPaging="True"
                           PageSize="5" onpageindexchanging="dgTask_PageIndexChanging" 
                          onrowcreated="dgTask_RowCreated" onrowdatabound="dgTask_RowDataBound"
                          > 
                      <Columns> 
                        <asp:BoundField DataField="TaskID" HeaderText="TaskID" ItemStyle-Width="1%"/> 
                        <asp:BoundField DataField="TaskName" HeaderText="Task Name" ItemStyle-HorizontalAlign="left" ItemStyle-Width="10%"/>
                        <asp:BoundField DataField="PriorityName" HeaderText="Priority" ItemStyle-HorizontalAlign="center" ItemStyle-Width="10%"/>                        
                        <asp:BoundField DataField="StatusName" HeaderText="Status" ItemStyle-HorizontalAlign="center" ItemStyle-Width="10%"/>                       
                        <asp:BoundField DataField="UserName" HeaderText="Assigned To" ItemStyle-HorizontalAlign="center" ItemStyle-Width="10%"/>
                        <asp:BoundField DataField="CreatedOn" HeaderText="Created On" ItemStyle-HorizontalAlign="left" ItemStyle-Width="10%"/>                        
                        <asp:BoundField  DataField="EstimatedTime" HeaderText="Est Time" ItemStyle-HorizontalAlign="left" ItemStyle-Width="7%"/>
                        <asp:BoundField  DataField="ActualTime" HeaderText="Act Time" ItemStyle-HorizontalAlign="left" ItemStyle-Width="7%"/>
                        <asp:BoundField  DataField="ExtraTime" HeaderText="Ext Time" ItemStyle-HorizontalAlign="left" ItemStyle-Width="7%"/>
                        <asp:BoundField  DataField="Flag" HeaderText="Flag" ItemStyle-HorizontalAlign="left" ItemStyle-Width="2%"/>
                       
                        <asp:TemplateField HeaderText="Edit Task" ItemStyle-Width="10%">
                         <ItemTemplate>
                            <asp:Button ID="btnEdit" runat ="Server" Text="Edit"/>                            
                          </ItemTemplate>                   
                        </asp:TemplateField>   
                        <asp:BoundField DataField="PriorityID" HeaderText="PriorityID" ItemStyle-Width="1%"/>                           
                        <asp:BoundField DataField="StatusID" HeaderText="StatusID" ItemStyle-Width="1%"/> 
                        <asp:BoundField DataField="UserID" HeaderText="UserID" ItemStyle-Width="1%"/> 
                      </Columns>             
                      </asp:GridView>                                  
                    </td>
                  </tr> 
                </table> 
              </asp:Panel>
