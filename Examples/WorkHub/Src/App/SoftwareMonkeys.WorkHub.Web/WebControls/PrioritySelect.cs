using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Web.Properties;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible bug priority.
    /// </summary>
    public class PrioritySelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the priority selected by the user.
        /// </summary>
        public Priority SelectedPriority
        {
            get { return (Priority)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Extreme, ((int)Priority.Extreme).ToString()));

            Items.Add(new ListItem(Language.High, ((int)Priority.High).ToString()));

            Items.Add(new ListItem(Language.Moderate, ((int)Priority.Moderate).ToString()));

            Items.Add(new ListItem(Language.Low, ((int)Priority.Low).ToString()));

            Items.Add(new ListItem(Language.VeryLow, ((int)Priority.VeryLow).ToString()));


            base.OnInit(e);
        }
    }
}