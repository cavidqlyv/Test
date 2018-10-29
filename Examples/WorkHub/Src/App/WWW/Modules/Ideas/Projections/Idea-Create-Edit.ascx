<%@ Control Language="C#" ClassName="IdeaForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Validation" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
	public Idea CurrentIdea
	{
		get {
			if (DataSource == null)
				DataSource = RetrieveStrategy.New<Idea>().Retrieve(QueryStrings.GetID("Idea"));
			return (Idea)DataSource;
			}
	}

    private void Page_Init(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Initializing the create/edit idea projection.", NLog.LogLevel.Debug))
    	{
        	Initialize(typeof(Idea), DataForm, "Title");
        	
        	ValidationFacade validation = new ValidationFacade();
        	validation.AddError("Details", "Required", Language.IdeaDetailsRequired);
        	
        	if (CreateController != null)
        		CreateController.Validation = validation;
        	else
        		EditController.Validation = validation;
        }
    }


    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the projects data for the project select control.", NLog.LogLevel.Debug))
    	{
        	((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
        }
    }
    
    protected void IdeaSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the ideas data for the idea select control.", NLog.LogLevel.Debug))
    	{
	    	if (CurrentIdea != null)
	    	{
	    		//if (ProjectsState.ProjectSelected)
	    		//{
		    	//	LogWriter.Debug("CurrentIdea != null. Loading.");
		    	
		        //	((EntitySelect)sender).DataSource = IndexStrategy.New<Idea>().IndexWithReference<Idea>("Projects", Collection<IEntity>.ConvertAll(CurrentIdea.Projects));
	        	//}
	        	//else
	        	//{
	        		((EntitySelect)sender).DataSource = IndexStrategy.New<Idea>().Index<Idea>();
	        	//}
	        }
	        //else
	    	//	throw new Exception("CurrentIdea == null. Can't load references.");
       	}
    }
    
  public override void InitializeInfo()
  {
  	MenuTitle = Language.CreateIdea;
  	MenuCategory = Language.Brainstorm;
  }
</script>
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateIdea" ? Language.CreateIdea : Language.EditIdea %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateIdea" ? Language.CreateIdeaIntro : Language.EditIdeaIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateIdea" ? Language.NewIdeaDetails : Language.IdeaDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Details" text='<%# Language.Details + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400" isRequired="true" RequiredErrorMessage='<%# Language.IdeaDetailsRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormCheckBoxItem runat="server" PropertyName="IsPublic" text='<%# Language.IsPublic + ":"  %>' />
                            <ss:EntityFormItem runat="server" PropertyName="SubIdeas" FieldControlID="SubIdeas" ControlValuePropertyName="SelectedEntities" text='<%# Language.SubIdeas + ":" %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Details" ValPropertyName="Details" id="SubIdeas" NoSelectionText='<%# "-- " + Language.SelectIdea + " --" %>' onDataLoading="IdeaSelect_DataLoading" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="SubIdeas"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="ParentIdeas" FieldControlID="ParentIdeas" ControlValuePropertyName="SelectedEntities" text='<%# Language.ParentIdeas + ":" %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Details" id="ParentIdeas" NoSelectionText='<%# "-- " + Language.SelectIdea + " --" %>' onDataLoading="IdeaSelect_DataLoading" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="ParentIdeas"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                   			<ss:EntityFormItem runat="server" PropertyName="RelatedIdeas" FieldControlID="RelatedIdeas" ControlValuePropertyName="SelectedEntities" text='<%# Language.RelatedIdeas + ":" %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities.Idea, SoftwareMonkeys.WorkHub.Modules.Ideas" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Details" id="RelatedIdeas" NoSelectionText='<%# "-- " + Language.SelectIdea + " --" %>' onDataLoading="IdeaSelect_DataLoading" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="RelatedIdeas"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="Projects" FieldControlID="Projects" ControlValuePropertyName="SelectedEntities" text='<%# Language.Projects + ":" %>' RequiredErrorMessage='<%# Language.IdeaProjectRequired %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" DisplayMode="multiple" SelectionMode="multiple" rows="5" id="Projects" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Projects"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateIdea" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditIdea" %>'></asp:Button>&nbsp;
                                                <cc:CommandSelect runat="server" id="NextCommand" Commands="Create Idea|View Idea|Idea Index"/>
                                                </FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               