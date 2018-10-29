using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Data;
using SoftwareMonkeys.WorkHub.Modules.Messages.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Business
{
	/// <summary>
	/// 
	/// </summary>
	public class MarkMessageAsReadStrategy : BaseStrategy
	{
		public MarkMessageAsReadStrategy()
		{
		}
		
		public void MarkAsRead(Message message)
		{
			if (AuthenticationState.IsAuthenticated)
			{
				if (!CheckReadMessageStrategy.New().IsRead(message))
				{
					ReadMessageMarker marker = CreateStrategy.New<ReadMessageMarker>().Create<ReadMessageMarker>();
					marker.Message = message;
					marker.User = AuthenticationState.User;
				
					SaveStrategy.New(marker).Save(marker);
				}
			}
		}
		
		public void MarkAsUnread(Message message)
		{
			if (AuthenticationState.IsAuthenticated)
			{
				if (CheckReadMessageStrategy.New().IsRead(message))
				{
					ReadMessageMarker marker = CheckReadMessageStrategy.New().GetExistingMarker(message);
				
					DataAccess.Data.Deleter.Delete(marker);
				}
			}
		}
		
		static public MarkMessageAsReadStrategy New()
		{
			return new MarkMessageAsReadStrategy();
		}
	}
}
