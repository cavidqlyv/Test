using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Projects.Properties;
using SoftwareMonkeys.WorkHub.Modules.Projects.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls
{
	/// <summary>
	/// Displays a DropDownList for selecting a project status.
	/// </summary>
	public class ProjectVisibilitySelect : DropDownList
	{
		/// <summary>
		/// Gets/sets the status selected by the user.
		/// </summary>
		public ProjectVisibility SelectedVisibility
		{
			get { return (ProjectVisibility)Convert.ToInt32(SelectedItem.Value); }
			set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
		}

		/// <summary>
		/// Adds the options to the control.
		/// </summary>
		/// <param name="e"></param>
		protected override void OnInit(EventArgs e)
		{
            Items.Add(new ListItem(Language.Public, ((int)ProjectVisibility.Public).ToString()));
            Items.Add(new ListItem(Language.Private, ((int)ProjectVisibility.Private).ToString()));

			base.OnInit(e);
		}
	}
}
