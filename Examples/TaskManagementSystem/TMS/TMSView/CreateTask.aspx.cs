using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TMSView
{
    public partial class CreateTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TaskUC1.TaskName = "Create New Task";
                TaskUC1.Visibility = false;
                TaskUC1.IsInsert = true;
            }
            else
            {
                TaskUC1.IsInsert = true;
            }
        }
    }
}