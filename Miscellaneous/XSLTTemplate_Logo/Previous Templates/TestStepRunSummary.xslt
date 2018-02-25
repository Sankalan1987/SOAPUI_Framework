<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <blockquote>
                <style type="text/css">
a:link {COLOR: #0000FF}a:visited {COLOR: #810541}a:hover {COLOR: #00FF00}a:active {COLOR: #0000FF}
</style>
                <head>
                    <title>SOAPUI Automation Test Result</title>
                    <script>
</script>
                </head>
                <body bgcolor="#FFFFFF">
                    <p align="center"/>
                    <table align="center" border="1"
                        bordercolor="#000000" bordercolorlight="#FFFFFF"
                        cellspacing="0" height="31" id="table1" width="1075">
                        <tr>
                            <td COLSPAN="6" bgcolor="#687C7D">
                                <p align="center">
                                    <font color="#FFFFFF"
                                    face="Copperplate Gothic Bold" size="4">Enterprise Car Share</font>
                                    <font face="Copperplate Gothic Bold"/>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td COLSPAN="6" bgcolor="#687C7D">
                                <p align="center">
                                    <b>
                                    <font color="#FFFFFF"
                                    face="Verdana" size="2">Test Step Results</font>
                                    </b>
                                </p>
                            </td>
                        </tr>
                    </table>
                    <!-- Table Header for Test Step Start-->
                    <table align="center" border="1"
                        bordercolor="#000000" bordercolorlight="#FFFFFF"
                        cellspacing="0" height="31" id="table1"
                        layout="fixed" width="1075">
                        <tr bgcolor="#687C7D">
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Data Set</font>
                                    </b>
                                </p>
                            </td>
                            <td width="75">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Step No</font>
                                    </b>
                                </p>
                            </td>
                            <td width="200">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Step Name</font>
                                    </b>
                                </p>
                            </td>
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Step Status</font>
                                    </b>
                                </p>
                            </td>
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Response Time</font>
                                    </b>
                                </p>
                            </td>
                            <td width="200">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Assertion Name</font>
                                    </b>
                                </p>
                            </td>
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Assertion Status</font>
                                    </b>
                                </p>
                            </td>
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Request XML</font>
                                    </b>
                                </p>
                            </td>
                            <td width="100">
                                <p align="center">
                                    <b>
                                    <font color="white"
                                    face="Arial Narrow" size="2">Response XML</font>
                                    </b>
                                </p>
                            </td>
                        </tr>
                        <tr>
					</tr>
                    </table>
                    <!-- Table Header for Test Step End-->
                    <!-- Step wise Iteration Start -->
                    <table align="center" border="1"
                        bordercolor="#000000" bordercolorlight="#FFFFFF"
                        cellspacing="0" height="31" id="table1"
                        layout="fixed" width="1075">
                        <xsl:for-each select="testcases/testcase">
                            <tr bgcolor="#EDEEF0">
                                <!-- 1st Column-->
                                <td width="100">
                                    <p align="center">
                                    <font face="Verdana" size="2">
                                    <xsl:value-of select="DS"/>
                                    </font>
                                    </p>
                                </td>
                                <!-- 2nd Column-->
                                <td width="975">
                                    <p align="center">
                                    <font face="Verdana" size="2">
                                    	</font>
                                    </p>
                                    <table align="center" border="1"
                                    bordercolor="#000000"
                                    bordercolorlight="#FFFFFF"
                                    cellspacing="0" height="31"
                                    id="table1" layout="fixed" width="975">
                                    <xsl:for-each select="teststeps/teststep">
                                    <tr>
                                    <!--2.1 Column-->
                                    <td width="75">
                                    <p align="center">
                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="stepno"/>
                                    </font>
                                    </p>
                                    </td>
                                    <!--2.2 Colunmn-->
                                    <td width="200">
                                    <p align="center">
                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="stepname"/>
                                    </font>
                                    </p>
                                    </td>
                                    <!--2.3 Colunmn-->
                                    <td width="100">
                                    <p align="center">
                                    <b>
                                    <xsl:choose>

                                    <xsl:when test="stepstatus='Pass'">

                                    <font
                                    color="#008000"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="stepstatus"/>
                                    </font>
                                    </xsl:when>

                                    <xsl:when test="stepstatus='Fail'">

                                    <font
                                    color="#FF0000"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="stepstatus"/>
                                    </font>
                                    </xsl:when>
                                    <xsl:otherwise>

                                    <font
                                    color="#8A4117"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="stepstatus"/>
                                    </font>
                                    </xsl:otherwise>
                                    </xsl:choose>
                                    </b>
                                    </p>
                                    </td>
                                    <!--2.4 Colunmn-->
                                    <td width="100">
                                    <p align="center">
                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="responsetime"/>
                                    </font>
                                    </p>
                                    </td>
                                    <!--2.5 Colunmn-->
                                    <td width="300">
                                    <p align="center">
                                    <font
                                    face="Verdana" size="2">
                                    <table
                                    align="center"
                                    border="1"
                                    bordercolor="#000000"
                                    bordercolorlight="#FFFFFF"
                                    cellspacing="0"
                                    height="31"
                                    id="table1"
                                    layout="fixed" width="300">

                                    <xsl:for-each select="assertions/Assertion">
                                    <tr>
                                    <!--2.5.1 Colunmn-->

                                    <td width="200">

                                    <p align="center">

                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="AssertionName"/>
                                    </font>
                                    </p>
                                    </td>
                                    <!--2.5.2 Colunmn-->

                                    <td width="100">

                                    <p align="center">
                                    <b>
                                    <xsl:choose>

                                    <xsl:when test="AssertionStatus='VALID'">

                                    <font
                                    color="#008000"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="AssertionStatus"/>
                                    </font>
                                    </xsl:when>

                                    <xsl:when test="AssertionStatus='FAILED'">

                                    <font
                                    color="#FF0000"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="AssertionStatus"/>
                                    </font>
                                    </xsl:when>
                                    <xsl:otherwise>

                                    <font
                                    color="#8A4117"
                                    face="Verdana" size="2">

                                    <xsl:value-of select="AssertionStatus"/>
                                    </font>
                                    </xsl:otherwise>
                                    </xsl:choose>
                                    </b>
                                    </p>
                                    </td>
                                    </tr>
                                    </xsl:for-each>
                                    </table>
                                    </font>
                                    </p>
                                    </td>
                                    <!--2.6 Colunmn-->
                                    <td width="100">
                                    <p align="center">
                                    <a target="about_blank">

                                    <xsl:attribute name="href">

                                    <xsl:value-of select="link1"/>
                                    </xsl:attribute>
                                    <b>
                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="rqxmlpath"/>
                                    </font>
                                    </b>
                                    </a>
                                    </p>
                                    </td>
                                    <!--2.7 Colunmn-->
                                    <td width="100">
                                    <p align="center">
                                    <a target="about_blank">

                                    <xsl:attribute name="href">

                                    <xsl:value-of select="link2"/>
                                    </xsl:attribute>
                                    <b>
                                    <font
                                    face="Verdana" size="2">

                                    <xsl:value-of select="rsxmlpath"/>
                                    </font>
                                    </b>
                                    </a>
                                    </p>
                                    </td>
                                    </tr>
                                    </xsl:for-each>
                                    </table>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </body>
            </blockquote>
        </html>
    </xsl:template>
</xsl:stylesheet>
