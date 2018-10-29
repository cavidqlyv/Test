<%@ Page Language="C#" MasterPageFile="~/Site.master" Title="Modules" AutoEventWireup="true" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Diagnostics" %>
<script runat="server">
    
    #region Main functions
    /// <summary>
    /// Displays the index for managing modules.
    /// </summary>
    public void ManageModules()
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Displaying index for managing modules."))
    	{
	        OperationManager.StartOperation("ManageModules", IndexView);
	
	        ModuleContextCollection modules = new ModuleLoader().GetModules();
	
	        if (modules != null)
	        {
	            IndexGrid.DataSource = Collection<IEntity>.ConvertAll(modules);
	
		        Authorisation.EnsureUserCan("View", IndexGrid.DataSource);
	        }
	
	        IndexView.DataBind();
        }
    }
    #endregion

    #region Event handlers
    private void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            switch (QueryStrings.Action)
            {
                default:
                    ManageModules();
                    break;
            }
        }
    }
    
	private void Page_Init(object sender, EventArgs e)
	{
		IndexGrid.AddSortItem(Resources.Language.Name + " " + Resources.Language.Asc, "NameAscending");
		IndexGrid.AddSortItem(Resources.Language.Name + " " + Resources.Language.Desc, "NameDescending");
	}

    protected void IndexGrid_ItemCommand(object sender, DataGridCommandEventArgs e)
    {
        switch (e.CommandName)
        {
            case "Enable":
				EnableModule(e.CommandArgument.ToString());
				break;
            case "Disable":
				DisableModule(e.CommandArgument.ToString());
                break;
        }
    }
    
    private void EnableModule(string moduleID)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Enabling module: " + moduleID))
    	{
	    	Authorisation.EnsureUserCan("Enable", "Module");
	        ModuleState.Enable(moduleID);
	        Result.Display(Resources.Language.ModuleEnabled);
        }
        
        // Redirect outside of log group
	    Response.Redirect("Modules.aspx");
    }
    
    private void DisableModule(string moduleID)
    {
    	using (LogGroup logGroup = LogGroup.StartDebug("Disabling module: " + moduleID))
    	{
			Authorisation.EnsureUserCan("Disable", "Module");
	        ModuleState.Disable(moduleID);
	        Result.Display(Resources.Language.ModuleDisabled);
        }
        
        // Redirect outside of log group
	    Response.Redirect("Modules.aspx");
    }
    #endregion


</script>
<asp:Content ID="Body" ContentPlaceHolderID="Body" Runat="Server">
    <asp:MultiView runat="server" ID="PageView">
        <asp:View runat="server" ID="IndexView">
            			<h1>
                        <%= Resources.Language.ManageModules %>
                    	</h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                    	<p class="Intro">
                            <%= Resources.Language.ManageModulesIntro %>
                     	</p>
                
                        <ss:IndexGrid ID="IndexGrid" runat="server" DefaultSort="NameAscending" AllowPaging="True"
                            DataKeyField="ModuleID" HeaderText='<%# Resources.Language.Modules %>' AutoGenerateColumns="False"
                            CellPadding="0" CssClass="BodyPanel" EnableExpansion="False"
                            GridLines="None" PageSize="20" ShowFooter="True" ShowSort="False" Width="100%"
                            EmptyDataText='<%# Resources.Language.NoModulesFound %>' OnItemCommand="IndexGrid_ItemCommand">
                            <Columns>
                                <asp:TemplateColumn>
                                    <itemtemplate>
																	<div class="Title"><%# DataBinder.Eval(Container.DataItem, "ModuleID") %>
																	
																	</div>
																	
</itemtemplate>
                                </asp:TemplateColumn>
								<asp:TemplateColumn>
                                    <itemtemplate>
														<div class="Details"><%# DataBinder.Eval(Container.DataItem, "Config.Title") %>
																	</div>			
																	
									</itemtemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                <itemTemplate><%# Utilities.GetEnabled(ModuleState.IsEnabled((string)Eval("ModuleID"))) %></itemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
                                    <itemstyle width="100px" cssclass="Actions"></itemstyle>
                                    <itemtemplate>
                                    <ASP:LINKBUTTON id=EnableButton runat="server" enabled='<%# Authorisation.UserCan("Edit", (ModuleContext)Container.DataItem) %>' CommandName="Enable" causesvalidation="false" ToolTip='<%# Resources.Language.EnableModuleToolTip %>' text='<%# Resources.Language.Enable %>' visible='<%# !(bool)ModuleState.IsEnabled((string)Eval("ModuleID")) %>' CommandArgument='<%# Eval("ModuleID") %>'>
																	</ASP:LINKBUTTON>
																	<ASP:LINKBUTTON id=DisableButton runat="server" enabled='<%# Authorisation.UserCan("Edit", (ModuleContext)Container.DataItem) %>' CommandName="Disable" causesvalidation="false" ToolTip='<%# Resources.Language.DisableModuleToolTip %>' text='<%# Resources.Language.Disable %>' visible='<%# (bool)ModuleState.IsEnabled((string)Eval("ModuleID")) %>' CommandArgument='<%# Eval("ModuleID") %>'>
																	</ASP:LINKBUTTON>
</itemtemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </ss:IndexGrid>
        </asp:View>
        <asp:View runat="server" ID="FormView">
                    <table class="OuterPanel">
                        <tr>
                            <td class="Heading1">
                                <%= OperationManager.CurrentOperation == "CreateModule" ? Resources.Language.CreateModule : Resources.Language.EditModule %>
                            </td>
                        </tr>
                        <tr>
                            <td class="Intro">
                                <ss:Result ID="Result2" runat="server">
                                </ss:Result>
                                <div>
                                    <%= OperationManager.CurrentOperation == "CreateModule" ? Resources.Language.CreateModuleIntro : Resources.Language.EditModuleIntro %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            <ss:EntityForm runat="server" HeaderText="ModuleDetails">
                            <ss:EntityFormTextBoxItem runat="server" PropertyName="Name" text='<%# Resources.Language.Name + ":" %>' IsRequired="true" RequiredErrorMessage='<%# Resources.Language.ModuleNameRequired %>'></ss:EntityFormTextBoxItem>

                            <ss:EntityFormButtonsItem runat="server">
                            <FieldTemplate>
                              <asp:Button ID="UpdateButton2" runat="server" Text='<%# Resources.Language.Update %>' CssClass="FormButton"
                                                CommandName="Update"></asp:Button>&nbsp;<asp:Button ID="EditCancelButton2" runat="server"
                                                    OnClientClick='<%# "return confirm(\"" + Resources.Language.ConfirmCancelEditModule + "\")" %>'
                                                    Text='<%# Resources.Language.Cancel %>' CommandName="Cancel"></asp:Button>
                                                    </FieldTemplate>
                             </ss:EntityFormButtonsItem>
                            </ss:EntityForm>
                                
                                  
                </EditItemTemplate>
                <ItemTemplate>
                 // TODO: Add view module template
                </ItemTemplate>
            </asp:FormView>
        </asp:View>
    </asp:MultiView>
</asp:Content>

