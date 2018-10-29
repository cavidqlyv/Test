using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Collections;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Modules;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
	/// <summary>
	/// Displays the module configuration panel.
	/// </summary>
	public class ModuleControlConfiguration : WebControl
	{
        private Table table;

        [Browsable(true)]
        [Bindable(true)]
        [Category("Data")]
        public string ModuleID
        {
            get
            {
                if (ViewState["ModuleID"] == null)
                    ViewState["ModuleID"] = String.Empty;
                return (string)ViewState["ModuleID"];
            }
            set
            {
                ViewState["ModuleID"] = value;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            

            base.OnInit(e);
        }

        protected override void OnLoad(EventArgs e)
        {
  

            base.OnLoad(e);
        }

        public override void DataBind()
        {
            base.DataBind();

            table = new Table();
            Controls.Add(table);
            table.Width = Unit.Percentage(100);

            TableRow headingRow = new TableRow();
            TableCell headingCell = new TableCell();
            headingCell.ColumnSpan = 2;
            headingRow.Cells.Add(headingCell);

            headingCell.CssClass = "Heading2"; // TODO: Should this be hardcoded?
            headingCell.Text = "Control Configuration";
            table.Rows.Add(headingRow);

            string[] controls = new ModuleLoader().GetControls(ModuleID);

            foreach (string control in controls)
            {
                TableRow controlRow = new TableRow();
                TableCell controlCell = new TableCell();
                controlCell.Text = "<b>" + control + "</b>";
                controlCell.ColumnSpan = 2;
                controlRow.Cells.Add(controlCell);
                table.Rows.Add(controlRow);

                TableRow menuEnabledRow = new TableRow();
                table.Rows.Add(menuEnabledRow);
                TableCell menuEnabledCell = new TableCell();
                menuEnabledCell.Text = "&nbsp;&nbsp;&nbsp;Enabled on Menu:</b>"; // TODO: These should be language packed
                menuEnabledCell.CssClass = "FieldLabel";
                menuEnabledRow.Cells.Add(menuEnabledCell);
                TableCell menuEnabledFieldCell = new TableCell();
                CheckBox menuEnabledField = new CheckBox();
                menuEnabledField.Width = Unit.Pixel(300);
                menuEnabledField.ID = control + "MenuEnabledField";
                menuEnabledField.Text = "Yes, show this control on the menu";
                menuEnabledFieldCell.Controls.Add(menuEnabledField);
                menuEnabledRow.Cells.Add(menuEnabledFieldCell);

                TableRow menuTextRow = new TableRow();
                table.Rows.Add(menuTextRow);
                TableCell menuTextCell = new TableCell();
                menuTextCell.Text = "&nbsp;&nbsp;&nbsp;Menu Text:</b>"; // TODO: These should be language packed
                menuTextCell.CssClass = "FieldLabel";
                menuTextRow.Cells.Add(menuTextCell);
                TableCell menuTextFieldCell = new TableCell();
                TextBox menuTextField = new TextBox();
                menuTextField.Text = control;
                menuTextField.Width = Unit.Pixel(300);
                menuTextField.ID = control + "MenuTextField";
                menuTextFieldCell.Controls.Add(menuTextField);
                menuTextRow.Cells.Add(menuTextFieldCell);

                TableRow menuCategoryRow = new TableRow();
                table.Rows.Add(menuCategoryRow);
                TableCell menuCategoryCell = new TableCell();
                menuCategoryCell.Text = "&nbsp;&nbsp;&nbsp;Menu Category:</b>"; // TODO: These should be language packed
                menuCategoryCell.CssClass = "FieldLabel";
                menuCategoryRow.Cells.Add(menuCategoryCell);
                TableCell menuCategoryFieldCell = new TableCell();
                TextBox menuCategoryField = new TextBox();
                menuCategoryField.Text = control;
                menuCategoryField.Width = Unit.Pixel(300);
                menuCategoryField.ID = control + "MenuCategoryField";
                menuCategoryFieldCell.Controls.Add(menuCategoryField);
                menuCategoryRow.Cells.Add(menuCategoryFieldCell);
            }
        }
	}
}
