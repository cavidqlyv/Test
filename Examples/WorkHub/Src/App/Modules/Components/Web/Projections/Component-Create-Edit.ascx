<%@ Control Language="C#" ClassName="ComponentForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
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
	public Component CurrentComponent
	{
		get {
			if (DataSource == null)
				DataSource = RetrieveStrategy.New<Component>().Retrieve(QueryStrings.GetID("Component"));
			return (Component)DataSource;
			}
	}

    private void Page_Init(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.Start("Initializing the create/edit component projection.", NLog.LogLevel.Debug))
    	{
        	Initialize(typeof(Component), DataForm, "Title");
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
    
    protected void ComponentTypeSelect_DataLoading(object sender, EventArgs e)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Loading the component type data for the component type select control."))
    	{
		    	((EntitySelect)sender).DataSource = IndexStrategy.New<ComponentType>().Index<ComponentType>();	
		}
    }
</script>
                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateComponent" ? Language.CreateComponent : Language.EditComponent %>
                            </h1>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateComponent" ? Language.CreateComponentIntro : Language.EditComponentIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateComponent" ? Language.NewComponentDetails : Language.ComponentDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" text='<%# Language.Name + ":" %>' IsRequired="true" TextBox-Width="400" RequiredErrorMessage='<%# Language.ComponentNameRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Summary" text='<%# Language.Summary + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormCheckBoxItem runat="server" PropertyName="IsPublic" text='<%# Language.IsPublic + ":"  %>' />
                            <ss:EntityFormItem runat="server" PropertyName="ComponentType"
                            visible='<%# ((IEntity[])((EntitySelect)FindControl("ComponentType")).DataSource).Length > 0 %>'
                            FieldControlID="ComponentType" ControlValuePropertyName="SelectedEntity" text='<%# Language.ComponentType + ":" %>'><FieldTemplate><ss:EntitySelect
                             ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="ComponentType"
                            runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.ComponentType, SoftwareMonkeys.WorkHub.Modules.Components" DisplayMode="Single" SelectionMode="Single" TextPropertyName="Name" id="ComponentType" NoSelectionText='<%# "-- " + Language.SelectComponentType + " --" %>' onDataLoading="ComponentTypeSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="SubComponents"
                            visible='<%# ((IEntity[])((EntitySelect)FindControl("SubComponents")).DataSource).Length > 0 %>'
                            FieldControlID="SubComponents" ControlValuePropertyName="SelectedEntities" text='<%# Language.SubComponents + ":" %>'><FieldTemplate><ss:EntitySelect
                             ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="SubComponents"
                            runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Name" id="SubComponents" NoSelectionText='<%# "-- " + Language.SelectComponent + " --" %>' onDataLoading="ComponentSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="ParentComponents"
                            visible='<%# ((IEntity[])((EntitySelect)FindControl("ParentComponents")).DataSource).Length > 0 %>'
                            ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="ParentComponents" FieldControlID="ParentComponents" ControlValuePropertyName="SelectedEntities" text='<%# Language.ParentComponents + ":" %>'><FieldTemplate><ss:EntitySelect
                             ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="ParentComponents"
                            runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Name" id="ParentComponents" NoSelectionText='<%# "-- " + Language.SelectComponent + " --" %>' onDataLoading="ComponentSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                   			<ss:EntityFormItem runat="server" PropertyName="RelatedComponents"
                   			visible='<%# ((IEntity[])((EntitySelect)FindControl("RelatedComponents")).DataSource).Length > 0 %>'
                   			ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="RelatedComponents" FieldControlID="RelatedComponents" ControlValuePropertyName="SelectedEntities" text='<%# Language.RelatedComponents + ":" %>'><FieldTemplate><ss:EntitySelect
                   			 ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="RelatedComponents"
                   			runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components" DisplayMode="multiple" SelectionMode="multiple" rows="5" TextPropertyName="Name" id="RelatedComponents" NoSelectionText='<%# "-- " + Language.SelectComponent + " --" %>' onDataLoading="ComponentSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                            <ss:EntityFormItem runat="server" PropertyName="Projects" FieldControlID="Projects" ControlValuePropertyName="SelectedEntities" text='<%# Language.Projects + ":" %>' RequiredErrorMessage='<%# Language.ComponentProjectRequired %>'><FieldTemplate><ss:EntitySelect
                            	ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Projects"
                            runat="server" width="400px" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" DisplayMode="multiple" SelectionMode="multiple" rows="5" id="Projects" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateComponent" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditComponent" %>'></asp:Button></FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               