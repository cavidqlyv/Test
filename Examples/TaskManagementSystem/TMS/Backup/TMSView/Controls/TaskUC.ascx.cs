using System;
using TMSView.TmsServiceReference;
using TMSView.TmsViewService;
using TMSView.Utility;

namespace TMSView.Controls
{
    public partial class TaskUC : System.Web.UI.UserControl
    {
        #region Properties

        public string TaskName { get; set; }
        public bool Visibility { get; set; }
        public bool IsInsert { get; set; }

        #endregion

        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Initialize();
            }

           btnSubmit.Attributes.Add("onClick", "return Validate();");//Validates the page before submission
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            TmsClientService client = new TmsClientService();

           var result =  client.SaveTask(new Task{
                TaskID = IsInsert ? 0 : Convert.ToInt32(Request["TaskID"])
               ,
                TaskName = txtTaskName.Text
                ,
                PriorityID = Convert.ToInt32(ddlPriority.SelectedValue)
                 ,
                PriorityName = ddlPriority.SelectedItem.Text
                ,
                StatusID = Convert.ToInt32(ddlStatus.SelectedValue)
                 ,
                StatusName = ddlStatus.SelectedItem.Text
                ,
                UserID = Convert.ToInt32(ddlAssignedTo.SelectedValue)
                ,
                UserName = ddlAssignedTo.SelectedItem.Text
                ,
                CreatedOn = Convert.ToDateTime(txtTaskCreationDate.Text)
                ,
                EstimatedTime = Convert.ToInt32(txtEstimatedTime.Text)
                ,
                ActualTime = IsInsert ? 0 : Convert.ToInt32(txtActualTime.Text)
           }, IsInsert);
           PostSubmitActivity();
        }

        #endregion

        #region Private methods

        private void Initialize()
        {
            lblTaskScreen.Text = TaskName;
            lblMessage.Visible = false;
            lblActualTime.Visible = txtActualTime.Visible = Visibility;
            calImgCreationDate.Attributes.Add("onclick", "javascript:showCalendarControl(" + txtTaskCreationDate.ClientID + ",'" + "1" + "','mm/dd/yyyy'); return false;");
            PopulateLookups();

            //This portion will execute for Edit Task operation
            if (!IsInsert)
            {
                txtTaskName.Text = Request["TaskName"].ToString();
                ddlPriority.SelectedIndex = Convert.ToInt32(Request["PriorityID"]);
                ddlStatus.SelectedIndex = Convert.ToInt32(Request["StatusID"]);
                ddlAssignedTo.SelectedIndex = Convert.ToInt32(Request["UserID"]);
                txtTaskCreationDate.Text = Request["CreatedOn"].ToString();
                txtEstimatedTime.Text = Request["EstimatedTime"].ToString();
                txtActualTime.Text = Request["ActualTime"].ToString();
                txtTaskName.Enabled = false;
            }
        }

        //Populate the combo boxes
        private void PopulateLookups()
        {
            TmsClientService client = new TmsClientService();

            PopulateLookups(client, ddlPriority, (int)Constants.LookupOrder.PRIORITY);
            PopulateLookups(client, ddlStatus, (int)Constants.LookupOrder.STATUS);
            PopulateLookups(client, ddlAssignedTo, (int)Constants.LookupOrder.RESOURCE);
        }

        private void PopulateLookups(TmsClientService client, System.Web.UI.WebControls.DropDownList ddl, int fillOrder)
        {
            switch (fillOrder)
            {
                case 1:
                    ddl.DataSource = client.GetPriority();
                    ddl.BindData(Constants.PRIORITY_ID, Constants.PRIORITY_NAME);
                    break;

                case 2:
                    ddl.DataSource = client.GetStatus();
                    ddl.BindData(Constants.STATUS_ID, Constants.STATUS_NAME);
                    break;

                case 3:
                    ddl.DataSource = client.GetResource();
                    ddl.BindData(Constants.RESOURCE_ID, Constants.RESOURCE_NAME);
                    break;
            }
        }

        private void PostSubmitActivity()
        {
            if (IsInsert)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Record successfully inserted";
            }
            else // for edit operation
            {
                this.Page.ClientScript.RegisterClientScriptBlock(typeof(string), "EditTask", "<script>javascript:window.close();</script>");
                lblMessage.Visible = true;
                lblMessage.Text = "Record successfully updated";
            }
        }

        #endregion       
    }
}