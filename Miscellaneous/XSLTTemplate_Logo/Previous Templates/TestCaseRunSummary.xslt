<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html>

<blockquote>

<style type='text/css'>
a:link {COLOR: #0000FF}a:visited {COLOR: #810541}a:hover {COLOR: #00FF00}a:active {COLOR: #0000FF}
</style>

<head>

<title>SOAPUI Automation Test Result</title>
</head>
<body bgcolor = "#FFFFFF">

<p align = "center"/><table align="center" border="1" bordercolor="#000000" id="table1" width="900" height="31" cellspacing="0" bordercolorlight="#FFFFFF">

<tr>

<td COLSPAN = "7" bgcolor ="#687C7D">
<p align="center"><font color="#FFFFFF" size="4" face= "Copperplate Gothic Bold"><xsl:value-of select="testcasesummary/project"/> </font></p>
</td>

</tr>

<tr>

<td COLSPAN = "7" bgcolor ="#C6D0D1">
<p align="center"><b><font color="#687C7D" size="2" face= "Verdana"> Test Case Results </font></b></p>
</td>

</tr>

<tr bgcolor="#687C7D">

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Test Case ID</font></b></p>
</td>

<td width="600">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Test Case Description</font></b></p>
</td>

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Module</font></b></p>
</td>

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Service Call</font></b></p>
</td>

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Test Case Type</font></b></p>
</td>

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">Status</font></b></p>
</td>

<td width="400">
<p align="center"><b><font color = "white" face="Arial Narrow" size="2">RQ-RS Data</font></b></p>
</td>

</tr>

<xsl:for-each select="testcasesummary/testcases/testcase">

<tr bgcolor = "#EDEEF0">
<td width="400">
<p align="center">

<a target="about_blank">
  <xsl:attribute name="href">
    <xsl:value-of select="link1"/>
  </xsl:attribute>
<b><font face="Verdana" size="2">
  <xsl:value-of select="id"/>
</font></b></a>

</p>
</td>

<td width="400">
<p align="center"><font face="Verdana" size="2"><xsl:value-of select="description"/>
</font></p></td>

<td width="400">
<p align="center"><font face="Verdana" size="2"><xsl:value-of select="module"/>
</font></p></td>

<td width="400">
<p align="center"><font face="Verdana" size="2"><xsl:value-of select="servicecall"/>
</font></p></td>

<td width="400">
<p align="center"><font face="Verdana" size="2"><xsl:value-of select="type"/>
</font></p></td>

<td width="400">
<p align="center"><b>
<xsl:choose>
        <xsl:when test="status='Pass'">     
		<font face="Verdana" size="2" color="#008000">
		<xsl:value-of select="status"/></font>   		
        </xsl:when>
	<xsl:when test="status='Fail'">     
		<font face="Verdana" size="2" color="#FF0000">
		<xsl:value-of select="status"/></font>    		
        </xsl:when>
        <xsl:otherwise>
          <font face="Verdana" size="2" color="#8A4117">
	  <xsl:value-of select="status"/></font>
        </xsl:otherwise>
</xsl:choose>

</b></p>

</td>

<td width="400">
<p align="center">

<a target="about_blank">
  <xsl:attribute name="href">
    <xsl:value-of select="link2"/>
  </xsl:attribute>
<b><font face="Verdana" size="2">
  <xsl:value-of select="rqrs"/>
</font></b></a>

</p>
</td>

</tr>

</xsl:for-each>

</table>


<table align="center" border="1" bordercolor="#000000" id="table1" width="900" height="31" cellspacing="0" bordercolorlight="#FFFFFF">
<tr bgcolor ="#C6D0D1">

<td width="400">
<p align="justify"><b><font color="#687C7D" size="2" face= "Verdana">Passed : <xsl:value-of select="testcasesummary/summary/passed"/>
</font></b></p></td>

<td width="400">
<p align="justify"><b><font color="#687C7D" size="2" face= "Verdana">Failed : <xsl:value-of select="testcasesummary/summary/failed"/>
</font></b></p></td>
</tr>

</table>

</body>
</blockquote>
</html>

</xsl:template>

</xsl:stylesheet> 