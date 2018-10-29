using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Messages.Entities
{
	/// <summary>
	/// Represents a message.
	/// </summary>
	[Serializable]
	public class Message : BaseAuthoredEntity, IMultiProjectItem
	{
		private string title = String.Empty;
		/// <summary>
		/// Gets/sets the title of the message.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}

		private string body = String.Empty;
		/// <summary>
		/// Gets/sets the summary of the message.
		/// </summary>
		public string Body
		{
			get { return body; }
			set { body = value; }
		}
		
		private DateTime date = DateTime.MinValue;
		/// <summary>
		/// Gets/sets the date of the message.
		/// </summary>
		public DateTime Date
		{
			get { return date; }
			set { date = value; }
		}
		
		private IProject[] projects = new IProject[]{};
		/// <summary>
		/// Gets/sets the projects that this message is part of.
		/// </summary>
		[Reference(TypeName="Project")]
		[XmlIgnore]
		public IProject[] Projects
		{
			get { return projects; }
			set { projects = value; }
		}
		
		private Message[] replies = new Message[]{};
		/// <summary>
		/// Gets/sets the sub s.
		/// </summary>
		[Reference(MirrorPropertyName="Parent",
		          CountPropertyName="TotalReplies")]
		[XmlIgnore]
		public Message[] Replies
		{
			get { return replies; }
			set { replies = value; }
		}
		
		private int totalReplies = 0;
		public int TotalReplies
		{
			get { return totalReplies; }
			set { totalReplies = value; }
		}
		
		
		private Message parent;
		/// <summary>
		/// Gets/sets the parent message.
		/// </summary>
		[Reference(MirrorPropertyName="Replies")]
		[XmlIgnore]
		public Message Parent
		{
			get { return parent; }
			set { parent = value; }
		}
		
		private User[] recipients = new User[]{};
		/// <summary>
		/// Gets/sets the recipients of the message.
		/// </summary>
		[Reference(CountPropertyName="TotalRecipients")]
		[XmlIgnore]
		public User[] Recipients
		{
			get { return recipients; }
			set { recipients = value; }
		}
		
		private int totalRecipients = 0;
		public int TotalRecipients
		{
			get { return totalRecipients; }
			set { totalRecipients = value; }
		}
		
		private User sender;
		/// <summary>
		/// Gets/sets the sender of the message.
		/// </summary>
		[Reference(MirrorPropertyName="Recipients")]
		[XmlIgnore]
		public User Sender
		{
			get { return sender; }
			set { sender = value; }
		}
		
		[NonSerialized]
		private IEntity subject;
		/// <summary>
		/// Gets/sets the subject/target of the message.
		/// </summary>
		[Reference(TypePropertyName="SubjectTypeName")]
		[XmlIgnore]
		public IEntity Subject
		{
			get { return subject; }
			set { subject = value;
				if (subject != null)
					SubjectTypeName = subject.ShortTypeName;
			}
		}
		
		private string subjectTypeName = String.Empty;
		public string SubjectTypeName
		{
			get { return subjectTypeName; }
			set { subjectTypeName = value; }
		}
		
		private bool isPublic;
		public bool IsPublic
		{
			get { return isPublic; }
			set { isPublic = value; }
		}
		
		private int totalVotes = 0;
		public int TotalVotes
		{
			get { return totalVotes; }
			set { totalVotes = value; }
		}
		
		private int votesBalance = 0;
		public int VotesBalance
		{
			get { return votesBalance; }
			set { votesBalance = value; }
		}
		
		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Message()
		{}

		/// <summary>
		/// Sets the ID of the message.
		/// </summary>
		/// <param name="ID">The ID of the message.</param>
		public Message(Guid id)
		{
			ID = id;
		}

		/// <summary>
		/// Gets the title of the message.
		/// </summary>
		/// <returns>The title of the .</returns>
		public override string ToString()
		{
			return Title;
		}
		#endregion
	
		
		string ISimple.Title {
			get {
				return Title;
			}
			set {
				Title = value;
			}
		}
		
		string ISimple.Description {
			get {
				return Body;
			}
			set {
				Body = value;
			}
		}
	}
}
