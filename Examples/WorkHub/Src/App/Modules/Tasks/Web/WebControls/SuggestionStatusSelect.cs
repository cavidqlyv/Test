using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Properties;
using SoftwareMonkeys.WorkHub.Modules.Tasks.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Tasks.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible suggestion status.
    /// </summary>
    public class SuggestionStatusSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the status selected by the user.
        /// </summary>
        public SuggestionStatus SelectedStatus
        {
            get { return (SuggestionStatus)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Pending, ((int)SuggestionStatus.Pending).ToString()));

            Items.Add(new ListItem(Language.Accepted, ((int)SuggestionStatus.Accepted).ToString()));

            Items.Add(new ListItem(Language.Implemented, ((int)SuggestionStatus.Implemented).ToString()));


            base.OnInit(e);
        }
    }
}