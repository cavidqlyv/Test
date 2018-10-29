using System.Web.UI.WebControls;

namespace TMSView.Utility
{
    public static class DropdownExtension
    {
        public static void BindData(this DropDownList ddl, string DataValueField, string DataTextField)
        {
            ddl.DataValueField = DataValueField;
            ddl.DataTextField = DataTextField;
            ddl.DataBind();
        }
    }
}