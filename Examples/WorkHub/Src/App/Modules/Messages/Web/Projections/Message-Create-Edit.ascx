<%@ Control Language="C#" ClassName="MessageForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Messages.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
	public Message CurrentMessage
	{
		get {
			if (DataSource == null)
				DataSource = RetrieveStrategy.New<Message>().Retrieve(QueryStrings.GetID("Message"));
			return (Message)DataSource;
			}
	}

    private void Page_Init(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Initializing the create/edit  projection.", NLog.LogLevel.Debug))
    	{
        	Initialize(typeof(Message), DataForm);
        }
    }

    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the projects data for the project select control.", NLog.LogLevel.Debug))
    	{
        	((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
        }
    }
    
    protected void MessageSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the message data for the  select control.", NLog.LogLevel.Debug))
    	{
	    	if (CurrentMessage != null)
	    	{
	    		LogWriter.Debug("CurrentMessage != null. Loading.");
	    	
	        	((EntitySelect)sender).DataSource = IndexStrategy.New<Message>().IndexWithReference<Message>("Projects", Collection<IEntity>.ConvertAll(CurrentMessage.Projects));
	        }
	        //else
	    	//	throw new Exception("CurrentMessage == null. Can't load references.");
       	}
    }
    
    
    protected void RecipientSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the user data for the  select control.", NLog.LogLevel.Debug))
    	{
	        	((EntitySelect)sender).DataSource = IndexStrategy.New<User>().Index<User>();

       	}
    }
    
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Create;
  	MenuCategory = Language.Messages;
  	ActionAlias = "Send";
  }
  
  private bool RecipientsVisible
  {
	get
	{
	  	if (Request.QueryString["IsDiscussion"] == true.ToString())
  			return false;
	  	else
  			return ((Message)DataSource).Subject == null && ((Message)DataSource).Parent == null;
	}
  }
  
  private bool IsPublicEnabled
  {
  	get { return !IsDiscussion && !ParentIsPublic; }
  }
  
  private bool ParentIsPublic
  {
  	get { return (CurrentMessage.Parent != null && CurrentMessage.Parent.IsPublic); }
  }
  
  protected bool IsDiscussion
  {
  	get { return Request.QueryString["IsDiscussion"] == true.ToString(); }
  }
</script>
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateMessage" ? Language.CreateMessage : Language.EditMessage %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateMessage" ? Language.CreateMessageIntro : Language.EditMessageIntro %></p>  
                                    <cc:ElementControl runat="server" DataSource='<%# ((Message)DataSource).Subject %>' id="SubjectDisplay" Action="View" TypeName='<%# Request.QueryString["SubjectType"] != null && Request.QueryString["SubjectType"] != String.Empty ? Request.QueryString["SubjectType"] : CurrentMessage.SubjectTypeName %>' PropertyValuesString='<%# "HeadingText=" + Language.Subject + "&Width=100%" %>' visible='<%# ((Message)DataSource).Subject != null %>' width="100%" />
                           <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="ParentForm" DataSource='<%# ((Message)DataSource).Parent %>' HeadingText='<%# Language.Previous %>' HeadingCssClass="Heading2" Visible='<%# ((Message)DataSource).Parent != null %>'>
                            <ss:EntityFormLabelItem runat="server" PropertyName="Title" text='<%# Language.Title + ":" %>' FieldControlID="SubjectTitle" />
                            <ss:EntityFormLabelItem runat="server" PropertyName="Body" text='<%# Language.Body + ":"  %>' FieldControlID="SubjectBody" />
							</ss:EntityForm>                            
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateMessage" ? Language.NewMessageDetails : Language.MessageDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" text='<%# Language.Title + ":" %>' IsRequired="true" TextBox-Width="400" RequiredErrorMessage='<%# Language.MessageTitleRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Body" text='<%# Language.Body + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="15" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormCheckBoxItem runat="server" PropertyName="IsPublic" enabled='<%# IsPublicEnabled %>' text='<%# Language.IsPublic + ":"  %>' CheckBox-Text='<%# Language.IsPublicNote %>'/>
                            <ss:EntityFormItem runat="server" visible='<%# RecipientsVisible %>' PropertyName="Recipients" FieldControlID="Recipients" ControlValuePropertyName="SelectedEntities" text='<%# Language.Recipients + ":" %>'><FieldTemplate><ss:EntitySelect
                            	ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Recipients"
                            	runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.User, SoftwareMonkeys.WorkHub.Entities" DisplayMode="multiple" SelectionMode="multiple" id="Recipients" NoSelectionText='<%# "-- " + Language.SelectRecipients + " --" %>' onDataLoading="RecipientSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" visible='<%# ((Message)DataSource).Subject == null && ((Message)DataSource).Parent == null && ((IEntity[])((EntitySelect)FindControl("Projects")).DataSource).Length > 0 %>' PropertyName="Projects" FieldControlID="Projects" ControlValuePropertyName="SelectedEntities" text='<%# Language.Projects + ":" %>' RequiredErrorMessage='<%# Language.MessageProjectRequired %>'><FieldTemplate><ss:EntitySelect
                            	ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Projects"
                           	 	runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" DisplayMode="multiple" SelectionMode="multiple" id="Projects" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# ((Message)DataSource).Subject != null ? Language.Post : Language.Send %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateMessage" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditMessage" %>'></asp:Button></FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               