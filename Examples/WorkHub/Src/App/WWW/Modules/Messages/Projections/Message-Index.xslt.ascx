<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseXmlProjection" autoeventwireup="true" %><?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
  		<head>
    		< rel="stylesheet" type="text/css" href='<%= Request.ApplicationPath + "/Styles/Xml.css" %>' />
    	</head>
      <body>
        <h2>Messages</h2>
        <p>This is an XML page that is being transformed in the browser using XSLT. View the page source to see the XML.</p>
        <p>The XML from this page can be consumed as a rest web service by other applications.</p>
        <table>
          <tr>
            <th>Subject</th>
            <th>Body</th>
            <th>Sender</th>
            <th>ID</th>
          </tr>
          <xsl:for-each select="//*/Message">
            <tr>
              <td>
                <xsl:value-of select="Subject"/>
              </td>
              <td>
                <xsl:value-of select="Body"/>
              </td>
              <td>
                <xsl:value-of select="Sender"/>
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