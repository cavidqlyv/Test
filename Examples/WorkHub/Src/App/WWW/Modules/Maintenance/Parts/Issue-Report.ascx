<%@ Control Language="C#" ClassName="ReportIssuePart" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Maintenance.Properties" %>
<script runat="server">
    protected void Page_Init(object sender, EventArgs e)
    {
		DefaultHeight=60;
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.ReportIssue;
      	MenuCategory = Language.Issues;
        ShowOnMenu = true;
    }
</script>
<p><%= Language.HavingAnIssue %></p>
<p><a href='<%= Navigator.GetLink("Report", "Issue") %>'><%= Language.ReportIssue %> &raquo;</a></p>