<%@ Control Language="C#" ClassName="ViewLink" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseViewProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
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

	public Link CurrentLink
	{
		get { return ((Link)Controller.DataSource); }
	}

    private void Page_Init(object sender, EventArgs e)
    {
        Initialize(typeof(Link));
    }

	private void Page_Load(object sender, EventArgs e)
	{
		DataBind();
	}
    
</script>
             
                                
		<asp:Panel runat="server" id="LinkSummaryPanel" visible='<%# CurrentLink != null %>'>
		<h1>
		<%= Language.Link %>: <%= CurrentLink != null ? CurrentLink.Title : String.Empty %>
		</h1>
		<cc:Result runat="server"/>
		<p>
		<%= CurrentLink != null ? CurrentLink.Summary : String.Empty %>
		<%= (CurrentLink != null && CurrentLink.Summary == String.Empty) ? Language.NoSummary : String.Empty %>
		</p>
		<div id="ActionsContainer">
		<div id="ActionButtons">
		<input type="Button" class="ActionButton" onclick='<%= "location.href=\"" + Navigator.GetLink("Edit", CurrentLink) + "\"" %>' value='<%= Language.EditLink %>'/>
		</div>
		</div>
		<p>
		<%= Language.Url %>: <a href='<%= CurrentLink != null && CurrentLink.Url != null ? CurrentLink.Url : String.Empty %>' target="_blank">
		<%= CurrentLink != null && CurrentLink.Url != null ? CurrentLink.Url : String.Empty %>
		</a>
		</p>
				<cc:ElementControl ElementName="Messages" runat="Server" DataSource='<%# CurrentLink %>'  />
		</asp:Panel>