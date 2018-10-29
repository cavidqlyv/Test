<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<script runat="server">
    public string ProjectName
    {
        get { return (string)ViewState["ProjectName"]; }
        set { ViewState["ProjectName"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ReportIssue();
        }
    }

    #region Main functions
   
    /// <summary>
    /// Displays the form for creating a new issue.
    /// </summary>
    public void ReportIssue()
    {
    	// Anonymous people can report issues
        //Authorisation.EnsureUserCan("Create", typeof(Issue));

        Guid projectID = Guid.Empty;
    
        // Parse the project ID
        try
        {
        	if (Request.QueryString["ProjectID"] != null)
            	ProjectsState.ProjectID = new Guid(Request.QueryString["ProjectID"]);
        }
        catch { }

		IEntity project = ProjectsState.Project;

        OperationManager.StartOperation("ReportIssue", FormView);

        Issue issue = new Issue();
        issue.ID = Guid.NewGuid();
        issue.DateReported = DateTime.Now;
        
        if (Request.QueryString["ProjectVersion"] != null && Request.QueryString["ProjectVersion"] != String.Empty)
        	issue.ProjectVersion = Request.QueryString["ProjectVersion"];
        	
        if (ProjectsState.IsEnabled && ProjectsState.ProjectSelected)
        {
        	issue.Project = ProjectsState.Project;
        }
        
        DataForm.DataSource = issue;
        
        WindowTitle = Language.ReportIssue;

        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created issue.
    /// </summary>
    private void SaveIssue()
    {
    	Issue issue = (Issue)DataForm.DataSource;
    
    	Guid issueProjectID = ProjectsState.ProjectID;
    	if (issue.Project != null)
    		issueProjectID = issue.Project.ID;
    
        DataForm.ReverseBind(issue);
    
        if (Page.IsValid)
        {
	        // Save the new issue
	        SaveStrategy.New<Issue>().Save(issue);
	
	        // Display the result to the issue
	        Result.Display(Language.IssueSaved);
	
	        IssueNotificationStrategy.New().SendNotification((Issue)DataForm.DataSource,
	        		Language.IssueNotificationSubject,
	        		Language.IssueNotificationEmail.Replace("${Application.Url}", WebUtilities.ConvertRelativeUrlToAbsoluteUrl(Request.ApplicationPath))
	        		.Replace("${Issue.Url}", new ExternalNavigator().GetExternalLink("View", issue)));
	
			// Switch to the project selected on the form if necessary
			if (ProjectsState.ProjectID != issueProjectID)
				ProjectsState.ProjectID = issueProjectID;
	
	        // Show the index again
	        if (!AuthenticationState.IsAuthenticated)
	        {        
	        	IssueSaved();
	        }
	        else
	   			Navigator.Go("View", issue);
	   	}
    }

    /// <summary>
    /// Displays the result of saving the issue.
    /// </summary>
    private void IssueSaved()
    {
        OperationManager.StartOperation("IssueSaved", CompleteView);
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new issue
        ReportIssue();
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveIssue();
        }
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
	  public override void InitializeInfo()
	  {
	  	MenuTitle = Language.ReportIssue;
	  	MenuCategory = Language.Support;
	  	ShowOnMenu = true;
	  	ActionAlias = "Create";
	  }    

</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="FormView">
			<script language="javascript">
				function setFieldValue(shortId, v)
				{
					if (shortId == "Subject")
					{
						var field = document.getElementById('<%= DataForm.FindControl("Subject").ClientID %>');

						field.value = v;
					}
					if (shortId == "Description")
					{
						var field = document.getElementById('<%= DataForm.FindControl("Description").ClientID %>');
						
						field.value = v;
					}
				}
			</script>
            <h1>
                 <%= OperationManager.CurrentOperation == "ReportIssue" ? Language.ReportIssue : Language.EditIssue %>
            </h1>
            <ss:Result ID="Result2" runat="server">
            </ss:Result>
            <p class="Intro">
            	<%= OperationManager.CurrentOperation == "ReportIssue" ? Language.ReportIssueIntro : Language.EditIssueIntro %></p>  
            	
               <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "ReportIssue" ? Language.NewIssueDetails : Language.IssueDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                   
				    <ss:EntityFormTextBoxItem runat="server" PropertyName="Subject" FieldControlID="Subject" text='<%# Language.Subject + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.IssueSubjectRequired %>'></ss:EntityFormTextBoxItem>
					<ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
			  		<ss:EntityFormTextBoxItem runat="server" PropertyName="HowToRecreate" FieldControlID="HowToRecreate" text='<%# Language.HowToRecreate + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
				    <ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterName" FieldControlID="ReporterName" text='<%# Language.Name + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
				 	<ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterEmail" FieldControlID="ReporterEmail" text='<%# Language.Email + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
					<ss:EntityFormTextBoxItem runat="server" PropertyName="ReporterPhone" FieldControlID="ReporterPhone" text='<%# Language.Phone + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
					
					<ss:EntityFormCheckBoxItem runat="server" PropertyName="NeedsReply" FieldControlID="NeedsReply" text='<%# Language.RequestReply + ":" %>' CheckBox-Text='<%# Language.YesReplyToIssue %>'></ss:EntityFormCheckBoxItem>
			
					 <ss:EntityFormItem runat="server" PropertyName="Project" FieldControlID="Project" ControlValuePropertyName="SelectedEntity" text='<%# Language.Project + ":" %>' IsRequired="true" RequiredErrorMessage='<%# Language.IssueProjectRequired %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty='Project' EntityType="Project" id="Project" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
					<ss:EntityFormTextBoxItem runat="server" PropertyName="ProjectVersion" FieldControlID="ProjectVersion" text='<%# Language.ProjectVersion + ":" %>' TextBox-Width="200"></ss:EntityFormTextBoxItem>
			        
					<ss:EntityFormButtonsItem runat="server">
						<FieldTemplate>
								<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
								            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "ReportIssue" %>'></asp:Button>
								<asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
								            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditIssue" %>'></asp:Button>&nbsp;

						</FieldTemplate>
					</ss:EntityFormButtonsItem>
                 </ss:EntityForm>
        </asp:View>
        <asp:View runat="server" ID="CompleteView">
                     <div class="Heading1"><%= Language.IssueReportComplete %></div>
                     <ss:Result runat="Server"></ss:Result>
                     <p><%= Language.ThankyouForReportingIssue %></p>
        </asp:View>
    </asp:MultiView>