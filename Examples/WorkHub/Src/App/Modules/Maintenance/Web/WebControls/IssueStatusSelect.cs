using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible issue status.
    /// </summary>
    public class IssueStatusSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the status selected by the user.
        /// </summary>
        public IssueStatus SelectedStatus
        {
            get { return (IssueStatus)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Pending, ((int)IssueStatus.Pending).ToString()));

            Items.Add(new ListItem(Language.Resolved, ((int)IssueStatus.Resolved).ToString()));

            Items.Add(new ListItem(Language.Closed, ((int)IssueStatus.Closed).ToString()));


            base.OnInit(e);
        }
    }
}