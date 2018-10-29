<%@ Control Language="C#" ClassName="Discussions" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" autoeventwireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Web.Controllers" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Message), IndexGrid, true);
    	
    	IndexMessageController controller = (IndexMessageController)Controller;
    	
    	controller.IndexMode = MessageIndexMode.Discussions;
    	
    }

    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Response.Redirect(new UrlCreator().CreateUrl("Create", "Message") + "?IsDiscussion=" + true.ToString());
  }
  
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Discussions;
  	//MenuCategory = Language.Discussions;
  }
  
  public string GetReadText(Message message)
  {
  	if (CheckReadMessageStrategy.New().IsRead(message))
  		return Language.Read;
  	else
  		return Language.Unread;
  }
                    
</script>
            <h1>
                        <%= Language.Discussions %>
                    </h1>
                        <cc:Result ID="Result1" runat="server">
                        </cc:Result>
                        <p>
                            <%= Language.DiscussionsIntro %>
                        </p>
                                <div id="ViewLinks"><%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Message") %>'><%= Language.Xml %></a>
                                </div>
                        <div id="ActionButtons">
                        	<asp:Button ID="CreateButton" runat="server" Text='<%# Language.StartDiscussion %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                </div>
				<p>
                <cc:IndexGrid ID="IndexGrid" DataSource='<%# DataSource %>' runat="server" DefaultSort="DateAscending" AllowPaging='<%# EnablePaging %>'
                            DataKeyNames="ID" HeaderText='<%# Language.Discussions %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize='20' ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoDiscussions %>'>
                            <Columns>
                                
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Title"><a href='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
																	</div>
																	<div class="Details"><%# ((DateTime)Eval("Date")).ToString() %> - 
																	<ASP:Hyperlink id=ReplyButton runat="server" ToolTip='<%# Language.ReplyToMessageToolTip %>' text='<%# "&laquo; " + Language.Reply %>' navigateurl='<%# Navigator.GetLink("Create", "Message", "ParentID", Eval("ID").ToString()) %>'>
																	</ASP:Hyperlink>
																	- <a href='<%# new UrlCreator().CreateUrl("Create", "Message", "RecipientID", Eval("ID").ToString()) %>'><%# Eval("Sender.Name") %></a>
																	 - <% = Language.Replies %>: <%# Eval("TotalReplies") %>
																	</div>
																	<div class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Body") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Body") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Body") : "&nbsp;", 200) %></div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Details"><%# GetReadText((Message)Container.DataItem) %>
																	</div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Details">
																		<cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# ((IEntity)Container.DataItem) %>' PropertyValuesString='<%# "Text=" + Language.Vote + "&BalanceProperty=VotesBalance&TotalProperty=TotalVotes" %>' />
																	</div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="50px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	
																	<ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditMessageToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>' visible='<%# Authorisation.UserCan("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteMessage %>' ToolTip='<%# Language.DeleteMessageToolTip %>' navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>' visible='<%# Authorisation.UserCan("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
									</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </cc:IndexGrid>
                      </p>