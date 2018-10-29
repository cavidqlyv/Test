using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Configuration;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;
using SoftwareMonkeys.WorkHub.State;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business
{
	/// <summary>
	/// 
	/// </summary>
	[Strategy("Notify", "Message")]
	public class NotifyMessageStrategy : NotifyStrategy
	{
		public string ApplicationUrl = String.Empty;
		public string MessageUrl = String.Empty;
		
		public NotifyMessageStrategy()
		{
		}
		
		public void SendNotification(Message message)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Sending notification of a message."))
			{
				string messageTitle = message.Title;
				string messageBody = DynamicLanguage.GetText(GetType(), "NotifyMessageBody");
				
				messageBody = PrepareNotificationText(messageBody, message);
				
				if (message.Recipients == null || message.Recipients.Length == 0)
					ActivateStrategy.New(message).Activate(message, "Recipients");
				
				LogWriter.Debug("Recipients: " + message.Recipients.Length.ToString());
				
				if (message.Recipients != null && message.Recipients.Length > 0)
					SendNotification(message.Recipients, message, messageTitle, messageBody);
				else
					LogWriter.Debug("No recipients. Skipping notification.");
			}
		}
		
		protected override string PrepareNotificationText(string original, SoftwareMonkeys.WorkHub.Entities.IEntity entity)
		{
			Message message = (Message)entity;
			
			if (message.Sender == null)
				ActivateStrategy.New(message).Activate(message, "Sender");
			
			original = original.Replace("${Application.Title}", Config.Application.Title);
			original = original.Replace("${Application.Url}", ApplicationUrl);
			original = original.Replace("${Message.Sender.Name}", message.Sender.Name);
			original = original.Replace("${Message.Url}", MessageUrl);
			original = original.Replace("${Message.Title}", message.Title);
			original = original.Replace("${Message.Body}", message.Body);
			
			return original;
		}
		
		static public NotifyMessageStrategy New(string applicationUrl, string messageUrl)
		{
			NotifyMessageStrategy strategy = null;
			
			using (LogGroup logGroup = LogGroup.StartDebug("Creating a new NotifyMessageStrategy."))
			{
				LogWriter.Debug("Application URL: " + applicationUrl);
				LogWriter.Debug("Message URL: " + messageUrl);
				
				strategy = new NotifyMessageStrategy();
				
				strategy.ApplicationUrl = applicationUrl;
				strategy.MessageUrl = messageUrl;
			}
			return strategy;
		}
	}
}
