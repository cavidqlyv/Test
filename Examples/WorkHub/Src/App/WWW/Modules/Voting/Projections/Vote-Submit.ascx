<%@ Control language="C#" inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules.Voting.Properties" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Modules.Voting.Business" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<script runat="server">
private void Page_Load(object sender, EventArgs e)
{
	string subjectType = Request.QueryString["SubjectType"];
	Guid subjectID = Guid.Empty;
	subjectID = GuidValidator.ParseGuid(Request.QueryString["SubjectID"]);
	
	string balanceProperty = Request.QueryString["BalanceProperty"];
	string totalProperty = Request.QueryString["TotalProperty"];
	
	bool voteFor = Convert.ToBoolean(Request.QueryString["VoteFor"]);
	
	ISimple subject = (ISimple)RetrieveStrategy.New(subjectType).Retrieve("ID", subjectID);
	
	if (EnsureAuthorised())
	{
		if (voteFor)
			Result.Display(Language.PositiveVoteRecorded);
		else
			Result.Display(Language.NegativeVoteRecorded);
			
		VoteStrategy.New().Vote(subject, balanceProperty, totalProperty, voteFor);
	
		Navigate();
	}
}

		
		public bool EnsureAuthorised()
		{
			Authorisation.EnsureIsAuthenticated();
			Authorisation.EnsureUserCan("Create", "Vote");
			
			return Authorisation.UserCan("Create", "Vote");
		}
		
		public void Navigate()
		{
				string returnUrl = Request.UrlReferrer.ToString();//(string)Context.Items["ReturnUrl"];
				HttpContext.Current.Response.Redirect(returnUrl);
		}
</script>