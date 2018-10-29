<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseXmlProjection" autoeventwireup="true" %><?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
  		<head>
    		<link rel="stylesheet" type="text/css" href='<%= Request.ApplicationPath + "/Styles/Xml.css" %>' />
    	</head>
      <body>
        <h2>Projects</h2>
        <p>This is an XML page that is being transformed in the browser using XSLT. View the page source to see the XML.</p>
        <p>The XML from this page can be consumed as a rest web service by other applications.</p>
        <table>
          <tr>
            <th>Name</th>
            <th>Summary</th>
            <th>More Info</th>
            <th>Company Name</th>
            <th>Status</th>
            <th>Current Version</th>
            <th>ID</th>
          </tr>
          <xsl:for-each select="//*/Entity">
            <tr>
              <td>
                <xsl:value-of select="Name"/>
              </td>
              <td>
                <xsl:value-of select="Summary"/>
              </td>
              <td>
                <xsl:value-of select="MoreInfo"/>
              </td>
              <td>
                <xsl:value-of select="CompanyName"/>
              </td>
              <td>
                <xsl:value-of select="Status"/>
              </td>
              <td>
                <xsl:value-of select="CurrentVersion"/>
              </td>
              <td>
                <xsl:value-of select="ID"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>