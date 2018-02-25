<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html>
<blockquote>

<style type='text/css'>
a:link {COLOR: #0000FF}a:visited {COLOR: #810541}a:hover {COLOR: #00FF00}a:active {COLOR: #0000FF}
</style>

<title> SOAPUI Automation Test Result </title>
<body bgcolor= 	"#F0F8FF">
<Table align= "center" border ="1" width="100%" BORDERCOLOR="#FFFFFF" CELLSPACING="0" CELLPADDING="5" STYLE='Font-Size:12pt Border-Colapse:Colapse'>
		<Thead BGCOLOR="#ADD8E6" STYLE='Font-Weight: Bold Color: #FFFFFF'>
			<TH><font color="BLUE" face="Arial Narrow" size="5">AUTOMATED SOAPUI TEST EXECUTION SUMMARY</font> </TH>
		</Thead>
	</Table>
	
	<Table border="0" CELLSPACING='0' CELLPADDING='3' align="center" >
		<tr><td><font color="Black" face="Arial Narrow" size="3">
		<b>Project Name:  </b><xsl:value-of select="currentrunresults/environment/application"/> <br></br>
		</font></td></tr>
	</Table>

	<p></p>

	<p><font color = "blue" face="Arial Narrow" size="3">

	<b>Start Time: </b><xsl:value-of select="currentrunresults/executiontime/start"/><br></br>
	<b>End Time:  </b><xsl:value-of select="currentrunresults/executiontime/end"/><br></br>
	<b>Execution Time:  </b><xsl:value-of select="currentrunresults/executiontime/total"/>

	</font></p>


	<table border="1" bordercolor="#DC143C" Cellspacing = "0" STYLE='Font-Size:12pt Border-Colapse:Colapse' align="center">
		<tr>
			<td width="400" bgcolor = "#FFE4C4">
			<p align="center"/><b><font color = "blue" face="Arial Narrow" size="2">Summary of TestSuites</font></b>
			</td>
			<td width="400" bgcolor = "#FFE4C4">
			<p align="center"/><b><font color = "blue" face="Arial Narrow" size="2">Description of TestSuites</font></b>
			</td>
			<td width="200" bgcolor = "#FFE4C4">
			<p align="center"/><b><font color = "blue" face="Arial Narrow" size="2">Passed</font></b>
			</td>
			<td width="200" bgcolor = "#FFE4C4">
			<p align="center"/><b><font color = "blue" face="Arial Narrow" size="2">Failed</font></b>
			</td>
		</tr>

		<xsl:for-each select="currentrunresults/overallstatus/testsuite">
		<tr>
			<td width="400">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"></font>
			
			<a>
  			<xsl:attribute name="href">
    			<xsl:value-of select="link"/>
  			</xsl:attribute>
			<font face="Verdana" size="2">
 				 <xsl:value-of select="name"/>
			</font>
			</a>

			</td>
			<td width="200">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="description"/></font>
			</td>
			<td width="200">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="passed"/></font>
			</td>
			<td width="200">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="failed"/></font>
			</td>
		</tr>
		</xsl:for-each>

		<tr>
			<td width="400">
			<p align="center"/><b><font align="center" color = "black" face="Arial Narrow" size="2">TOTAL</font></b>
			</td>
			
			<td width="400">
			<p align="center"/><b><font align="center" color = "black" face="Arial Narrow" size="2">---</font></b>
			</td>
						
			<td width="200">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="currentrunresults/overallstatus/total/passed"/></font></b>
			</td>
			<td width="200">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="currentrunresults/overallstatus/total/failed"/></font></b>
			</td>
		</tr>


	</table>

	<xsl:for-each select="currentrunresults/criticalitystatus/testsuite">

	<p></p>
	
	<table border="1" bordercolor= "#4169E1" Cellspacing = "0"  STYLE='Font-Size:12pt Border-Colapse:Colapse' align="center">
		<tr>
			<td width="300" bgcolor = "#B0E0E6">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="name"/> Testcases</font> </b>
			</td>
			<td width="200" bgcolor = "#B0E0E6">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2">Simple</font></b>
			</td>
			<td width="200" bgcolor = "#B0E0E6">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2">Medium</font></b>
			</td>
			<td width="200" bgcolor = "#B0E0E6">
			<p align="center"/><b><font color = "black" face="Arial Narrow" size="2">Complex</font></b>
			</td>
		</tr>
		<tr>
			<td width="300" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2">Total Passed</font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="passed/simple"/></font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="passed/medium"/></font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="passed/complex"/></font>
			</td>
		</tr>
		<tr>
			<td width="300" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2">Total Failed</font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="failed/simple"/></font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="failed/medium"/></font>
			</td>
			<td width="200" bgcolor = "#FFFFFF">
			<p align="center"/><font color = "black" face="Arial Narrow" size="2"><xsl:value-of select="failed/complex"/></font>
			</td>
		</tr>
	</table>

	</xsl:for-each>

</body>
</blockquote>
</html>

</xsl:template>

</xsl:stylesheet> 