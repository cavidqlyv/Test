using System;
using System.Collections.Generic;
using System.Text;
using SoftwareMonkeys.WorkHub.Modules.Planning.Properties;
using SoftwareMonkeys.WorkHub.Modules.Planning.Entities;
using System.Web.UI.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible bug status.
    /// </summary>
    public class ProjectEntityPropertyTypeSelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the type selected by the user.
        /// </summary>
        public ProjectEntityPropertyType SelectedType
        {
            get { return (ProjectEntityPropertyType)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Text, ((int)ProjectEntityPropertyType.Text).ToString()));

            Items.Add(new ListItem(Language.LongText, ((int)ProjectEntityPropertyType.LongText).ToString()));

            Items.Add(new ListItem(Language.Number, ((int)ProjectEntityPropertyType.Number).ToString()));

            Items.Add(new ListItem(Language.DateTime, ((int)ProjectEntityPropertyType.DateTime).ToString()));

            Items.Add(new ListItem(Language.Password, ((int)ProjectEntityPropertyType.Password).ToString()));

            Items.Add(new ListItem(Language.Options, ((int)ProjectEntityPropertyType.Options).ToString()));

            Items.Add(new ListItem(Language.Entities, ((int)ProjectEntityPropertyType.Entities).ToString()));

            Items.Add(new ListItem(Language.Other, ((int)ProjectEntityPropertyType.Other).ToString()));


            base.OnInit(e);
        }
    }
}
