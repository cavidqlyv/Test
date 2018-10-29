using System;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Entities
{
	/// <summary>
	/// Represents a marker used to indicate that a particular user has read a particular message.
	/// </summary>
	public class ReadMessageMarker : BaseEntity
	{
		private Message message;
		[Reference()]
		public Message Message
		{
			get { return message; }
			set { message = value; }
		}
		
		private User user;
		[Reference]
		public User User
		{
			get { return user; }
			set { user = value;}
		}
		
		public ReadMessageMarker()
		{
		}
	}
}
