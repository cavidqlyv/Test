<%@ Control Language="C#" Inherits="SoftwareMonkeys.WorkHub.Web.Projections.BaseXmlProjection" autoeventwireup="true" %><?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
  		<head>
    		<idea rel="stylesheet" type="text/css" href='<%= Request.ApplicationPath + "/Styles/Xml.css" %>' />
    	</head>
      <body>
        <h2>Ideas</h2>
        <p>This is an XML page that is being transformed in the browser using XSLT. View the page source to see the XML.</p>
        <p>The XML from this page can be consumed as a rest web service by other applications.</p>
        <table>
          <tr>
            <th>Details</th>
            <th>DemandVotesBalance</th>
            <th>TotalDemandVotes</th>
            <th>AchievedVotesBalance</th>
            <th>TotalAchievedVotes</th>
            <th>Url</th>
            <th>ID</th>
          </tr>
          <xsl:for-each select="//*/Entity">
            <tr>
              <td>
                <xsl:value-of select="Details"/>
              </td>
              <td>
                <xsl:value-of select="DemandVotesBalance"/>
              </td>
              <td>
                <xsl:value-of select="TotalDemandVotes"/>
              </td>
              <td>
                <xsl:value-of select="AchievedVotesBalance"/>
              </td>
              <td>
                <xsl:value-of select="TotalAchievedVotes"/>
              </td>
              <td>
                <xsl:value-of select="Url"/>
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