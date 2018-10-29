<%@ Control Language="C#" ClassName="IndexProjects" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" autoeventwireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Projects" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Projects.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Project), IndexGrid, true);
    	    
        IndexGrid.AddSortItem(Language.CompanyName + " " + Language.Asc, "CompanyNameAscending");
        IndexGrid.AddSortItem(Language.CompanyName + " " + Language.Desc, "CompanyNameDescending");
        IndexGrid.AddSortItem(Language.CurrentVersion + " " + Language.Asc, "CurrentVersionAscending");
        IndexGrid.AddSortItem(Language.CurrentVersion + " " + Language.Desc, "CurrentVersionDescending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Asc, "NameAscending");
        IndexGrid.AddSortItem(Language.Name + " " + Language.Desc, "NameDescending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Asc, "StatusAscending");
        IndexGrid.AddSortItem(Language.Status + " " + Language.Desc, "StatusDescending");
        IndexGrid.AddSortItem(Language.Summary + " " + Language.Asc, "SummaryAscending");
        IndexGrid.AddSortItem(Language.Summary + " " + Language.Desc, "SummaryDescending");
        IndexGrid.AddSortItem(Language.Visibility + " " + Language.Asc, "VisibilityAscending");
        IndexGrid.AddSortItem(Language.Visibility + " " + Language.Desc, "VisibilityDescending");
       
        IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "TotalDemandVotes");
        IndexGrid.AddDualSortItem(Language.EffectiveVotesBalance, "EffectiveVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalEffectiveVotes, "TotalEffectiveVotes");
    }
    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "Project");
  }
                
  public override void InitializeInfo()
  {
  		MenuTitle = Language.Index;
  		MenuCategory = Language.Projects;
	  	ShowOnMenu = true;
  }    
</script>
	<div class="Trail">
		<a href='<%= Request.ApplicationPath %>'><%= Language.Home %></a> &gt; <a href='<%= new UrlCreator().CreateUrl("Index", "Project") %>'><%= Language.Projects %></a>
	</div>
            <h1>
                        <%= Language.ManageProjects %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageProjectsIntro %>
                        </p>
                                <div id="ViewLinks"><%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Project") %>'><%= Language.Xml %></a>
                                </div>
                        <div id="ActionButtons">
                        	<asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateProject %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                </div>
				
		<script language="javascript">function showID(path, title, id)
				{
					window.open(path + '/IDWindow.aspx?Title=' + title + '&ID=' + id, 'ShowID_' + id, 'height=100,width=400,resizable=yes,status=no');
				}</script>
                <ss:IndexGrid ID="IndexGrid" DataSource='<%# DataSource %>' runat="server" DefaultSort="NameAscending" AllowPaging='<%# EnablePaging %>'
                            DataKeyNames="ID" HeaderText='<%# Language.Projects %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize='20' ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoProjectsFound %>'>
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemstyle cssclass="IconColumn" width="50px" wrap="false"></itemstyle>
                                    <itemtemplate>
																	<div class="Padded" style="height: 100%">
																	[<%# String.Format("<a href=\"javascript:showID('{0}', '{1}', '{2}');\">#</a>", Request.ApplicationPath.TrimEnd('/'), WebUtilities.EncodeJsString((string)DataBinder.Eval(Container.DataItem, "Name")) + "&nbsp;" + Language.ID, DataBinder.Eval(Container.DataItem, "ID")) %>]
																	</div>
</itemtemplate>
                                </asp:TemplateColumn>
                                
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Title"><a href='<%# UrlCreator.Current.CreateUrl("Select", (IEntity)Container.DataItem) %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
																	</div>
																	<div class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Summary") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Summary") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Summary") : "&nbsp;", 200) %></div>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="120px" horizontalalign="Center"></itemstyle>
                                    <itemtemplate>
																	<div class="Details">
																		<%# Language.Visibility%>:
																	&nbsp;<%# DataBinder.Eval(Container.DataItem, "Visibility")%>
																	</div>
																	<div class="Details">
																		<%# Language.Status%>:
																	&nbsp;<%# DataBinder.Eval(Container.DataItem, "Status") %></div>													
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="120px" horizontalalign="Center"></itemstyle>
                                    <itemtemplate>
																	<div class="Details">
																	
																		<%# Language.Version%>:
																	&nbsp;<%# Utilities.OptionalText(DataBinder.Eval(Container.DataItem, "CurrentVersion"), Language.NA)%>
																	
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' /></div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="50px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	<ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditProjectToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>' visible='<%# Authorisation.UserCan("Edit", (Project)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteProject %>' ToolTip='<%# Language.DeleteProjectToolTip %>' visible='<%# Authorisation.UserCan("Delete", (Project)Container.DataItem) %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>