using System;
using System.Web.UI.WebControls;
using SoftwareMonkeys.WorkHub.Web.Properties;
using SoftwareMonkeys.WorkHub.Entities;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
    /// <summary>
    /// Displays a DropDownList for selecting a possible bug difficulty.
    /// </summary>
    public class DifficultySelect : DropDownList
    {
        /// <summary>
        /// Gets/sets the difficulty selected by the user.
        /// </summary>
        public Difficulty SelectedDifficulty
        {
            get { return (Difficulty)Convert.ToInt32(SelectedItem.Value); }
            set { SelectedIndex = Items.IndexOf(Items.FindByValue(((int)value).ToString())); }
        }

        /// <summary>
        /// Adds the options to the control.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            CssClass = "Field";

            Items.Add(new ListItem(Language.Extreme, ((int)Difficulty.Extreme).ToString()));

            Items.Add(new ListItem(Language.High, ((int)Difficulty.High).ToString()));

            Items.Add(new ListItem(Language.Moderate, ((int)Difficulty.Moderate).ToString()));

            Items.Add(new ListItem(Language.Low, ((int)Difficulty.Low).ToString()));

            Items.Add(new ListItem(Language.VeryLow, ((int)Difficulty.VeryLow).ToString()));


            base.OnInit(e);
        }
    }
}