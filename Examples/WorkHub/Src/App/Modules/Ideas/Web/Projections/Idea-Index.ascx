<%@ Control Language="C#" ClassName="IndexIdeas" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" autoeventwireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Ideas.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Idea), IndexGrid, true);

		IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "TotalDemandVotes");
        IndexGrid.AddDualSortItem(Language.AchievedVotesBalance, "AchievedVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalAchievedVotes, "TotalAchievedVotes");
    }

    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "Idea");
  }
  
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Ideas;
  	MenuCategory = Language.Brainstorm;
  }
  
                    
</script>
            <h1>
                        <%= Language.ManageIdeas %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageIdeasIntro %>
                        </p>
                                <div id="ViewLinks"><%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Idea") %>'><%= Language.Xml %></a>
                                </div>
                        <div id="ActionButtons">
                        	<asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateIdea %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                </div>
				<p>
                <ss:IndexGrid ID="IndexGrid" 
                			DataSource='<%# DataSource %>'
			                runat="server" 
			                DefaultSort="DetailsAscending"
			                AllowPaging='<%# EnablePaging %>'
                            DataKeyNames="ID"
                            HeaderText='<%# Language.Ideas %>'
                            AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel"
                            EnableExpansion="False"
                            GridLines="None" PageSize='20'
                            ShowFooter="True"
                            ShowSort="True"
                            Width="100%"
                            EmptyDataText='<%# Language.NoIdeas %>'>
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemtemplate>
										<div class="Content" nowrap>
											<a href='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'>
												<%# Language.View %>
											</a>
										</div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
										<div class="Content">
											<%# DataBinder.Eval(Container.DataItem, "Details") %>
											<a href='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'>
												<%# Language.MoreInfo %>...
											</a>
										</div>
										<div class="Details"> <ASP:Hyperlink runat="server"
                                        	enabled='<%# Eval("Author") != null %>'
                                        	ToolTip='<%# Resources.Language.SendMessage %>'
                                        	text='<%# Eval("Author") != null ? Eval("Author.Name") : "" %>'
                                        	navigateurl='<%# Navigator.GetLink("Send", "Message") + "?RecipientID=" + Eval("ID") %>'>
										</ASP:Hyperlink>
										 - <%# Eval("DateCreated") %>
										</div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Details"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Achieved + "&BalanceProperty=AchievedVotesBalance&TotalProperty=TotalAchievedVotes" %>' /></div>
								</itemtemplate>
                                </asp:TemplateColumn>
                                
                                <asp:TemplateColumn>
                                    <itemstyle width="50px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
											<ASP:Hyperlink id=EditButton runat="server"
												ToolTip='<%# Language.EditIdeaToolTip %>' text='<%# Language.Edit %>'
												navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
												Visible='<%# AuthoriseUpdateStrategy.New<Idea>().IsAuthorised((IEntity)Container.DataItem) %>'
											</ASP:Hyperlink>&nbsp;
											<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>'
												ConfirmMessage='<%# Language.ConfirmDeleteIdea %>' ToolTip='<%# Language.DeleteIdeaToolTip %>'
												navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
												Visible='<%# AuthoriseDeleteStrategy.New<Idea>().IsAuthorised((IEntity)Container.DataItem) %>'
											</cc:DeleteLink>	
									</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
                      </p>