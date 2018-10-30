<%@ Control Language="C#" ClassName="Parts" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Configuration" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Register Src="../Parts/Welcome.ascx" TagName="Welcome" TagPrefix="uc" %>
<%@ Register Src="../Parts/AccountSummary.ascx" TagName="AccountSummary" TagPrefix="uc" %>
<%@ Register Src="../Parts/WebPartsIntro.ascx" TagName="WebPartsIntro" TagPrefix="uc" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Business.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Parts" %>
<script runat="server">
    protected override void OnInit(EventArgs e)
    {
    	// Ensure that the web parts are initialized
    	InitializeParts();
       	
    	base.OnInit(e);
    
    }
    
    public void InitializeParts()
    { 
    	if (!IsPostBack)
    	{
    		PartScanner[] partScanners = new PartScanner[] {
    				new PartScanner(Page),
    				new ModulePartScanner(Page)};
    	
    		new PartsInitializer(Page,partScanners).Initialize();
    	}
    }
    
    private void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        
        	ZonesContainer.DataBind();  
        	PartsModeZoneHolder.DataBind();
        	//AddDefaultZones();
        	
        
            foreach (WebPartDisplayMode mode in PartManager.SupportedDisplayModes)
            {
                string modeName = mode.Name;
                if (mode.IsEnabled(PartManager))
                {
                    ListItem item = new ListItem(modeName, modeName);
                    DisplayModeDropdown.Items.Add(item);
                }
            }
        }
    }
    
    private void AddDefaultZones()
    {
    	PartManager.AddWebPart(
    		PartState.Parts["Welcome"].Load(Page, PartManager),
    		Left, 0);
    		
    	PartManager.AddWebPart(
    		PartState.Parts["WebPartsIntro"].Load(Page, PartManager),
    		Center, 0);
    		
    	PartManager.AddWebPart(
    		PartState.Parts["AccountSummary"].Load(Page, PartManager),
    		Right, 0);
    }

    protected void ToggleSharedScope_Click(object sender, EventArgs e)
    {
        //String selectedMode = DisplayModeDropdown.SelectedValue;
        //WebPartDisplayMode mode =
            if (PartManager.Personalization.CanEnterSharedScope)
                PartManager.Personalization.ToggleScope();
        //if (mode != null)
         //   PartManager.DisplayMode = mode;
    }

    protected void ToggleUserScope_Click(object sender, EventArgs e)
    {
            PartManager.Personalization.ToggleScope();
    }
    
    protected void DisplayModeDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        String selectedMode = DisplayModeDropdown.SelectedValue;
        WebPartDisplayMode mode =
          PartManager.SupportedDisplayModes[selectedMode];
        if (mode != null)
            PartManager.DisplayMode = mode;
    }
    
</script>
	
	<%= StyleUtilities.GetStyleSheet("Parts") %>
    <asp:WebPartManager ID="PartManager" runat="server">
        <Personalization ProviderName="DynamicPersonalizationProvider" />
    </asp:WebPartManager>
    <asp:placeholder runat="server" id="ZonesContainer">
    <div id="CatalogZone">
    
	    <ss:DynamicCatalogZone id="CatalogZone" runat="server" BorderColor="#CCCCCC" BorderWidth="1px" Font-Names="Verdana" Padding="6">
	        <HeaderVerbStyle Font-Bold="True" />
	        <FooterStyle BackColor="#E2DED6" HorizontalAlign="Right" />
	        <PartChromeStyle BorderColor="#E2DED6" BorderStyle="Solid" BorderWidth="1px" />
	        <InstructionTextStyle ForeColor="#333333" />
	        <LabelStyle ForeColor="#333333" />
	        <SelectedPartLinkStyle />
	        <VerbStyle Font-Names="Verdana" ForeColor="#333333" />
	        <EditUIStyle Font-Names="Verdana" ForeColor="#333333" />
	        <EmptyZoneTextStyle ForeColor="#333333" />
	        <PartStyle CssClass="Part" />
			        <PartTitleStyle CssClass="PartTitle" />
			        <PartChromeStyle CssClass="PartChrome" />
			        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
			        
	    </ss:DynamicCatalogZone>
	    
    
    </div>
    <div id="EditZone">
    <asp:EditorZone ID="EditorZone1" runat="server">
        <ZoneTemplate>
            <asp:AppearanceEditorPart ID="AppearanceEditorPart1" runat="server" />
            <asp:LayoutEditorPart ID="LayoutEditorPart1" runat="server" />    
        </ZoneTemplate>
        <EmptyZoneTextStyle />
			        <PartStyle ForeColor="#333333" CssClass="Part" />
			        <PartTitleStyle CssClass="PartTitle" />
			        <PartChromeStyle CssClass="PartChrome" />
			        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
            
    </asp:EditorZone>
    </div>
	<table class="PartZones">
		<tr>
			<td colspan="3">
			    <asp:WebPartZone ID="Top" Width="100%" Height="100%" runat="server" BorderColor="#CCCCCC" CssClass="PartZone">
			        <PartStyle CssClass="Part" />
			        <TitleBarVerbStyle CssClass="PartTitleVerb"  />
			        <MenuLabelHoverStyle CssClass="PartMenu" />
			        <MenuPopupStyle CssClass="PartMenu" />
			        <MenuVerbStyle CssClass="PartMenu" />
			        <PartTitleStyle CssClass="PartTitle" />
			        <MenuVerbHoverStyle CssClass="PartMenu" />
			        <PartChromeStyle CssClass="PartChrome" />
			        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
			        <MenuLabelStyle CssClass="PartMenu" />
			    </asp:WebPartZone>
			</td>
		</tr>
	<tr>
    <td id="LeftZone" class="Zone">
    <asp:WebPartZone ID="Left" Width="100%" Height="100%" runat="server" cssClass="PartZone" BorderColor="#CCCCCC">
    	<ZoneTemplate>
	            <uc:webpartsintro id="WebPartsIntro" runat="server" Title="Customise"/>
        </ZoneTemplate>
        <PartStyle CssClass="Part" />
        <TitleBarVerbStyle CssClass="PartTitleVerb"  />
        <MenuLabelHoverStyle CssClass="PartMenuLabel" />
        <MenuPopupStyle CssClass="PartMenuPopup" />
        <MenuVerbStyle CssClass="PartMenuVerb" />
        <PartTitleStyle CssClass="PartTitle" />
        <MenuVerbHoverStyle CssClass="PartMenuVerbHover" />
        <PartChromeStyle CssClass="PartChrome" />
        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
        <MenuLabelStyle CssClass="PartMenu" />
    </asp:WebPartZone>
    </td>
    <td id="CenterZone" class="Zone">
        <asp:WebPartZone ID="Center" Width="100%" Height="100%" runat="server" BorderColor="#CCCCCC" CssClass="PartZone">
	    	<ZoneTemplate>
	        </ZoneTemplate>
        <PartStyle CssClass="Part" />
        <TitleBarVerbStyle CssClass="PartTitleVerb"  />
        <MenuLabelHoverStyle CssClass="PartMenuLabel" />
        <MenuPopupStyle CssClass="PartMenuPopup" />
        <MenuVerbStyle CssClass="PartMenuVerb" />
        <PartTitleStyle CssClass="PartTitle" />
        <MenuVerbHoverStyle CssClass="PartMenuVerbHover" />
        <PartChromeStyle CssClass="PartChrome" />
        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
        <MenuLabelStyle CssClass="PartMenu" />
        </asp:WebPartZone>
    </td>
	<td id="RightZone" class="Zone">
        <asp:WebPartZone ID="Right" Width="100%" Height="100%" runat="server" BorderColor="#CCCCCC" CssClass="PartZone">
	    	<ZoneTemplate>
	        </ZoneTemplate>
        <PartStyle CssClass="Part" />
        <TitleBarVerbStyle CssClass="PartTitleVerb"  />
        <MenuLabelHoverStyle CssClass="PartMenuLabel" />
        <MenuPopupStyle CssClass="PartMenuPopup" />
        <MenuVerbStyle CssClass="PartMenuVerb" />
        <PartTitleStyle CssClass="PartTitle" />
        <MenuVerbHoverStyle CssClass="PartMenuVerbHover" />
        <PartChromeStyle CssClass="PartChrome" />
        <HeaderStyle CssClass="PartHeader" HorizontalAlign="Center" />
        <MenuLabelStyle CssClass="PartMenu" />
        </asp:WebPartZone>
    </td>
    </tr>
    </table>
    </asp:placeholder>
    <asp:placeholder runat="server" id="PartsModeZoneHolder" visible='<%# AuthenticationState.IsAuthenticated %>'>
    <div id="PartsModeZoneHolder">
	    <div id="PartsModeZone">
	          <div id="LeftPartsMode">
			      <%= Resources.Language.Mode + ":" %>&nbsp;
			      <asp:DropDownList ID="DisplayModeDropdown"
			        runat="server" 
			        AutoPostBack="true"
			        Width="120"
			        OnSelectedIndexChanged=
			        "DisplayModeDropdown_SelectedIndexChanged">
			      </asp:DropDownList>
		      </div>
	      	<div id="RightPartsMode">
	        	<asp:PlaceHolder runat="server" ID="ScopePanel" visible='<%# AuthenticationState.UserIsInRole("Administrator") %>'>
	            <%# Resources.Language.Scope + ":" %>&nbsp;<asp:LinkButton runat="server" ID="ToggleSharedScope" enabled='<%# PartManager.Personalization.Scope == PersonalizationScope.User %>' Text='<%# Resources.Language.Shared%>' OnClick="ToggleSharedScope_Click"></asp:LinkButton> | <asp:LinkButton runat="server" ID="ToggleUserScope" enabled='<%# PartManager.Personalization.Scope == PersonalizationScope.Shared %>' Text='<%# Resources.Language.User%>' OnClick="ToggleUserScope_Click"></asp:LinkButton>
	            </asp:PlaceHolder>
	        </div>
        </div>
    </div>
    </asp:placeholder>