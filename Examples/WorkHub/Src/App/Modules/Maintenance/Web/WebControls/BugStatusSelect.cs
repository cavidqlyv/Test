using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible bug status.
    /// </summary>
    public class BugStatusSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the %%Enumeration%% selected by the user.
        /// </summary>
        public BugStatus SelectedStatus
        {
            get { return (BugStatus)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Pending, ((int)BugStatus.Pending).ToString()));

            Items.Add(new ListItem(Language.InProgress, ((int)BugStatus.InProgress).ToString()));

            Items.Add(new ListItem(Language.OnHold, ((int)BugStatus.OnHold).ToString()));

            Items.Add(new ListItem(Language.Fixed, ((int)BugStatus.Fixed).ToString()));

            Items.Add(new ListItem(Language.Tested, ((int)BugStatus.Tested).ToString()));


            base.OnInit(e);
        }
    }
}