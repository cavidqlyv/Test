<%@ Control Language="C#" ClassName="IndexImportantSuggestions" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Tasks" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Tasks.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        	// Set the maximum number of items displayed
        	int limit = 10;

            Suggestion[] suggestions;
            
			suggestions = IndexSuggestionStrategy.New().IndexImportantSuggestions(ProjectsState.ProjectID, limit);
	
			if (Authorisation.UserCan("View", suggestions))
			{
				SuggestionList.DataSource = suggestions;
				DataBind();
			}
			else
				Visible = false;
			
			SetDefaultHeight(suggestions.Length);
        }
    }

    private void Page_Init(object sender, EventArgs e)
    {
     
    }

    
    public override void InitializeInfo()
    {
      	MenuTitle = Language.ImportantSuggestions;
      	MenuCategory = Language.Suggestions;
        ShowOnMenu = true;
    }
                    
</script>
			<asp:Repeater id="SuggestionList" Runat="server">
				<ItemTemplate>
						<h3>
							<a href='<%# Navigator.GetLink("View", (IEntity)Container.DataItem) %>'>
								<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Subject"), 50) %>
							</a>
						</h3>
						<p class="Details">
							<%# Utilities.GetRelativeDate((DateTime)DataBinder.Eval(Container.DataItem, "DatePosted"))%>
							<asp:PlaceHolder Runat=server Visible='<%# Eval("AuthorName") != null && (string)Eval("AuthorName") != String.Empty %>' ID="Placeholder1">
							- <asp:hyperlink runat="server" navigateurl='<%# Navigator.GetLink("Reply", "Issue") + "?IssueID=" + Eval("ID").ToString() %>' enabled='<%# Eval("AuthorEmail") != null && (string)Eval("AuthorEmail") != String.Empty %>' text='<%# Utilities.Summarize((string)Eval("AuthorName"), 100) %>' />
							</asp:PlaceHolder>
							<asp:PlaceHolder Runat=server Visible='<%# ProjectsState.Project == null && DataBinder.Eval(Container.DataItem, "Project") != null %>' ID="Placeholder2">
								<span class="ProjectLabel">- <a href='<%# Eval("Project") != null ? Navigator.GetLink("Select", (IEntity)DataBinder.Eval(Container.DataItem, "Project")) : String.Empty %>'>
										<%# DataBinder.Eval(Container.DataItem, "Project.Name") %>
									</a></span>
							</asp:PlaceHolder>
						</p>
						<p class="Details">
							<%= Language.Status %>: <%# SuggestionStatusUtilities.GetStatusText((SuggestionStatus)Eval("Status")) %>
						</p>
						<p>
							<%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description"), 100) %>
						</p>
						<hr/>
				</ItemTemplate>
			</asp:Repeater>
			<asp:Panel id=NoSuggestionsPanel cssclass="NotFound" Runat="server" visible='<%# SuggestionList.DataSource == null || ((Suggestion[])SuggestionList.DataSource).Length == 0 %>'>
				<p>
					<%= ProjectsState.ProjectID == Guid.Empty ? Language.NoImportantSuggestions : Language.NoImportantProjectSuggestions %>
				</p>
			</asp:Panel>