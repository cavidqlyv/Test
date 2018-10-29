using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Entities
{
	/// <summary>
	/// Represents a vote.
	/// </summary>
	[Serializable]
	public class Vote : BaseEntity
	{	
		private bool isFor;
		/// <summary>
		/// Gets/sets a value indicating whether the voter is voting for the subject (ie. positive/in favor). If false then the voter is voting against the subject.
		/// </summary>
		public bool IsFor
		{
			get { return isFor; }
			set { isFor = value;
			}
		}
		
		private User voter;
		/// <summary>
		/// Gets/sets the voter.
		/// </summary>
		[Reference()]
		[XmlIgnore]
		public User Voter
		{
			get { return voter; }
			set { voter = value; }
		}
		
		private IEntity subject;
		[Reference(TypePropertyName="SubjectTypeName")]
		[XmlIgnore]
		public IEntity Subject
		{
			get { return subject; }
			set { subject = value;
				if (value != null)
					SubjectTypeName = value.ShortTypeName;
			}
		}
		
		private string subjectTypeName = String.Empty;
		public string SubjectTypeName
		{
			get { return subjectTypeName; }
			set { subjectTypeName = value; }
		}
		
		private string balanceProperty = String.Empty;
		/// <summary>
		/// Gets/sets the name of the property containing the balance of votes. (Optional)
		/// </summary>
		public string BalanceProperty
		{
			get { return balanceProperty; }
			set { balanceProperty = value; }
		}
		
		private string totalProperty = String.Empty;
		/// <summary>
		/// Gets/sets the name of the property containing the total number of votes. (Optional)
		/// </summary>
		public string TotalProperty
		{
			get { return totalProperty; }
			set { totalProperty = value; }
		}
		
		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Vote()
		{}

		/// <summary>
		/// Sets the ID of the vote.
		/// </summary>
		/// <param name="voteID">The ID of the vote.</param>
		public Vote(Guid voteID)
		{
			ID = voteID;
		}

		/// <summary>
		/// Gets the title of the vote
		/// </summary>
		/// <returns>The title of the vote.</returns>
		public override string ToString()
		{
			return IsFor.ToString();
		}
		#endregion
	
		
	}
}
