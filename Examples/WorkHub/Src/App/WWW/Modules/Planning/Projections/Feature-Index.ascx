<%@ Control Language="C#" ClassName="IndexFeatures" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseIndexProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Modules.Planning" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.Elements" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Planning.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.State" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
   
    public override void Index()
    {
    	using (LogGroup logGroup = LogGroup.Start("Showing an index of features.", NLog.LogLevel.Debug))
    	{
    		LogWriter.Debug("Project ID: " + ProjectsState.ProjectID);
    	
	    	if (ProjectsState.EnsureProjectSelected())
	    	{
	    		Feature[] features = IndexStrategy.New<Feature>((PagingLocation)Location, IndexGrid.CurrentSort).IndexWithReference<Feature>("Project", "Project", ProjectsState.ProjectID);
	    			    		
	    		Index(features);
	    		
	    		WindowTitle = Language.Features + ": " + ProjectsState.ProjectName;
    		}
    	}
    }

    private void Page_Init(object sender, EventArgs e)
    {
    	Initialize(typeof(Feature), IndexGrid);
    
        IndexGrid.AddDualSortItem(Language.Name, "Name");
        IndexGrid.AddDualSortItem(Language.ProjectVersion, "ProjectVersion");
        IndexGrid.AddDualSortItem(Language.DemandVotesBalance, "DemandVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalDemandVotes, "TotalDemandVotes");
        IndexGrid.AddDualSortItem(Language.EffectiveVotesBalance, "EffectiveVotesBalance");
        IndexGrid.AddDualSortItem(Language.TotalEffectiveVotes, "TotalEffectiveVotes");
    }
    
  private void CreateButton_Click(object sender, EventArgs e)
  {
  		Navigator.Go("Create", "Feature");
  }                    
</script>
            <div class="Heading1">
                        <%= Language.ManageFeatures %>
                    </div>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.ManageFeaturesIntro %>
                        </p>
                       
                        <div id="ActionsContainer">
                       	<div id="ActionButtons">
                            <asp:Button ID="CreateButton" runat="server" Text='<%# Language.CreateFeature %>'
                                CssClass="Button" OnClick="CreateButton_Click"></asp:Button>
                        </div>
                        <div id="ViewLinks">
                        	<%= Language.View %>: <a href='<% = UrlCreator.Current.CreateUrl("XmlLinks", "Feature") %>'><%= Language.Xml %></a>
                    	</div>
						</div>
				<script language="javascript">function showID(title, id)
				{
					window.open('<%= Request.ApplicationPath %>/IDWindow.aspx?Title=' + title + '&ID=' + id, 'ShowID_' + id, 'height=100,width=400,resizable=yes,status=no');
				}
				</script>
                 <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending"
                            DataKeyNames="ID" HeaderText='<%# Language.Features %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="True" Width="100%"
                            EmptyDataText='<%# Language.NoFeaturesForProject %>' AllowPaging="True">
                            <Columns>
                              
                                                           <asp:TemplateColumn>
                                                           <ItemStyle width="90%"/>
                                    <ItemTemplate>
                                    <asp:Hyperlink runat="server" text='<%# Eval("Name") %>' navigateurl='<%# UrlCreator.Current.CreateUrl("View", (IEntity)Container.DataItem) %>'></asp:Hyperlink>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                                           <ItemStyle width="90%"/>
                                    <ItemTemplate>
                                    <asp:label runat="server" text='<%# Eval("ProjectVersion") %>'/>
                                    </ItemTemplate>
                                </asp:TemplateColumn>   
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Needed + "&BalanceProperty=DemandVotesBalance&TotalProperty=TotalDemandVotes" %>' /></div>
																	<div class="Content"><cc:ElementControl runat="server" ElementName="Vote" DataSource='<%# (IEntity)Container.DataItem %>' PropertyValuesString='<%# "Text=" + Language.Effective + "&BalanceProperty=EffectiveVotesBalance&TotalProperty=TotalEffectiveVotes" %>' /></div>
									</itemtemplate>
                                </asp:TemplateColumn>
                                  			<asp:TemplateColumn>
                                  			<ItemStyle width="80" horizontalalign="right" wrap="false"/>
                            <itemtemplate>
                               <ASP:Hyperlink id=EditButton runat="server" ToolTip='<%# Language.EditFeatureToolTip %>' text='<%# Language.Edit %>' navigateurl='<%# Navigator.GetLink("Edit", (IEntity)Container.DataItem) %>'>
																	</ASP:Hyperlink>&nbsp;
																	<cc:DeleteLink id=DeleteButton runat="server" text='<%# Language.Delete %>' ConfirmMessage='<%# Language.ConfirmDeleteFeature %>' ToolTip='<%# Language.DeleteFeatureToolTip %>'  navigateurl='<%# Navigator.GetLink("Delete", (IEntity)Container.DataItem) %>'>
																	</cc:DeleteLink>	
                            </itemtemplate>
                        </asp:TemplateColumn>
                              
                            </Columns>
                        </ss:IndexGrid>