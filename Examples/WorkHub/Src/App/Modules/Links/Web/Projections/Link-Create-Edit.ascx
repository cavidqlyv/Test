<%@ Control Language="C#" ClassName="LinkForm" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseCreateEditProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Link), DataForm, "Title");
    }


    protected void ProjectSelect_DataLoading(object sender, EventArgs e)
    {
        ((EntitySelect)sender).DataSource = IndexStrategy.New("Project").Index();
    }
    
</script>
                   <div class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateLink" ? Language.CreateLink : Language.EditLink %>
                            </div>
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <p class="Intro">
                                    <%= OperationManager.CurrentOperation == "CreateLink" ? Language.CreateLinkIntro : Language.EditLinkIntro %></p>  
                            <ss:EntityForm runat="server" CssClass="Panel" width="100%" id="DataForm" DataSource='<%# DataSource %>' HeadingText='<%# OperationManager.CurrentOperation == "CreateLink" ? Language.NewLinkDetails : Language.LinkDetails %>' HeadingCssClass="Heading2">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Title" text='<%# Language.Title + ":" %>' IsRequired="true" TextBox-Width="400" RequiredErrorMessage='<%# Language.LinkTitleRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Url" text='<%# Language.Url + ":"  %>' TextBox-width="400" IsRequired="true" RequiredErrorMessage='<%# Language.LinkUrlRequired %>'></ss:EntityFormTextBoxItem>
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Summary" text='<%# Language.Summary + ":"  %>' TextBox-TextMode="Multiline" TextBox-Rows="5" TextBox-width="400"></ss:EntityFormTextBoxItem>
                            <ss:EntityFormItem runat="server" PropertyName="Projects" FieldControlID="Projects" ControlValuePropertyName="SelectedEntities" text='<%# Language.Projects + ":" %>' RequiredErrorMessage='<%# Language.LinkProjectRequired %>'><FieldTemplate>
                            	<ss:EntitySelect runat="server" width="400px" ReferenceSource='<%# DataForm.DataSource %>' ReferenceProperty="Projects" EntityType="SoftwareMonkeys.WorkHub.Entities.IProject, SoftwareMonkeys.WorkHub.Contracts" DisplayMode="multiple" SelectionMode="multiple" rows="5" id="Projects" NoSelectionText='<%# "-- " + Language.SelectProject + " --" %>' onDataLoading="ProjectSelect_DataLoading"></ss:EntitySelect></FieldTemplate></ss:EntityFormItem>
                             <ss:EntityFormButtonsItem runat="server"><FieldTemplate><asp:Button ID="SaveButton" runat="server" Text='<%# Language.Save %>' CssClass="FormButton"
                                                CommandName="Save" Visible='<%# OperationManager.CurrentOperation == "CreateLink" %>'></asp:Button><asp:Button ID="UpdateButton" runat="server" Text='<%# Language.Update %>' CssClass="FormButton"
                                                CommandName="Update" Visible='<%# OperationManager.CurrentOperation == "EditLink" %>'></asp:Button></FieldTemplate></ss:EntityFormButtonsItem>
                            </ss:EntityForm>
               