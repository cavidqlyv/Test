<%@ Control Language="C#" ClassName="PostSuggestionPart" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>

<script runat="server">
    protected void Page_Init(object sender, EventArgs e)
    {
		DefaultHeight=60;
    }
    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.PostSuggestion;
      	MenuCategory = Language.Suggestions;
        ShowOnMenu = true;
    }
</script>
<p><%= Language.GotASuggestion %></p>
<p>
	<a href='<%= Navigator.GetLink("Post", "Suggestion") %>'><%= Language.PostSuggestion %> &raquo;</a>
</p>