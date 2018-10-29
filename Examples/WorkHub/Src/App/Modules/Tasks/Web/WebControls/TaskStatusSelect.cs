using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Properties;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible task status.
    /// </summary>
    public class TaskStatusSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the status selected by the user.
        /// </summary>
        public TaskStatus SelectedStatus
        {
            get { return (TaskStatus)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Pending, ((int)TaskStatus.Pending).ToString()));
            Items.Add(new ListItem(Language.InProgress, ((int)TaskStatus.InProgress).ToString()));
            Items.Add(new ListItem(Language.OnHold, ((int)TaskStatus.OnHold).ToString()));
            Items.Add(new ListItem(Language.Completed, ((int)TaskStatus.Completed).ToString()));
            Items.Add(new ListItem(Language.Tested, ((int)TaskStatus.Tested).ToString()));


            base.OnInit(e);
        }
    }
}