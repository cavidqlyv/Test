<%@ Control Language="C#" ClassName="ViewMessage" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

	public Message CurrentMessage
	{
		get { return ((Message)Controller.DataSource); }
	}

    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Message));
    }

	private void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
			DataBind();
	}
    
    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit",  RetrieveStrategy.New("Message").Retrieve("ID", QueryStrings.GetID("Message")));
    }    
    
    private void ReplyButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Create", "Message", "ParentID", QueryStrings.GetID("Message").ToString());
    }
    
    private string GetRecipients()
    {
    	 StringBuilder output = new StringBuilder();
    	 
    	 for (int i = 0; i < CurrentMessage.Recipients.Length; i++)
    	 {
    	 	User recipient = CurrentMessage.Recipients[i];
    	 	
    	 	output.Append(String.Format("<a href='{0}'>", new UrlCreator().CreateUrl("Create", "Message", "RecipientID", recipient.ID.ToString())));
    	 	output.Append(recipient.Name);
    	 	output.Append("</a>");
    	 	
    	 	if (i < CurrentMessage.Recipients.Length-1)
    	 		output.Append(", ");
    	 }
    	 
    	 return output.ToString();
    }
    
    private string GetSender()
    {
    	if (CurrentMessage.Sender == null)
    		return Language.NA;
    		
    	return String.Format("<a href='{0}'>{1}</a>",
    		new UrlCreator().CreateUrl("Create", "Message", "Recipient-ID", CurrentMessage.Sender.ID.ToString()),
    	 	CurrentMessage.Sender.Name);
    }
</script>
             
                                
		<asp:Panel runat="server" id="MessageSummaryPanel" visible='<%# CurrentMessage != null %>'>
		<div class="Trail">
		<% if (CurrentMessage.IsPublic && (CurrentMessage.Recipients == null || CurrentMessage.Recipients.Length == 0)){ %>
			<a href='<%= Navigator.GetLink("Discussions") %>'><%= Language.Discussions %></a>
		<% } else { %>
			<a href='<%= Navigator.GetLink("Index", "Message") %>'><%= Language.Inbox %></a>
		<% } %>
		</div>
		<h1>
		<%= CurrentMessage != null ? CurrentMessage.Title : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<div id="ActionsContainer">
        <div id="ActionButtons">
        <asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditMessage %>' CssClass="Button" OnClick="EditButton_Click" visible='<%# Authorisation.UserCan("Edit", CurrentMessage) %>' />
        <asp:Button runat="Server" ID="ReplyButton" Text='<%# Language.Reply %>' CssClass="Button" OnClick="ReplyButton_Click" />
        <cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# CurrentMessage %>' PropertyValuesString='<%# "Text=" + Language.Vote + "&BalanceProperty=VotesBalance&TotalProperty=TotalVotes" %>'/>
        </div>
        </div>
        <p class="Details">
		<%= CurrentMessage != null ? CurrentMessage.Date.ToString() : String.Empty %>
        </p>
		<p class="Details">
		<%= Language.Sender %>: <%= GetSender() %><br/>
		<% if (CurrentMessage.Recipients != null && CurrentMessage.Recipients.Length > 0){ %>
		<%= Language.Recipients %>: <%= GetRecipients() %>
		<% } %>
		</p>
		<p>
		<%= CurrentMessage != null ? CurrentMessage.Body.Replace(Environment.NewLine, "<br/>") : String.Empty %>
		<%= (CurrentMessage != null && CurrentMessage.Body == String.Empty) ? Language.NoBodyForMessage : String.Empty %>
		</p>
		   <cc:ElementControl runat="server" DataSource='<%# CurrentMessage.Subject %>' id="SubjectDisplay" Action="View" TypeName='<%# CurrentMessage.SubjectTypeName %>' PropertyValuesString="HeadingText=Subject" visible='<%# ((Message)DataSource).Subject != null %>' width="100%" />
        <% if (CurrentMessage.Parent != null){ %>
		<h2><%= Language.ParentMessage %></h2>
		<ss:EntityTree runat="server" DataSource='<%# new Message[]{CurrentMessage.Parent} %>' NoDataText='<%# Language.NoParentForMessage %>' id="ParentMessageTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Messages.Entities.Message, SoftwareMonkeys.WorkHub.Modules.Messages">
                        </ss:EntityTree>
        <% } %>
        <% if (CurrentMessage.Replies != null && CurrentMessage.Replies.Length > 0){ %>
		<h2><%= Language.Replies %></h2>
		<ss:EntityTree runat="server" DataSource='<%# CurrentMessage.Replies %>' BranchesProperty="Replies" NoDataText='<%# Language.NoRepliesForMessage %>' id="RepliesTree" NavigateUrl='<%# UrlCreator.Current.CreateUrl("View", typeof(Message), "${Entity.UniqueKey}") %>' EntityType="SoftwareMonkeys.WorkHub.Modules.Messages.Entities.Message, SoftwareMonkeys.WorkHub.Modules.Messages">
                        </ss:EntityTree>
        <% } %>
		</asp:Panel>