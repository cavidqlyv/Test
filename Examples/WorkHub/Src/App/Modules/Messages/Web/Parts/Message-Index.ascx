<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
		Message[] discussions = new Message[]{};
		
		discussions = IndexMessageStrategy.New().IndexInbox();
			
		if (Authorisation.UserCan("Index", discussions))
		{
			MessageList.DataSource = discussions;
			DataBind();
			Visible = true;
		}
		else
			Visible = false;
		
		SetDefaultHeight(discussions.Length, 100);
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.Messages;
      	MenuCategory = Language.Messages;
        ShowOnMenu = true;
    }
</script>
		<asp:Repeater runat="Server" id="MessageList">
                                    <itemtemplate>
																	<p class="Title"><a href='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
																	</p>
																	<p class="Details"><%# ((DateTime)Eval("Date")).ToString() %> - 
																	<ASP:Hyperlink id=ReplyButton runat="server" ToolTip='<%# Language.ReplyToMessageToolTip %>' text='<%# "&laquo; " + Language.Reply %>' navigateurl='<%# Navigator.GetLink("Create", "Message", "ParentID", Eval("ID").ToString()) %>'>
																	</ASP:Hyperlink>
																	- <a href='<%# new UrlCreator().CreateUrl("Create", "Message", "Recipient-ID", Eval("ID").ToString()) %>'><%# Eval("Sender.Name") %></a>
																	 - <% = Language.Replies %>: <%# Eval("TotalReplies") %>
																	</p>
																	<p class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Body") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Body") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Body") : "&nbsp;", 200) %></p>
									</itemtemplate>
                        </asp:Repeater>