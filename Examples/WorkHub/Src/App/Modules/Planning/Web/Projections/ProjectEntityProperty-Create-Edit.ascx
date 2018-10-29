<%@ Control Language="C#" ClassName="Default" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(ProjectEntityProperty), DataForm);
        
        
    }
    
    protected void ActionsSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Action").IndexWithReference<SoftwareMonkeys.WorkHub.Modules.Planning.Entities.Action>("Project", "Project", ProjectsState.ProjectID);
    }
    
</script>

                   <h1>
                                <%= OperationManager.CurrentOperation == "CreateProjectEntityProperty" ? Language.CreateProjectEntityProperty : Language.EditProjectEntityProperty %>
                            </h1>
                                <cc:Result ID="Result2" runat="server">
                                </cc:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateProjectEntityProperty" ? Language.CreateProjectEntityPropertyIntro : Language.EditProjectEntityPropertyIntro %></p>  
                             <cc:EntityForm runat="server" CssClass="Panel" width="100%" DataSource='<%# ((ProjectEntityProperty)DataSource).Entity %>' id="DataParentForm" HeadingText='<%# DynamicLanguage.GetEntityText("EntityDetails", "ProjectEntity") %>' HeadingCssClass="Heading2">
                            
				   		<cc:EntityFormLabelItem runat="server" PropertyName="Name" FieldControlID="Name" text='<%# Language.Name + ":" %>'></cc:EntityFormLabelItem>
					</cc:EntityForm>
                            <cc:EntityForm runat="server" CssClass="Panel" width="100%" DataSource='<%# DataSource %>' id="DataForm" HeadingText='<%# OperationManager.CurrentOperation == "CreateProjectEntityProperty" ? Language.NewProjectEntityPropertyDetails : Language.ProjectEntityPropertyDetails %>' HeadingCssClass="Heading2">
                            
				   <cc:EntityFormTextBoxItem runat="server" PropertyName="Name" FieldControlID="PropertyName" text='<%# Language.Name + ":" %>' TextBox-Width="400" IsRequired="true" RequiredErrorMessage='<%# Language.ProjectEntityPropertyNameRequired %>'></cc:EntityFormTextBoxItem>
			
				   <cc:EntityFormItem runat="server" PropertyName="Type" FieldControlID="PropertyType" text='<%# Language.Type + ":" %>' ControlValuePropertyName="SelectedType"><FieldTemplate><cc:ProjectEntityPropertyTypeSelect width="200" runat="server" id="PropertyType"></cc:ProjectEntityPropertyTypeSelect></FieldTemplate></cc:EntityFormItem>
				   <cc:EntityFormTextBoxItem runat="server" PropertyName="OtherType" FieldControlID="OtherPropertyType" text='<%# Language.OtherType + ":" %>' TextBox-Width="200"></cc:EntityFormTextBoxItem>
			 <cc:EntityFormTextBoxItem runat="server" PropertyName="Description" FieldControlID="Description" text='<%# Language.Description + ":" %>' TextBox-Width="400" TextBox-TextMode="Multiline" TextBox-Rows="6"></cc:EntityFormTextBoxItem>
			
				<cc:EntityFormButtonsItem runat="server">
<FieldTemplate>
<asp:Button ID="Button1" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
            CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateProjectEntityProperty" %>'></asp:Button>
<asp:Button ID="Button2" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
            CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditProjectEntityProperty" %>'></asp:Button>
</asp:Button>
</FieldTemplate>
</cc:EntityFormButtonsItem>
			
                            </cc:EntityForm>
                       