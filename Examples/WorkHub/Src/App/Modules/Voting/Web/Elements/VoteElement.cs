using System.Reflection;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI;
using System;
using SoftwareMonkeys.WorkHub.Business;
using SoftwareMonkeys.WorkHub.Business.Security;
using SoftwareMonkeys.WorkHub.Diagnostics;
using SoftwareMonkeys.WorkHub.Entities;
using SoftwareMonkeys.WorkHub.Modules.Voting.Business.Security;
using SoftwareMonkeys.WorkHub.Modules.Voting.Properties;
using SoftwareMonkeys.WorkHub.Modules.Voting.Business;
using SoftwareMonkeys.WorkHub.Web;
using SoftwareMonkeys.WorkHub.Web.Elements;
using SoftwareMonkeys.WorkHub.Web.Navigation;
using SoftwareMonkeys.WorkHub.Web.Security;
using SoftwareMonkeys.WorkHub.Web.WebControls;

namespace SoftwareMonkeys.WorkHub.Modules.Voting.Web.Controls
{
	/// <summary>
	/// 
	/// </summary>
	[Element("Vote")]
	public class VoteElement : BaseElement
	{
		public Label TextLabel;
		
		private string text = String.Empty;
		public string Text
		{
			get {
				if (text == String.Empty)
					text = Language.Vote;
				return text; }
			set { text = value;
				if (TextLabel != null)
					TextLabel.Text = text;
			}
		}
		
		private IEntity dataSource;
		public IEntity DataSource
		{
			get {
				if (dataSource == null && SubjectID != Guid.Empty && SubjectType != String.Empty)
					dataSource = RetrieveStrategy.New(SubjectType).Retrieve("ID", SubjectID);
				return (IEntity)dataSource; }
			set
			{
				dataSource = value;
				SubjectID = value.ID;
				SubjectType = value.ShortTypeName;
			}
		}
		
		/// <summary>
		/// Gets/sets the ID of the subject entity.
		/// </summary>
		public Guid SubjectID
		{
			get {
				if (ViewState["SubjectID"] == null)
					ViewState["SubjectID"] = Guid.Empty;
				return (Guid)ViewState["SubjectID"];
			}
			set { ViewState["SubjectID"] = value; }
		}
		
		/// <summary>
		/// Gets/sets the short type name of the subject entity.
		/// </summary>
		public string SubjectType
		{
			get {
				if (ViewState["SubjectType"] == null)
					ViewState["SubjectType"] = String.Empty;
				
				// If the full type was provided then shorten it
				if (((string)ViewState["SubjectType"]).IndexOf('.') > -1)
					ViewState["SubjectType"] = EntityState.GetInfo((string)ViewState["SubjectType"]).TypeName;
				
				return (string)ViewState["SubjectType"];
			}
			set {
				ViewState["SubjectType"] = value;
			}
		}
		
		public string BalanceProperty
		{
			get {
				if (ViewState["BalanceProperty"] == null)
					ViewState["BalanceProperty"] = String.Empty;
				
				return (string)ViewState["BalanceProperty"]; }
			set { ViewState["BalanceProperty"] = value; }
		}
		
		public string TotalProperty
		{
			get {
				if (ViewState["TotalProperty"] == null)
					ViewState["TotalProperty"] = String.Empty;
				
				return (string)ViewState["TotalProperty"]; }
			set { ViewState["TotalProperty"] = value; }
		}
		
		public int Balance
		{
			get {
				return GetBalanceFromProperty();
			}
		}
		
		public int Total
		{
			get {
				return GetTotalFromProperty();
			}
		}
		
		HyperLink NegativeLink;
		HyperLink PositiveLink;
		Label BalanceLabel;
		Label TotalLabel;
		
		private bool autoNavigate = true;
		public bool AutoNavigate
		{
			get { return autoNavigate; }
			set { autoNavigate = value; }
		}
		
		private string navigateUrl = String.Empty;
		/// <summary>
		/// Gets/sets the URL that the user will be redirected to after voting (if AutoNavigate is true). Defaults to the current friendly URL.
		/// </summary>
		public string NavigateUrl
		{
			get {
				if (navigateUrl == String.Empty)
				{
					if (HttpContext.Current.Items.Contains("OriginalUrl"))
						navigateUrl = (string)HttpContext.Current.Items["OriginalUrl"];
					else
						navigateUrl = HttpContext.Current.Request.Url.ToString();
				}
				return navigateUrl; }
			set { navigateUrl = value; }
		}
		
		protected IEntity Subject
		{
			get {
				return DataSource;
			}
		}
		
		public VoteElement()
		{
		}
		
		protected override void OnInit(EventArgs e)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Initializing VoteElement '" + ID + "'."))
			{
				EnsureChildControls();
				
				base.OnInit(e);
			}
		}
		
		public override void DataBind()
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Data binding VoteElement '" + ID + "'."))
			{
				EnsureChildControls();
				
				base.DataBind();
				
				LoadTitle();
				LoadLinks();
				
				IsDataBound = true;
			}
		}
		
		protected override void OnLoad(EventArgs e)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Loading VoteElement '" + ID + "'."))
			{
				EnsureDataBound();
				
				base.OnLoad(e);
			}
		}
		
		protected override void OnPreRender(EventArgs e)
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Pre rendering VoteElement '" + ID + "'."))
			{
				EnsureDataBound();
				
				if (CssClass == String.Empty)
					CssClass = "Vote";
				
				// Set the current value label
				BalanceLabel.Text = GetBalance();
				TotalLabel.Text = GetTotal();
				
				if (AuthenticationState.IsAuthenticated)
				{
					// Enable/disable links if necessary
					NegativeLink.Enabled = AuthoriseSaveVoteStrategy.New().IsAuthorised(Subject, false);
					
					// If the user has already voted then mark the link with a css class
					if (CheckVoteStrategy.New().UserHasVoted(Subject, BalanceProperty, TotalProperty, false))
					{
						NegativeLink.CssClass = "VotedAgainst";
					}
					else
						NegativeLink.CssClass = "";
					
					PositiveLink.Enabled = AuthoriseSaveVoteStrategy.New().IsAuthorised(Subject, true);
					
					// If the user has already voted then mark the link with a css class
					if (CheckVoteStrategy.New().UserHasVoted(Subject, BalanceProperty, TotalProperty, true))
					{
						PositiveLink.CssClass = "VotedFor";
					}
					else
						PositiveLink.CssClass = "";
				}
				
				base.OnPreRender(e);
			}
		}
		
		protected override void CreateChildControls()
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Creating child controls for VoteElement '" + ID + "'."))
			{
				InitializeLabel();
				
				InitializePositiveButton();
				
				InitializeValue();
				
				InitializeNegativeButton();
			}
			
			base.CreateChildControls();
		}
		
		protected virtual void LoadTitle()
		{
			//Attributes["Title"] = Language.VoteTitlePopup.Replace("${TotalVotes}", Total.ToString());
		}
		
		protected virtual void InitializeLabel()
		{
			TextLabel = new Label();
			TextLabel.Text = Text;
			
			Controls.Add(TextLabel);
			Controls.Add(new LiteralControl(": "));
		}
		
		protected virtual void InitializeNegativeButton()
		{
			NegativeLink = new HyperLink();
			NegativeLink.Text = @"[-]";
			
			Controls.Add(NegativeLink);
		}
		
		private string CreateCustomPostbackQueryStrings(bool isFor)
		{
			return "VoteFor=" + isFor.ToString() + "&SubjectID=" + SubjectID.ToString() + "&SubjectType=" + SubjectType + "&TotalProperty=" + TotalProperty + "&BalanceProperty=" + BalanceProperty;
		}
		
		private string CreateCustomPostbackUrl(bool isFor)
		{
			
			string url = new UrlCreator().CreateUrl("Submit", "Vote");
			
			string separator = "?";
			if (url.IndexOf("?") > -1)
				separator = "&";
			
			url = url + separator;
			
			url = url + CreateCustomPostbackQueryStrings(isFor);
			
			return url;
		}
		
		protected virtual void InitializeValue()
		{
			BalanceLabel = new Label();
			TotalLabel = new Label();
			
			Controls.Add(new LiteralControl(" "));
			Controls.Add(BalanceLabel);
			Controls.Add(new LiteralControl(" "));
			//Controls.Add(new LiteralControl(" ("));
			//Controls.Add(new LiteralControl("/"));
			//Controls.Add(TotalLabel);
			//Controls.Add(new LiteralControl(") "));
		}
		
		protected virtual string GetBalance()
		{
			if (SubjectType == null || SubjectType == String.Empty)
				throw new Exception("The SubjectType property must be set.");
			
			if (SubjectID == null || SubjectID == Guid.Empty)
				throw new Exception("The SubjectID property must be set.");
			
			int balance = 0;
			
			string output = String.Empty;
			
			if (ViewState["Balance"] != null)
				balance = (int)ViewState["Balance"];
			else
			{
				// If the balance property is specified then get the balance from it to avoid extra requests to data store
				if (BalanceProperty != null && BalanceProperty != String.Empty)
					balance = GetBalanceFromProperty();
				// Otherwise count the balance each time
				else
					balance = CountVotesStrategy.New().CountBalance(SubjectType, SubjectID, BalanceProperty);
			}
			
			// If it's positive then put a + before the value
			if (balance > 0)
				output = output + "+";
			
			// Add the balance to the output
			output = output + balance;
			
			return output;
		}
		
		protected virtual int GetBalanceFromProperty()
		{
			int balance = 0;
			
			if (BalanceProperty != null && BalanceProperty != String.Empty)
			{
				PropertyInfo property = Subject.GetType().GetProperty(BalanceProperty);
				
				if (property == null)
					throw new Exception("Can't find '" + BalanceProperty + "' property on type '" + SubjectType + "'.");
				
				balance = (int)property.GetValue(Subject, null);
			}
			else
				throw new InvalidOperationException("The BalanceProperty property is not specified.");
			
			return balance;
		}
		
		protected virtual string GetTotal()
		{
			if (SubjectType == null || SubjectType == String.Empty)
				throw new Exception("The SubjectType property must be set.");
			
			if (SubjectID == null || SubjectID == Guid.Empty)
				throw new Exception("The SubjectID property must be set.");
			
			int total = 0;
			
			if (ViewState["Total"] != null)
				total = (int)ViewState["Total"];
			else
			{
				// If the total property is specified then get the balance from it to avoid extra requests to data store
				if (TotalProperty != null && TotalProperty != String.Empty)
					total = GetTotalFromProperty();
				// Otherwise count the balance each time
				//else
				//	total = CountVotesStrategy.New().CountTotal(SubjectType, SubjectID, BalanceProperty, TotalProperty);
			}
			
			return total.ToString();
		}
		
		protected virtual int GetTotalFromProperty()
		{
			int total = 0;
			
			if (TotalProperty != null && TotalProperty != String.Empty)
			{
				PropertyInfo property = Subject.GetType().GetProperty(TotalProperty);
				
				if (property == null)
					throw new Exception("Can't find '" + TotalProperty + "' property on type '" + SubjectType + "'.");
				
				total = (int)property.GetValue(Subject, null);
			}
			else
				throw new InvalidOperationException("The TotalProperty property is not specified.");
			
			return total;
		}
		
		protected virtual void InitializePositiveButton()
		{
			PositiveLink = new HyperLink();
			PositiveLink.Text = @"[+]";

			Controls.Add(PositiveLink);
		}

		
		public bool EnsureAuthorised()
		{
			Authorisation.EnsureIsAuthenticated();
			Authorisation.EnsureUserCan("Create", "Vote");
			
			return Authorisation.UserCan("Create", "Vote");
		}
		
		protected void LoadLinks()
		{
			using (LogGroup logGroup = LogGroup.StartDebug("Loading links for VoteElement '" + ID + "'."))
			{
				PositiveLink.NavigateUrl = CreateCustomPostbackUrl(true);
				NegativeLink.NavigateUrl = CreateCustomPostbackUrl(false);
			}
		}
		
		protected bool IsDataBound = false;
		
		protected virtual void EnsureDataBound()
		{
			if (!IsDataBound)
				DataBind();
		}
	}
}
