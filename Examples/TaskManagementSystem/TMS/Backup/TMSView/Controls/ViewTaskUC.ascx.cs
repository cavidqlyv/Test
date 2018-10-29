using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TMSView.TmsViewService;

namespace TMSView.Controls
{
    public partial class ViewTaskUC : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateTask();
        }


        #region Private Methods

        private void PopulateTask()
        {
            TmsClientService client = new TmsClientService();
            dgTask.DataSource = client.GetTaskList();
            dgTask.DataBind();

            //The flag column  color is set based onm the +ve and -ve values of Extra time
            Enumerable.Range(0, dgTask.Rows.Count).ToList().ForEach(i =>
            {
                int extraTime = Convert.ToInt32(dgTask.Rows[i].Cells[8].Text);

                dgTask.Rows[i].Cells[9].BackColor = extraTime > 0 ? System.Drawing.Color.Green
                                                                  : System.Drawing.Color.Red;
            });
        }

        #endregion

        protected void dgTask_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //Hide the PriorityID, StatusID  and UserID columns
            if ((e.Row.RowType == DataControlRowType.DataRow) || (e.Row.RowType == DataControlRowType.Header))
            { e.Row.Cells[11].Visible = e.Row.Cells[12].Visible = e.Row.Cells[13].Visible = false; }
        }

        protected void dgTask_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //On Edit button click, first build the query string and send it to the EditTask.aspx page
            Button btnEdit = (Button)e.Row.FindControl("btnEdit");
            if (e.Row.FindControl("btnEdit") != null)
            {
                const string strEditParams = "TaskID={0}&TaskName={1}&PriorityID={2}&StatusID={3}&UserID={4}&CreatedOn={5}&EstimatedTime={6}&ActualTime={7}";
                string strEditValues = string.Format(strEditParams,
                                                    e.Row.Cells[0].Text
                                                    , e.Row.Cells[1].Text
                                                    , e.Row.Cells[11].Text
                                                    , e.Row.Cells[12].Text
                                                    , e.Row.Cells[13].Text
                                                    , e.Row.Cells[5].Text
                                                    , e.Row.Cells[6].Text
                                                    , e.Row.Cells[7].Text
                                                    );
                btnEdit.Attributes.Add("onClick", "return OpenEditTask('EditTask.aspx?" + strEditValues + "')");

            }
        }

        protected void dgTask_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgTask.PageIndex = e.NewPageIndex;
            PopulateTask();
        }
    }
}