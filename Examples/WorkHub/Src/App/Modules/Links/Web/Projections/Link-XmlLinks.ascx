<%@ Control Language="C#" ClassName="XmlIndex" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseProjection" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="cc" %>
<%@ Register Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" Assembly="SoftwareMonkeys.WorkHub.Web" TagPrefix="ss" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Entities" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.Security" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Web.WebControls" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Modules.Links.Properties" %>
<%@ Import Namespace="SoftwareMonkeys.WorkHub.Data" %>
<%@ Import Namespace="System.Collections.Generic" %>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
    }
                    
</script>

            <h1>
                        <%= Language.LinksXml %>
                    </h1>
                        <ss:Result ID="Result1" runat="server">
                        </ss:Result>
                        <p>
                            <%= Language.LinksXmlIntro %>
                        </p>
                    <h2><%= Language.LinksXmlPages %></h2>
                    <p><ul><li><a href="<%= UrlCreator.Current.CreateExternalXmlUrl("Index", "Link") %>" target="_blank"><%= Language.AllLinks %></a></li>
                    </ul></p>
                    </div>