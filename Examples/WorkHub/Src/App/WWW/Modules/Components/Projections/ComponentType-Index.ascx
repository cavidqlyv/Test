<%@ Control Language="C#" ClassName="IndexComponentTypes" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" autoeventwireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Components.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(ComponentType), IndexGrid, true);
    	    
    }

    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "ComponentType");
  }
  
  private void ComponentsButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Index", "Component");
  }
  
  
  public override void InitializeInfo()
  {
  	MenuTitle = Language.ComponentTypes;
  	MenuCategory = Language.Planning + "/" + Language.Technical;
  }
                    
</script>
            <h1>
                        <%= Language.ComponentTypes %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ComponentTypesIntro %>
                        </p>
                                <div id="ViewLinks"><%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlComponentTypes", "ComponentType") %>'><%= Language.Xml %></a>
                                </div>
                        <div id="ActionButtons">
                        	<asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateComponentType %>'
                                CssClass="WideButton" OnClick="CreateButton_Click"></asp:Button>
                        	<asp:Button ID="ComponentsButton" runat="server" Text='<%# Language.Components %>'
                                CssClass="WideButton" OnClick="ComponentsButton_Click"></asp:Button>
                                </div>
				<p>
                <ss:IndexGrid ID="IndexGrid" DataSource='<%# DataSource %>' runat="server" DefaultSort="NameAscending" AllowPaging='<%# EnablePaging %>'
                            DataKeyNames="ID" HeaderText='<%# Language.ComponentTypes %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize='20' ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoComponentTypes %>'>
                            <Columns>
                                
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Title"><a href='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'><%# DataBinder.Eval(Container.DataItem, "Name") %></a>
																	</div>
																	<div class="Content" style='<%# "display: " + (DataBinder.Eval(Container.DataItem, "Description") != String.Empty ? "visible" : "none") %>'><%# Utilities.Summarize((string)DataBinder.Eval(Container.DataItem, "Description") != String.Empty ? (string)DataBinder.Eval(Container.DataItem, "Description") : "&nbsp;", 200) %></div>
</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="50px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
																	<ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditComponentTypeToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteComponentType %>' ToolTip='<%# Language.DeleteComponentTypeToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
                      </p>