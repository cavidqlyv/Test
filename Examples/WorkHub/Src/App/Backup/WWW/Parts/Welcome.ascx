<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Parts.BasePart" className="Welcome" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import namespace="SoftwareMonkeys.WorkHub.Configuration" %>

<script runat="server">

	private void Page_Load(object sender, EventArgs e)
	{
		Visible = QueryStrings.Action == String.Empty || QueryStrings.Type == String.Empty;
		
		DefaultHeight = Unit.Pixel(60);
	}

    public override void InitializeInfo()
    {
    	MenuTitle = Resources.Language.Welcome;
    	MenuCategory = Resources.Language.General;
    }
                    
                    
</script>
<p><%= Config.Application.Settings.GetString("WelcomeMessage").Replace("\n", "<br/>") %></p>