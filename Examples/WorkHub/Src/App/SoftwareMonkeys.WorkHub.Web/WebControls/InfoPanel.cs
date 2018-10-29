using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Web.UI;
using SoftwareMonkeys.WorkHub.Web.Properties;

namespace SoftwareMonkeys.WorkHub.Web.WebControls
{
    public class InfoPanel : Panel
    {
        protected Table HolderTable = new Table();

        public Panel CollapsedPanel = new Panel();

        public Panel ExpandedPanel = new Panel();

        /// <summary>
        /// Gets/sets a boolean value indicating whether the info panel is expanded.
        /// </summary>
        [Bindable(true)]
        [Browsable(true)]
        public bool Expanded
        {
            get
            {
                if (ViewState["Expanded"] == null)
                    ViewState["Expanded"] = false;
                return (bool)ViewState["Expanded"];
            }
            set { ViewState["Expanded"] = value; }
        }

        /// <summary>
        /// Gets/sets the text displayed on the info panel when collapsed.
        /// </summary>
        [Bindable(true)]
        [Browsable(true)]
        public string CollapsedText
        {
            get
            {
                if (ViewState["CollapsedText"] == null)
                    ViewState["CollapsedText"] = Properties.Language.FieldInfo;
                return (string)ViewState["CollapsedText"];
            }
            set { ViewState["CollapsedText"] = value; }
        }

        /// <summary>
        /// Gets/sets the text displayed on the info panel when expanded.
        /// </summary>
        [Bindable(true)]
        [Browsable(true)]
        public string ExpandedText
        {
            get
            {
                if (ViewState["ExpandedText"] == null)
                    ViewState["ExpandedText"] = Properties.Language.NoFieldInfoAvailable;
                return (string)ViewState["ExpandedText"];
            }
            set { ViewState["ExpandedText"] = value; }
        }

        public override string CssClass
        {
            get
            {
                return base.CssClass;
            }
            set
            {
                base.CssClass = value;
                if (HolderTable == null)
                    HolderTable.CssClass = value;
            }
        }

        public override Unit Width
        {
            get
            {
                return base.Width;
            }
            set
            {
                base.Width = value;
                HolderTable.Width = value;
            }
        }

        protected override void OnInit(EventArgs e)
        {
            CssClass = "InfoPanel";

            HolderTable.Rows.Add(new TableRow());
            HolderTable.Rows[0].Cells.Add(new TableCell());
            HolderTable.Rows[0].Cells.Add(new TableCell());
            HolderTable.CellSpacing = 0;
            HolderTable.CellPadding = 0;

            CollapsedPanel.ID = ID + "_Collapsed";
            CollapsedPanel.CssClass = "Collapsed";
            ExpandedPanel.ID = ID + "_Expanded";
            ExpandedPanel.CssClass = "Expanded";
            CollapsedPanel.Controls.Add(new HyperLink());
            ((HyperLink)CollapsedPanel.Controls[0]).NavigateUrl = "javascript:switchInfoPanel('" + ClientID + "');";
            ExpandedPanel.Controls.Add(new LiteralControl());
            HolderTable.Rows[0].Cells[1].Controls.Add(CollapsedPanel);
            HolderTable.Rows[0].Cells[1].Controls.Add(ExpandedPanel);
            HolderTable.Rows[0].Cells[1].Width = Unit.Percentage(100);

            HyperLink link = new HyperLink();
            link.NavigateUrl = "javascript:switchInfoPanel('" + ClientID + "');";
            link.Text = "?";
            HolderTable.Rows[0].Cells[0].Controls.Add(link);
            HolderTable.Rows[0].Cells[0].CssClass = "SwitchButton";

            string script = @"<script language='javascript'>
                function switchInfoPanel(clientID)
                {
                    if (document.getElementById(clientID + '_Expanded').style.display == 'none')
                    {
                   //     document.getElementById(clientID + '_Collapsed').style.display = 'none';
                        document.getElementById(clientID + '_Expanded').style.display = '';
                    }
                    else
                    {
                     //   document.getElementById(clientID + '_Collapsed').style.display = '';
                        document.getElementById(clientID + '_Expanded').style.display = 'none';
                    }
                }
                </script>";

            Page.RegisterClientScriptBlock("InfoPanel", script);
           // Page.RegisterClientScriptBlock(ClientID + "InfoPanel", "<script language='javascript'>var " + ClientID + @"InfoPanelExpanded = " + Expanded.ToString() + @";</script>");

            Controls.Add(HolderTable);

            base.OnInit(e);
        }

        public override void DataBind()
        {
            
            base.DataBind();

           
        }

        protected override void OnPreRender(EventArgs e)
        {
            if (ID == null)
                throw new InvalidOperationException("The ID of the info panel is required for it to function.");
          
            ((HyperLink)CollapsedPanel.Controls[0]).Text = CollapsedText;
            ((LiteralControl)ExpandedPanel.Controls[0]).Text = ExpandedText;

            if (!Expanded)
            {
               // CollapsedPanel.Style.Add("display", "");
                ExpandedPanel.Style.Add("display", "none");
            }
            else
            {
               // CollapsedPanel.Style.Add("display", "none");
                ExpandedPanel.Style.Add("display", "");
            }

            base.OnPreRender(e);
        }
    }
}
