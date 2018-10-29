<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Title="Manage Utilities" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<script runat="server">
    
    #region Main functions
    /// <summary>
    /// Displays the index for managing configs.
    /// </summary>
    private void DisplayUtilities()
    {
        Authorisation.EnsureIsAuthenticated();

        Authorisation.EnsureIsInRole("Administrator");
        
        OperationManager.StartOperation("DisplayUtilities", IndexView);

        IndexView.DataBind();
    }

    #endregion

    #region Event handlers
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
                    DisplayUtilities();
        }
    }

    #endregion

</script>
<asp:Content ID="Body" ContentPlaceHolderID="Body" runat="Server">
    <asp:MultiView ID="PageView" runat="server">
        <asp:View ID="IndexView" runat="server">
            <h1><%# Resources.Language.Utilities %></h1>
                        <cc:Result runat="server" ID="IndexResult">
                        </cc:Result>
                        <p>
                            <%# Resources.Language.UtilitiesIntro %></p>
                            <ul>
	                            <li>
	                            	<a href="Modules.aspx"><%# Resources.Language.Modules %></a>
	                           	</li>
	                           	<li>
	                           		<a href='<%= new UrlCreator().CreateUrl("Settings") %>'><%# Resources.Language.Settings %></a>
	                           	</li>
	                           	<li>
	                            	<a href="Backup.aspx"><%# Resources.Language.Backup %></a>
	                            </li>
	                            <li>
	                            	<a href="Update.aspx"><%# Resources.Language.Update %></a>
	                            </li>
	                            <li>
	                            	<a href="Cache.aspx"><%# Resources.Language.Cache %></a>
	                            </li>
	                            <li>
	                            	<a href="Errors.aspx"><%# Resources.Language.Errors %></a>
	                            </li>
                            </ul>
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
