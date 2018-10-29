using System;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Configuration;
using System.Xml.Serialization;
using SoftwareMonkeys.WorkHub.Diagnostics;

namespace SoftwareMonkeys.WorkHub.Modules.Links.Entities
{
	/// <summary>
	/// Represents a link.
	/// </summary>
	[Serializable]
	public class Link : BaseAuthoredEntity, IMultiProjectItem
	{	
		private string title;
		/// <summary>
		/// Gets/sets the title of the link.
		/// </summary>
		public string Title
		{
			get { return title; }
			set { title = value;
			}
		}
		
		private string name;
		/// <summary>
		/// Gets/sets the name/title of the link.
		/// </summary>
		public string Name
		{
			get { return name; }
			set { name = value; }
		}

		private string summary;
		/// <summary>
		/// Gets/sets the summary of the link.
		/// </summary>
		public string Summary
		{
			get { return summary; }
			set { summary = value; }
		}
		
		private IProject[] files;
		/// <summary>
		/// Gets/sets the project that this link is part of.
		/// </summary>
		[Reference(TypeName="Project")]
		[XmlIgnore]
		public IProject[] Projects
		{
			get { return files; }
			set { files = value; }
		}
		
		private string url;
		/// <summary>
		/// Gets/sets the link URL.
		/// </summary>
		public string Url
		{
			get { return url; }
			set { url = value; }
		}
		
		#region Constructors
		/// <summary>
		/// Empty constructor.
		/// </summary>
		public Link()
		{}

		/// <summary>
		/// Sets the ID of the link.
		/// </summary>
		/// <param name="linkID">The ID of the link.</param>
		public Link(Guid linkID)
		{
			ID = linkID;
		}

		/// <summary>
		/// Gets the title of the link
		/// </summary>
		/// <returns>The title of the link.</returns>
		public override string ToString()
		{
			return Title;
		}
		#endregion
	
				
		string ISimple.Description {
			get {
				return Summary;
			}
			set {
				Summary = value;
			}
		}
	}
}
