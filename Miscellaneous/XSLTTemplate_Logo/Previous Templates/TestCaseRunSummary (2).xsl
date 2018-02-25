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
					background:#BFA2A2 url(body1.jpg);
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
					width:1300px;
					margin:0 auto;
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
					color:#000 !important;
					font-weight:normal;
				}		
			</style>	
			<title> SOAPUI Automation Test Result </title>
		</head>
		<body>
		
		<Table align= "center" border ="1" width="100%" BORDERCOLOR="#FFFFFF" CELLSPACING="0" CELLPADDING="5" STYLE='Font-Size:12pt Border-Colapse:Colapse'>
		<Thead BGCOLOR="#ADD8E6" STYLE='Font-Weight: Bold Color: #FFFFFF'>
			<TH><font color="BLUE" face="Arial Narrow" size="5">AUTOMATED SOAPUI TEST CASE RESULTS</font> </TH>
		</Thead>
	</Table>
	
			<div id="container"> 
				<div style="width:100%; margin:10px auto; height:80px;background:url(../../XSLTTemplate_Logo/logo.jpg);background-repeat: no-repeat;background-position: center;"></div>
				<br/>		  
		  
				<table class="tabClass">	
					<thead>
						<tr>
							<th>Test Case ID</th>
							<th>Test Case Description</th>
							<th>Module</th>
							<th>Service Call</th>
							<th>Test Case Type</th>
							<th>Status</th>
							<th>RQ-RS Data</th>
						</tr>
					</thead>
					<tbody>						
						<xsl:for-each select="testcasesummary/testcases/testcase">
						<tr>
							<td style="text-align: left;">
								<a target="about_blank">
									<xsl:attribute name="href"><xsl:value-of select="link1"/></xsl:attribute>
									<b><xsl:value-of select="id"/></b>
								</a>							
							</td>
							<td><xsl:value-of select="description"/></td>
							<td><xsl:value-of select="module"/></td>
							<td><xsl:value-of select="servicecall"/></td>
							<td><xsl:value-of select="type"/></td>
							<td>
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
							<td style="text-align: left;">
								<a target="about_blank">
									<xsl:attribute name="href"><xsl:value-of select="link2"/></xsl:attribute>
									<b><xsl:value-of select="rqrs"/></b>
								</a>							
							</td>
						</tr>
						</xsl:for-each>					
					</tbody>						
				</table>
				<table class="tabClass">
				<thead>
						<tr>
							<th>Passed</th>
							<th>Failed</th>
						</tr>
			    </thead>
				<tbody>	
					<tr>
						<td><xsl:value-of select="testcasesummary/summary/passed"/></td>
						<td><xsl:value-of select="testcasesummary/summary/failed"/></td>
					</tr>
				</tbody>
				</table>
			</div>
		</body>
	</html>
</xsl:template>

</xsl:stylesheet>