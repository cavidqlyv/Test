<%@ Control Language="C#" ClassName="IndexLinks" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" autoeventwireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Link), IndexGrid, true);
    	    
        IndexGrid.AddDualSortItem(Language.Title, "Title");
        IndexGrid.AddDualSortItem(Language.Url, "Url");
    }

    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "Link");
  }
  
  public override void InitializeInfo()
  {
  	MenuTitle = Language.Index;
  	MenuCategory = Language.Links;
  }
                    
</script>
            <h1>
                        <%= Language.ManageLinks %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageLinksIntro %>
                        </p>
                                <div id="ViewLinks"><%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Link") %>'><%= Language.Xml %></a>
                                </div>
                        <div id="ActionButtons">
                        	<asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateLink %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                                </div>
				<p>
                <ss:IndexGrid ID="IndexGrid" DataSource='<%# DataSource %>' runat="server" DefaultSort="TitleAscending" AllowPaging='<%# EnablePaging %>'
                            DataKeyNames="ID" HeaderText='<%# Language.Links %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize='20' ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoLinks %>'>
                            <Columns>
                                
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Title"><a href='<%# UrlCreator.Current.CreateUrl("View", (Link)Container.DataItem) %>'><%# DataBinder.Eval(Container.DataItem, "Title") %></a>
																	</div>
																	<div class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Summary") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Summary") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Summary") : "&nbsp;", 200) %></div>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="50px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	<ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditLinkToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteLink %>' ToolTip='<%# Language.DeleteLinkToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
                      </p>