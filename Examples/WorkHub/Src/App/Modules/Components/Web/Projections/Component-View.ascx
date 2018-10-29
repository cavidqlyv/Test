<%@ Control Language="C#" ClassName="ViewComponent" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

	public Component CurrentComponent
	{
		get { return ((Component)Controller.DataSource); }
	}

    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Component));
    }

	private void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
			DataBind();
	}
    
    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit",  RetrieveStrategy.New("Component").Retrieve("ID", QueryStrings.GetID("Component")));
    }    
</script>
             
                                
		<asp:Panel runat="server" id="ComponentSummaryPanel" visible='<%# CurrentComponent != null %>'>
		<h1>
		<%= Language.Component %>: <%= CurrentComponent != null ? CurrentComponent.Name : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<p>
		<%= CurrentComponent != null ? CurrentComponent.Summary : String.Empty %>
		<%= (CurrentComponent != null && CurrentComponent.Summary == String.Empty) ? Language.NoSummary : String.Empty %>
		</p>
		<div id="ActionsContainer">
                                    <div id="ActionButtons">
                                    <asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditComponent %>' CssClass="Button" OnClick="EditButton_Click" />
                                    </div>
                                    </div>
               	<asp:placeholder runat="server" visible='<%# CurrentComponent.ComponentType != null %>'>
		<h2><%= Language.ComponentType %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# new ComponentType[]{CurrentComponent.ComponentType} %>' NoDataText='<%# Language.NoComponentTypeForComponent %>' id="ComponentTypeTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.ComponentType, SoftwareMonkeys.WorkHub.Modules.Components">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# CurrentComponent.SubComponents.Length > 0 %>'>
		<h2><%= Language.SubComponents %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentComponent.SubComponents %>' NoDataText='<%# Language.NoSubComponentsForComponent %>' id="SubComponentsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# CurrentComponent.ParentComponents.Length > 0 %>'>
		<h2><%= Language.ParentComponents %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentComponent.ParentComponents %>' NoDataText='<%# Language.NoParentComponentsForComponent %>' id="ParentComponentsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components">
                        </ss:EntityTree>
                   </asp:placeholder>
               	<asp:placeholder runat="server" visible='<%# CurrentComponent.RelatedComponents.Length > 0 %>'>
		<h2><%= Language.RelatedComponents %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentComponent.RelatedComponents %>' NoDataText='<%# Language.NoRelatedComponentsForComponent %>' id="RelatedComponentsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components">
                        </ss:EntityTree>
                   </asp:placeholder>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# CurrentComponent %>'  />
		</asp:Panel>