<%@ Control Language="C#" AutoEventWireup="true" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Navigation" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	using (TimeoutExtender extender = TimeoutExtender.NewMinutes(30))
        	{
        		using (Batch batch = BatchState.StartBatch())
        		{
		        	int total = 30;
		        	if (Request.QueryString["Total"] != null && Request.QueryString["Total"] != String.Empty)
		        		total = Convert.ToInt32(Request.QueryString["Total"]);        	
		        
		            CreateSuggestions(total);
	            }
            }
        }
    }

private void CreateSuggestions(int suggestionCount)
{
	for (int i = 0; i < suggestionCount; i++)
	{
		Suggestion suggestion = CreateSuggestion(i);
		
		SaveStrategy.New(suggestion, false).Save(suggestion);
	}
	
}

private Suggestion CreateSuggestion(int index)
{
	Suggestion suggestion = CreateStrategy.New("Suggestion", false).Create<Suggestion>();
	suggestion.Subject = "Test suggestion " + index;
	suggestion.Project = ProjectsState.Project;
	suggestion.DatePosted = DateTime.Now;
	
	return suggestion;
}
</script>
<p>Done</p>