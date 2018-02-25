<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html>
		<head>
			<style>				
				html, body{
					padding:0;
					margin:0;
					position:relative;
					background:#FFFFFF url(body1.jpg);
					background-repeat:repeat;
					color:#fff;
					letter-spacing:1px;
					font-family:Georgia, "Times New Roman", Times, serif;
					font-size:14px;
					font-weight:normal;
				}

				#container{
					padding-top:20px;
					padding-left: 50px; /*this line included as margin is not working*/
					padding-RIGHT: 50px;
					width:100%;
					margin:0 auto;
					text-align: center;
				}

				table {
					border-collapse: collapse;
					border-spacing: 0;
					width:100%;
					-webkit-box-shadow:  0px 2px 1px 5px rgba(242, 242, 242, 0.1);
					box-shadow:  0px 2px 1px 5px rgba(242, 242, 242, 0.1);
				}

				.tabClass {
					border: 1px solid #555;
				}

				.tabClass td {
					border-left: 1px solid #555;
					border-top: 1px solid #555;
					padding: 5px;
					text-align: center;
				}
				
				.tabClass th, .tabClass th:hover {
					border-left: 1px solid #555;
					border-bottom: 1px solid #828282;
					padding: 5px;
					background-color:#404040 !important;
					background-image: -webkit-gradient(linear, left top, left bottom, from(#151515), to(#404040)) !important;
					background-image: -webkit-linear-gradient(top, #151515, #404040) !important;
					background-image:    -moz-linear-gradient(top, #151515, #404040) !important;
					background-image:     -ms-linear-gradient(top, #151515, #404040) !important;
					background-image:      -o-linear-gradient(top, #151515, #404040) !important;
					background-image:         linear-gradient(top, #151515, #404040) !important;
					color:#fff !important;
					font-weight:normal;
				}		


				.tabClass tbody tr:nth-child(even) {
					background: #EBEBEB !important;
					color:#000;
				}

				.tabClass tr:hover *{
					background: #fff;
					color:#000;
				}

				.tabClass tr {
					background:#D7D7D7;
					color:#000;
				}

				.tabSummary caption{
					font-size:20px;
					font-weight:normal;
					background:url(../img/tabClasstable.png);
					background-repeat:no-repeat;
					background-position: 130px center;
					padding-top: 20px;
					height:50px;
					color: Black;
				}		
				
				.tabSummary {
					border: 1px solid #555;
				}		
				
				.tabSummary th, .tabSummary th:hover {
					border-left: 1px solid #555;
					border-bottom: 1px solid #828282;
					padding: 5px;
					background-color:#EBEBEB !important;
					background-image: -webkit-gradient(linear, left top, left bottom, from(#151515), to(#404040)) !important;
					background-image: -webkit-linear-gradient(top, #151515, #404040) !important;
					background-image:    -moz-linear-gradient(top, #151515, #404040) !important;
					background-image:     -ms-linear-gradient(top, #151515, #404040) !important;
					background-image:      -o-linear-gradient(top, #151515, #404040) !important;
					background-image:         linear-gradient(top, #151515, #404040) !important;
					color:Black !important;
					font-weight:normal;
				}		
			</style>	
			<title> SOAPUI Automation Test Result </title>
		</head>
		<body>
		
		<Table align= "center" border ="1" width="100%" BORDERCOLOR="#FFFFFF" CELLSPACING="0" CELLPADDING="5" STYLE='Font-Size:12pt Border-Colapse:Colapse'>
		<Thead BGCOLOR="#ADD8E6" STYLE='Font-Weight: Bold Color: #FFFFFF'>
			
			<TH colspan='4' style='font-family:Copperplate Gothic Bold; font-size:1.4em;'>SOAPUI AUTOMATED TEST EXECUTION SUMMARY</TH>
		</Thead>
	</Table>
	
			<div id="container"> 
				<div style="width:1250px; margin:20px auto; height:50px; background:url(../XSLTTemplate_Logo/logo.jpg);background-repeat: no-repeat;background-position: center;"></div>
				<table class="tabSummary">
					<thead>
						<tr>
							<th style="text-align: left;">Start Time: <b><xsl:value-of select="currentrunresults/executiontime/start"/></b></th>
							<th style="text-align: left;">End Time: <b><xsl:value-of select="currentrunresults/executiontime/end"/></b></th>
							<th style="text-align: left;">Execution Time: <b><xsl:value-of select="currentrunresults/executiontime/total"/></b></th>
						</tr>						
					</thead>
				</table>	
				<br/>		  
		  
				<table class="tabClass">	
					<thead>
						<tr>
							<th>Summary of TestSuites</th>
							<th>Description of TestSuites</th>
							<th>Passed</th>
							<th>Failed</th>
						</tr>
					</thead>
					<tbody>						
						<xsl:for-each select="currentrunresults/overallstatus/testsuite">
						<tr>
							<td style="text-align: left;">
								<a target="new">
									<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
									<b><xsl:value-of select="name"/></b>
								</a>							
							</td>
							<td><xsl:value-of select="description"/></td>
							<td><xsl:value-of select="passed"/></td>
							<td><xsl:value-of select="failed"/></td>
						</tr>
						</xsl:for-each>	
						<tr>
							<td><b><font align="center" color = "black" face="Arial Narrow" size="3">TOTAL</font></b></td>
							<td><b><font align="left" color = "black" face="Arial Narrow" size="2">---</font></b></td>
							<td><xsl:value-of select="currentrunresults/overallstatus/total/passed"/></td>
							<td><xsl:value-of select="currentrunresults/overallstatus/total/failed"/></td>
						</tr>					
					</tbody>						
				</table>
			</div>
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>