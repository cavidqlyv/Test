<%@ Control Language="C#" ClassName="ReportBugPart" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
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
      	MenuTitle = Language.ReportBug;
      	MenuCategory = Language.Bugs;
        ShowOnMenu = true;
    }
</script>
<p><%= Language.FoundABug %></p>
<p><a href='<%= Navigator.GetLink("Report", "Bug") %>'><%= Language.ReportBug %> &raquo;</a></p>