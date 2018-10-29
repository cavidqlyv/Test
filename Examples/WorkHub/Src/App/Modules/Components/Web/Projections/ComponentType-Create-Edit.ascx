<%@ Control Language="C#" ClassName="ComponentTypeForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
	public ComponentType CurrentComponentType
	{
		get {
			if (DataSource == null)
				DataSource = RetrieveStrategy.New<ComponentType>().Retrieve(QueryStrings.GetID("ComponentType"));
			return (ComponentType)DataSource;
			}
	}

    private void Page_Init(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Initializing the create/edit component projection.", NLog.LogLevel.Debug))
    	{
        	Initialize(typeof(ComponentType), DataForm, "Name");
        	
        }
    }


    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the projects data for the project select control.", NLog.LogLevel.Debug))
    	{
        	((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
        }
    }
    
    protected void ComponentSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Loading the components data for the component select control.", NLog.LogLevel.Debug))
    	{
		    	((EntitySelect)sender).DataSource = IndexStrategy.New<Component>().Index<Component>();	
	    
       	}
    }
</script>
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateComponentType" ? Language.CreateComponentType : Language.EditComponentType %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateComponentType" ? Language.CreateComponentTypeIntro : Language.EditComponentTypeIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateComponentType" ? Language.NewComponentTypeDetails : Language.ComponentTypeDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" text='<%# Language.Name + ":" %>' IsRequired="true" TextBox-Width="400" RequiredErrorMessage='<%# Language.ComponentTypeNameRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Description" text='<%# Language.Description + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormCheckBoxItem runat="server" PropertyName="IsPublic" text='<%# Language.IsPublic + ":"  %>' />
                            <ss:EntityFormItem runat="server" PropertyName="Components"
                             visible='<%# ((IEntity[])((EntitySelect)FindControl("Components")).DataSource).Length > 0 %>'
                            FieldControlID="Components" ControlValuePropertyName="SelectedEntities" text='<%# Language.Components + ":" %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px"
                             ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Components"
                            EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components" DisplayMode="multiple" SelectionMode="multiple" rows="5" id="Components" onDataLoading="ComponentSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="Projects" FieldControlID="Projects" ControlValuePropertyName="SelectedEntities" text='<%# Language.Projects + ":" %>' RequiredErrorMessage='<%# Language.ComponentTypeProjectRequired %>'><FieldTemplate><ss:EntitySelect runat="server" width="400px"
                             ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Projects"
                            EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" DisplayMode="multiple" SelectionMode="multiple" rows="5" id="Projects" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateComponentType" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditComponentType" %>'></asp:Button></FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               