<%@ Control Language="C#" ClassName="ViewComponentType" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
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

	public ComponentType CurrentComponentType
	{
		get { return ((ComponentType)Controller.DataSource); }
	}

    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(ComponentType));
    }

	private void Page_Load(object sender, EventArgs e)
	{
		if (!IsPostBack)
			DataBind();
	}
    
    private void EditButton_Click(object sender, EventArgs e)
    {
    	Navigator.Go("Edit",  RetrieveStrategy.New("ComponentType").Retrieve("ID", QueryStrings.GetID("ComponentType")));
    }    
</script>
             
                                
		<asp:Panel runat="server" id="ComponentTypeSummaryPanel" visible='<%# CurrentComponentType != null %>'>
		<h1>
		<%= Language.ComponentType %>: <%= CurrentComponentType != null ? CurrentComponentType.Name : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<p>
		<%= CurrentComponentType != null ? CurrentComponentType.Description : String.Empty %>
		<%= (CurrentComponentType != null && CurrentComponentType.Description == String.Empty) ? Language.NoDescription : String.Empty %>
		</p>
		<div id="ActionsContainer">
                                    <div id="ActionButtons">
                                    <asp:Button runat="Server" ID="EditButton" Text='<%# Language.EditComponentType %>' CssClass="WideButton" OnClick="EditButton_Click" />
                                    </div>
                                    </div>
                                    
               	<asp:placeholder runat="server" visible='<%# CurrentComponentType.Components.Length > 0 %>'>
					<h2><%= Language.Components %></h2>
				         <ss:EntityTree runat="server" DataSource='<%# CurrentComponentType.Components %>' NoDataText='<%# Language.NoComponentsForComponentType %>' id="ComponentsTree" EntityType="SoftwareMonkeys.WorkHub.Modules.Components.Entities.Component, SoftwareMonkeys.WorkHub.Modules.Components">
                        </ss:EntityTree>
                 </asp:placeholder>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# CurrentComponentType %>'  />
		</asp:Panel>