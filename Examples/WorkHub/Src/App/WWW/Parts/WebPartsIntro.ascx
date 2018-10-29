<%@ Control Language="C#" ClassName="WebPartsIntro" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>

<script runat="server">

	private void Page_Load(object sender, EventArgs e)
	{
		DefaultHeight = 200;
	}

    public override void InitializeInfo()
    {
    	MenuTitle = Resources.Language.WebPartsIntro;
    	MenuCategory = Resources.Language.General;
    }
                    
</script>
<p>Add more panels to this page:</p>
<ol>
<li>Sign in (top right of the page)</li>
<li>If you're an administrator then select between user scope (your own private layout) and shared scope (the general layout) using "Scope:" links at the bottom right of the page.</li>
<li>Switch to catalog mode using the "Mode:" list at the bottom left of the page.</li>
<li>Select from the available catalogs, to view a list of the related panels.</li>
<li>Check the box next to the panels you want to add.</li>
<li>Select the zone to add the panels to.</li>
<li>Click Add.</li>
<li>The panels will be added to the specified zone.</li>
</ol>