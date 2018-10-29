using System;
using System.Web;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Messages.Business;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.Modules.Messages.Properties;
using SoftwareMonkeys.WorkHub.Web;
using SoftwareMonkeys.WorkHub.Web.Controllers;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Web.Navigation;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Web.Controllers
{
	/// <summary>
	/// 
	/// </summary>
	[Controller("Create", "Message")]
	public class CreateMessageController : CreateController
	{
		public CreateMessageController()
		{
		}
		
		public override SoftwareMonkeys.WorkHub.Entities.IEntity Create()
		{
			Message message = null;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Creating a new message."))
			{
				message = (Message)base.Create();
				
				SetDefaultProperties(message);
			}
			return message;
		}
		
		protected virtual void SetDefaultProperties(Message message)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Setting default properties of the message as specified by query strings."))
			{
				LogWriter.Debug("Parent ID: " + QueryStrings.GetID("Parent").ToString());
				LogWriter.Debug("Subject ID: " + QueryStrings.GetID("Subject").ToString());
				LogWriter.Debug("Subject type: " + HttpContext.Current.Request.QueryString["SubjectType"]);
				
				if (QueryStrings.GetID("Parent") != Guid.Empty)
				{
					message.Parent = RetrieveStrategy.New<Message>().Retrieve<Message>("ID", QueryStrings.GetID("Parent"));
					ActivateStrategy.New(message.Parent).Activate(message.Parent, "Sender");
					
					message.Title = Language.Re + ": " + message.Parent.Title;
				}
				
				if (QueryStrings.GetID("Subject") != Guid.Empty
				    && HttpContext.Current.Request.QueryString["SubjectType"] != null
				    && HttpContext.Current.Request.QueryString["SubjectType"] != String.Empty)
				{
					message.Subject = (ISimple)RetrieveStrategy.New(HttpContext.Current.Request.QueryString["SubjectType"]).Retrieve("ID", QueryStrings.GetID("Subject"));
				}
				
				// If the subject property is null but the parent property is NOT null then
				// use the subject assigned to the parent message
				if (message.Subject == null
				    && message.Parent != null)
				{
					ActivateStrategy.New(message).Activate(message.Parent, "Subject");
					message.Subject = message.Parent.Subject;
				}
				
				if (QueryStrings.GetID("Recipient") != Guid.Empty)
				{
					message.Recipients = new User[] {
						RetrieveStrategy.New<User>().Retrieve<User>("ID", QueryStrings.GetID("Recipient"))
					};
				}
				
				// If the message is about a particular subject and has no set recipients then it's a public message
				if (message.Subject != null && (message.Recipients == null || message.Recipients.Length == 0))
					message.IsPublic = true;
				
				// Otherwise if the message has a public parent then it's a public message
				else if (message.Parent != null && message.Parent.IsPublic == true)
					message.IsPublic = true;
				
				// Otherwise if it's a discussion message then it's a public message
				else if (HttpContext.Current.Request.QueryString["IsDiscussion"] == true.ToString())
					message.IsPublic = true;
				
				LogWriter.Debug("Message subject: " + (message.Subject != null ? message.Subject.ToString() : "[null]"));
			}
		}
		
		public override void ExecutePreSave(IEntity entity)
		{
			SetDefaultProperties((Message)entity);
			
			base.ExecutePreSave(entity);
		}
		
		public override void ExecutePostSave(IEntity entity)
		{
			LogWriter.Debug("Save succeeded. Sending notification.");
			
			string applicationUrl = new UrlConverter().ToAbsolute(HttpContext.Current.Request.ApplicationPath);
			string messageUrl = new UrlConverter().ToAbsolute(new UrlCreator().CreateUrl("View", entity));
			
			LogWriter.Debug("Application URL: " + applicationUrl);
			LogWriter.Debug("Message URL: " + messageUrl);
			
			NotifyMessageStrategy.New(applicationUrl, messageUrl).SendNotification((Message)entity);

			base.ExecutePostSave(entity);
		}
		
		public override void NavigateAfterSave()
		{
			if (((Message)DataSource).Subject == null)
				ActivateStrategy.New(DataSource).Activate(DataSource, "Subject");
			
			// If a subject is assigned then return to viewing the subject (along with the messages)
			if (((Message)DataSource).Subject != null)
				Navigator.Current.Go("View", ((Message)DataSource).Subject);
			else
				base.NavigateAfterSave();
		}
	}
}
