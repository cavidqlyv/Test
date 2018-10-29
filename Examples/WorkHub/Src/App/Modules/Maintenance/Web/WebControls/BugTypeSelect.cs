using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties;
using SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities;

namespace SoftwareMonkeys.WorkHub.Modules.Maintenance.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible bug status.
    /// </summary>
    public class BugTypeSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the %%Enumeration%% selected by the user.
        /// </summary>
        public BugType SelectedType
        {
            get { return (BugType)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";
            
            Items.Add(new ListItem(Language.NotSet, ((int)BugType.NotSet).ToString()));
            
            Items.Add(new ListItem(Language.Cosmetic, ((int)BugType.Cosmetic).ToString()));

            Items.Add(new ListItem(Language.Functional, ((int)BugType.Functional).ToString()));

            Items.Add(new ListItem(Language.Security, ((int)BugType.Security).ToString()));

            Items.Add(new ListItem(Language.Performance, ((int)BugType.Performance).ToString()));

            Items.Add(new ListItem(Language.Hidden, ((int)BugType.Hidden).ToString()));


            base.OnInit(e);
        }
    }
}