using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Ideas.Entities
{
	/// <summary>
	/// Represents a idea.
	/// </summary>
	[Serializable]
	public class Idea : BaseAuthoredEntity, IMultiProjectItem
	{	
		private string details;
		/// <summary>
		/// Gets/sets the details of the idea.
		/// </summary>
		[Required]
		public string Details
		{
			get { return details; }
			set { details = value; }
		}
		
		private IProject[] files;
		/// <summary>
		/// Gets/sets the project that this idea is part of.
		/// </summary>
		[Reference(TypeName="Project")]
		[XmlIgnore]
		public IProject[] Projects
		{
			get { return files; }
			set { files = value; }
		}
		
		private Idea[] subIdeas;
		/// <summary>
		/// Gets/sets the sub ideas.
		/// </summary>
		[Reference(MirrorPropertyName="ParentIdeas")]
		[XmlIgnore]
		public Idea[] SubIdeas
		{
			get { return subIdeas; }
			set { subIdeas = value; }
		}
		
		private Idea[] parentIdeas;
		/// <summary>
		/// Gets/sets the parent ideas.
		/// </summary>
		[Reference(MirrorPropertyName="SubIdeas")]
		[XmlIgnore]
		public Idea[] ParentIdeas
		{
			get { return parentIdeas; }
			set { parentIdeas = value; }
		}
		
		private Idea[] relatedIdeas;
		/// <summary>
		/// Gets/sets the related ideas.
		/// </summary>
		[Reference(MirrorPropertyName="RelatedIdeas")]
		[XmlIgnore]
		public Idea[] RelatedIdeas
		{
			get { return relatedIdeas; }
			set { relatedIdeas = value; }
		}

		private int demandVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'demand' votes.
		/// </summary>
		public int DemandVotesBalance
		{
			get { return demandVotesBalance; }
			set { demandVotesBalance = value; }
		}
		
		private int totalDemandVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'demand' votes.
		/// </summary>
		public int TotalDemandVotes
		{
			get { return totalDemandVotes; }
			set { totalDemandVotes = value; }
		}

		private int achievedVotesBalance = 0;
		/// <summary>
		/// Gets/sets the current balance of 'achieved' votes.
		/// </summary>
		public int AchievedVotesBalance
		{
			get { return achievedVotesBalance; }
			set { achievedVotesBalance = value; }
		}
		
		private int totalAchievedVotes = 0;
		/// <summary>
		/// Gets/sets the total number of 'achieved' votes.
		/// </summary>
		public int TotalAchievedVotes
		{
			get { return totalAchievedVotes; }
			set { totalAchievedVotes = value; }
		}


		
		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Idea()
		{}

		/// <summary>
		/// Sets the ID of the idea.
		/// </summary>
		/// <param name="ideaID">The ID of the idea.</param>
		public Idea(Guid ideaID)
		{
			ID = ideaID;
		}

		/// <summary>
		/// Gets the title of the idea
		/// </summary>
		/// <returns>The title of the idea.</returns>
		public override string ToString()
		{
			return Details;
		}
		#endregion
	
		
		string ISimple.Title {
			get {
				return "";
			}
			set {
				
			}
		}
		
		string ISimple.Description {
			get {
				return Details;
			}
			set {
				Details = value;
			}
		}
	}
}
