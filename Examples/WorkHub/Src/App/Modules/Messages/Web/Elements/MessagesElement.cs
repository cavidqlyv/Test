using System.Reflection;
using System.Runtime.Versioning;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Properties;
using SoftwareMonkeys.WorkHub.Modules.Messages.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Messages.Business;
using SoftwareMonkeys.WorkHub.Web;
using SoftwareMonkeys.WorkHub.Web.Elements;
using SoftwareMonkeys.WorkHub.Web.Navigation;
using SoftwareMonkeys.WorkHub.Web.Security;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Web.Elements
{
	/// <summary>
	/// 
	/// </summary>
	[Element("Messages")]
	public class MessagesElement : BaseElement
	{
		PlaceHolder MessagesHolder;
		
		private IEntity dataSource;
		public IEntity DataSource
		{
			get {
				if (dataSource == null && SubjectID != Guid.Empty && SubjectType != String.Empty)
					dataSource = RetrieveStrategy.New(SubjectType).Retrieve("ID", SubjectID);
				return dataSource; }
			set { dataSource = value;
				SubjectID = value.ID;
				SubjectType = value.ShortTypeName;
			}
		}
		
		/// <summary>
		/// Gets/sets the ID of the subject entity.
		/// </summary>
		public Guid SubjectID
		{
			get {
				if (ViewState["SubjectID"] == null)
					ViewState["SubjectID"] = Guid.Empty;
				return (Guid)ViewState["SubjectID"];
			}
			set { ViewState["SubjectID"] = value; }
		}
		
		/// <summary>
		/// Gets/sets the short type name of the subject entity.
		/// </summary>
		public string SubjectType
		{
			get {
				if (ViewState["SubjectType"] == null || (string)ViewState["SubjectType"] == String.Empty)
				{
					if (Subject != null)
						ViewState["SubjectType"] = Subject.ShortTypeName;
					else
						ViewState["SubjectType"] = String.Empty;
				}
				
				// If the full type was provided then shorten it
				if (((string)ViewState["SubjectType"]).IndexOf('.') > -1)
					ViewState["SubjectType"] = EntityState.GetInfo((string)ViewState["SubjectType"]).TypeName;
				
				return (string)ViewState["SubjectType"];
			}
			set {
				ViewState["SubjectType"] = value;
			}
		}
		
		
		/// <summary>
		/// Gets/sets the heading text.
		/// </summary>
		public string HeadingText
		{
			get {
				if (ViewState["HeadingText"] == null)
					ViewState["HeadingText"] = Language.Comments; // Set to 'Comments' because this element is usually messages about a particular subjects
				
				return (string)ViewState["HeadingText"];
			}
			set {
				ViewState["HeadingText"] = value;
			}
		}
		
		protected IEntity Subject
		{
			get {
				return DataSource;
			}
		}
		
		/// <summary>
		/// Gets/sets the text displayed when there are no messages.
		/// </summary>
		public string NoMessagesText
		{
			get {
				if (ViewState["NoMessagesText"] == null)
					ViewState["NoMessagesText"] = Language.NoMessages;
				
				return (string)ViewState["NoMessagesText"];
			}
			set {
				ViewState["NoMessagesText"] = value;
			}
		}
		
		public MessagesElement()
		{
			
		}
		
		protected override void CreateChildControls()
		{
			
			base.CreateChildControls();
			
			InitializeChildControls();
		}
		
		protected override void OnInit(EventArgs e)
		{
			EnsureChildControls();
			
			base.OnInit(e);
		}
		
		protected override void OnLoad(EventArgs e)
		{		
			
			base.OnLoad(e);
		}
		
		public override void DataBind()
		{
			base.DataBind();
		}
		
		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);
			
			
			LoadMessages();
		}
		
		private void LoadMessages()
		{
			if (SubjectType == null || SubjectType == String.Empty)
				throw new Exception("The SubjectType property hasn't been set.");
			
			MessagesHolder.Controls.Add(new LiteralControl("<div class='MessagesBody'>"));
						
			// TODO: See if it's possible to exclude all sub messages from being loaded to avoid the performance hit
			Message[] messages = IndexStrategy.New<Message>().IndexWithReference<Message>("Subject", SubjectType, SubjectID);
			
			if (messages != null && messages.Length > 0)
			{
				foreach (Message message in messages)
				{
					ActivateStrategy.New(message).Activate(message, "Parent");
					
					// If the message has no parent then it's a root message and can be shown
					if (message.Parent == null)
					{
						ActivateStrategy.New(message).Activate(message, "Author");
						
						CreateMessageOutput(MessagesHolder, message);
						
						MessagesHolder.Controls.Add(new LiteralControl("<hr/>"));
					}
				}
			}
			else
				CreateEmptyOutput(MessagesHolder);
			
			MessagesHolder.Controls.Add(new LiteralControl("</div>"));
		}
		
		private void CreateMessageOutput(Control container, Message message)
		{
			if (message == null)
				throw new ArgumentNullException("message");
			
			// Title
			HyperLink titleLink = new HyperLink ();
			titleLink.Text = message.Title;
			titleLink.NavigateUrl = new UrlCreator().CreateUrl("View", message);
			
			container.Controls.Add(new LiteralControl("<p class='Title'>"));
			
			container.Controls.Add(titleLink);
			
			container.Controls.Add(new LiteralControl("</p>"));
			container.Controls.Add(new LiteralControl("<p class='Details'>"));
			
			// Relpy link
			HyperLink replyLink = new HyperLink();
			replyLink.Text = Language.Reply;
			replyLink.NavigateUrl = new UrlCreator().CreateUrl("Create", "Message") + "?Parent-ID=" + message.ID.ToString() + "&Subject-ID=" + Subject.ID.ToString() + "&SubjectType=" + Subject.ShortTypeName + "&IsDiscussion=" + true.ToString();
			
			container.Controls.Add(replyLink);
			
			// Edit link
			if (Authorisation.UserCan("Edit", message))
			{
				HyperLink editLink = new HyperLink();
				editLink.Text = Language.Edit;
				editLink.NavigateUrl = new UrlCreator().CreateUrl("Edit", message);
				
				container.Controls.Add(new LiteralControl(" - "));
				container.Controls.Add(editLink);
			}
			
			// Sender
			if (message.Sender != null)
			{
				container.Controls.Add(new LiteralControl(" - "));
				container.Controls.Add(new LiteralControl(message.Sender.ToString()));
			}
			
			// Date
			container.Controls.Add(new LiteralControl(" - "));
			container.Controls.Add(new LiteralControl(message.Date.ToString()));
			
			// Voting
			if (ModuleState.IsEnabled("Voting"))
			{
				ElementControl voting = new ElementControl();
				voting.ElementName = "Vote";
				voting.DataSource = message;
				voting.PropertyValuesString = "TotalProperty=TotalVotes&BalanceProperty=VotesBalance";
				
				container.Controls.Add(new LiteralControl(" - "));
				container.Controls.Add(voting);
			}
			
			container.Controls.Add(new LiteralControl("</p>"));
			
			// Body
			container.Controls.Add(new LiteralControl("<p class='Content'>"));
			container.Controls.Add(new LiteralControl(message.Body.Replace(Environment.NewLine, "<br/>")));
			container.Controls.Add(new LiteralControl("</p>"));
			
			ActivateStrategy.New(message).Activate(message, "Replies");
			
			if (message.Replies != null && message.Replies.Length > 0)
			{
				CreateRepliesOutput(container, message.Replies);
			}
			
			//container.Controls.Add(new LiteralControl("</p>"));
		}
		
		private void CreateEmptyOutput(Control container)
		{
			container.Controls.Add(new LiteralControl("<p>"));
			container.Controls.Add(new LiteralControl(NoMessagesText));
			container.Controls.Add(new LiteralControl("</p>"));
			
			container.Controls.Add(new LiteralControl("<hr/>"));
		}
		
		private void CreateRepliesOutput(Control container, Message[] replies)
		{
			container.Controls.Add(new LiteralControl("<div style='padding-left: 20px; padding-top: 10px;'>"));
			
			foreach (Message message in replies)
			{
				container.Controls.Add(new LiteralControl("<hr/>"));
				
				CreateMessageOutput(container, message);
			}
			
			container.Controls.Add(new LiteralControl("</div>"));
		}
		
		protected virtual void InitializeChildControls()
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Initializing child controls."))
			{
				InitializeHeading();
				
				InitializeMessages();
				
				InitializeCreateButton();
				
				//InitializeFormPanel();
			}
		}
		
		private void InitializeHeading()
		{
			Controls.Add(new LiteralControl("<h2>" + HeadingText + "</h2>"));
		}
		
		private void InitializeCreateButton()
		{
			Button button = new Button();
			button.Text = Language.PostMessage + " >";
			button.Click += new EventHandler(CreateButton_Click);
			
			Controls.Add(new LiteralControl("<div>"));
			Controls.Add(button);
			Controls.Add(new LiteralControl("</div>"));
			
			Controls.Add(new LiteralControl("<hr/>"));
		}
		
		/*private void InitializeFormPanel()
		{
			EntityFormTextBoxItem titleItem = new EntityFormTextBoxItem();
			titleItem.PropertyName = "Title";
			titleItem.Text = Language.Title + ":";
			titleItem.TextBox.CssClass = "Field";
			titleItem.TextBox.Width = Unit.Pixel(400);
			
			EntityFormTextBoxItem bodyItem = new EntityFormTextBoxItem();
			bodyItem.PropertyName = "Body";
			bodyItem.Text = Language.Body + ":";
			bodyItem.TextBox.CssClass = "Field";
			bodyItem.TextBox.TextMode = TextBoxMode.MultiLine;
			bodyItem.TextBox.Width = Unit.Pixel(400);
			bodyItem.TextBox.Rows = 5;
			
			Button postButton = new Button();
			postButton.Text = Language.Post;
			//postButton.Click += new EventHandler(PostButton_Click);
			
			EntityFormButtonsItem buttonsItem = new EntityFormButtonsItem();
			buttonsItem.Add(postButton);
			
			CreateForm = new EntityForm();
			CreateForm.HeadingText = Language.PostMessage;
			CreateForm.Width = Unit.Percentage(100);
			CreateForm.Rows.Add(titleItem);
			CreateForm.Rows.Add(bodyItem);
			CreateForm.Rows.Add(buttonsItem);
			
			FormPanel = new Panel();
			
			Controls.Add(FormPanel);
		}*/
		
		private void InitializeMessages()
		{
			MessagesHolder = new PlaceHolder();
			Controls.Add(MessagesHolder);
		}
		
		private void CreateButton_Click(object sender, EventArgs e)
		{
			string url = UrlCreator.Current.CreateUrl("Create", "Message") + "?SubjectType=" + SubjectType + "&SubjectID=" + SubjectID;
			
			Page.Response.Redirect(url);
		}
		
	}
}
