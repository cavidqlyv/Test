<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CreateSuggestion();
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
    }

    #region Main functions
   
    /// <summary>
    /// Displays the form for creating a new suggestion.
    /// </summary>
    public void CreateSuggestion()
    {
        //Authorisation.EnsureUserCan("Create", typeof(Suggestion));

        Guid projectID = Guid.Empty;
        
        // Parse the project ID
        try
        {
            projectID = new Guid(Request.QueryString["ProjectID"]);
        	ProjectsState.ProjectID = projectID;
        }
        catch { }
        
        if (projectID == Guid.Empty && ProjectsState.IsEnabled && ProjectsState.ProjectID != Guid.Empty)
        	projectID = ProjectsState.ProjectID;

        IProject project = ProjectsState.Project;

        OperationManager.StartOperation("CreateSuggestion", FormView);
        
        ProjectsState.ProjectID = projectID;

        Suggestion suggestion = new Suggestion();
        suggestion.ID = Guid.NewGuid();
        suggestion.DatePosted = DateTime.Now;
    	if (ProjectsState.IsEnabled && projectID != Guid.Empty)
            suggestion.Project = project;
        DataForm.DataSource = suggestion;

        WindowTitle = Language.PostSuggestion;
        		
        FormView.DataBind();
    }

    /// <summary>
    /// Saves the newly created suggestion.
    /// </summary>
    private void SaveSuggestion()
    {
    	Suggestion suggestion = (Suggestion)DataForm.DataSource;
    
        DataForm.ReverseBind(suggestion);
      
        if (Page.IsValid)
       	{
	        // Save the new suggestion
	        SaveStrategy.New<Suggestion>().Save(suggestion);
	
	        // Display the result to the suggestion
	        Result.Display(Language.SuggestionSaved);
	
            // TODO: Move this to a controller or a strategy
        	SuggestionNotificationStrategy.New()
        		.SendNotification((Suggestion)DataForm.DataSource,
	        		Language.SuggestionNotificationSubject,
	        		Language.SuggestionNotificationEmail.Replace("${Application.Url}",
	        										WebUtilities.ConvertRelativeUrlToAbsoluteUrl(Request.ApplicationPath))
	        									.Replace("${Suggestion.Url}",
	        										new ExternalNavigator().GetExternalLink("View", suggestion)));
	        										
	        if (AuthenticationState.IsAuthenticated)
	        	Navigator.Go("Index", "Suggestion");
	        else
	        	SuggestionSaved();
        }
    }

    /// <summary>
    /// Displays the result of saving the suggestion.
    /// </summary>
    private void SuggestionSaved()
    {
        OperationManager.StartOperation("SuggestionSaved", CompleteView);
    }
    #endregion

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Create a new suggestion
        CreateSuggestion();
    }

    protected void DataForm_EntityCommand(object sender, EntityFormEventArgs e)
    {
        if (e.CommandName == "Save")
        {
            SaveSuggestion();
        }
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
</script>
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="FormView">
                   <div class="Heading1">
                                <%= Language.CreateSuggestion %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= Language.CreateSuggestionIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateSuggestion" ? Language.NewSuggestionDetails : Language.SuggestionDetails %>' HeadingCssClass="Heading2" OnEntityCommand="DataForm_EntityCommand">
                            
				   <ss:EntityFormTextBoxItem runat="server" PropertyName="Subject" FieldControlID="Subject" text='<%# Language.Subject + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.SuggestionSubjectRequired %>'></ss:EntityFormTextBoxItem>
								<ss:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></ss:EntityFormTextBoxItem>
								<ss:EntityFormTextBoxItem runat="server" PropertyName="AuthorName" FieldControlID="AuthorName" text='<%# Language.AuthorName + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
								<ss:EntityFormTextBoxItem runat="server" PropertyName="AuthorEmail" FieldControlID="AuthorEmail" text='<%# Language.AuthorEmail + ":" %>' TextBox-Width="400"></ss:EntityFormTextBoxItem>
			
								<ss:EntityFormCheckBoxItem runat="server" PropertyName="NeedsReply" FieldControlID="NeedsReply" text='<%# Language.RequestReply + ":" %>' CheckBox-Text='<%# Language.YesReplyToSuggestion %>'></ss:EntityFormCheckBoxItem>
			
								<ss:EntityFormItem runat="server" PropertyName="Project" FieldControlID="Project"  text='<%# Language.Project + ":" %>' isRequired="true" ControlValuePropertyName="SelectedEntity" RequiredErrorMessage='<%# Language.SuggestionProjectRequired %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" id="Project" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Project"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
								<ss:EntityFormButtonsItem runat="server">
								<FieldTemplate>
								<asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
								            CommandName="Save"></asp:Button>
								</FieldTemplate>
								</ss:EntityFormButtonsItem>
                   </ss:EntityForm>
                            
        </asp:View>
        <asp:View runat="server" ID="CompleteView">
                     <div class="Heading1"><%= Language.SuggestionSubmitted %></div>
                     <ss:Result runat="Server"></ss:Result>
                     <p><%= Language.ThankyouForSuggestion %></p>
        </asp:View>
    </asp:MultiView>