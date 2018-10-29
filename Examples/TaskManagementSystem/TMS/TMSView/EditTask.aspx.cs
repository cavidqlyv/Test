using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TMSView
{
    public partial class EditTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TaskUC1.TaskName = "Edit Existing Task";
                TaskUC1.Visibility = true;
                TaskUC1.IsInsert = false;
            }
        }
    }
}