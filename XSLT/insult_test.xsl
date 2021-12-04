<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="#all"
    version="3.0"> 
    <xsl:output method="xhtml" html-version="5" 
        omit-xml-declaration="no" 
        include-content-type="no"
        indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Insult Test</title>
            </head>
            <body>     
                <h2> 
                    <xsl:apply-templates select="//titleStmt/title"/>
                </h2>
                <xsl:text>There are: </xsl:text>
                <xsl:apply-templates select="count(//insult/insultStart[@gender='male-male'])"/>
                <xsl:text> insults where a man insults another man. Here is the break-down</xsl:text>
                <table border="1">
                    <tr>
                        <th>Insult Type</th>                       
                        <th>Speech Act Type</th>
                    </tr>
                <xsl:for-each select="//insult/insultStart[@gender='male-male']">
                    <xsl:sort select="@insType"/>
                    <tr>
                        <td>
                            <xsl:value-of select="@insType"/>                
                        </td>
                        
                        <td>
                            <xsl:value-of select="@speechAct"/>
                        </td>
                    </tr>   
                </xsl:for-each>                   
                </table> 
                <br/>
                <xsl:text>There are </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='direct' and @gender='male-male'])"/>
                <xsl:text> direct male-male insults and </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='indirect' and @gender='male-male'])"/>
                <xsl:text> indirect insults.</xsl:text>
                <br/>
                <hr/>
                <br/>
                <xsl:text>There are: </xsl:text>
                <xsl:apply-templates select="count(//insult/insultStart[@gender='male-female'])"/>
                <xsl:text> insults where a man insults a woman. Here is the break-down</xsl:text>
                <br/>
                <table border="1">
                    <tr>
                        <th>Insult Type</th>                       
                        <th>Speech Act Type</th>
                    </tr>
                    <xsl:for-each select="//insult/insultStart[@gender='male-female']">
                        <xsl:sort select="@insType"/>
                        <tr>
                            <td>
                                <xsl:value-of select="@insType"/>                
                            </td>
                            
                            <td>
                                <xsl:value-of select="@speechAct"/>
                            </td>
                        </tr>   
                    </xsl:for-each>                   
                </table> 
                <br/>
                <xsl:text>There are </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='direct' and @gender='male-female'])"/>
                <xsl:text> direct male-female insults and </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='indirect' and @gender='male-female'])"/>
                <xsl:text> indirect insults.</xsl:text>
                <br/>
                <hr/>
                <br/>
                <xsl:text>There are: </xsl:text>
                <xsl:apply-templates select="count(//insult/insultStart[@gender='female-female'])"/>
                <xsl:text> insults where a woman insults another woman. Here is the break-down</xsl:text>
                <br/>
                <table border="1">
                    <tr>
                        <th>Insult Type</th>                       
                        <th>Speech Act Type</th>
                    </tr>
                    <xsl:for-each select="//insult/insultStart[@gender='female-female']">
                        <xsl:sort select="@insType"/>
                        <tr>
                            <td>
                                <xsl:value-of select="@insType"/>                
                            </td>
                            
                            <td>
                                <xsl:value-of select="@speechAct"/>
                            </td>
                        </tr>   
                    </xsl:for-each>                   
                </table> 
                <br/>
                <xsl:text>There are </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='direct' and @gender='female-female'])"/>
                <xsl:text> direct female-female insults and </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='indirect' and @gender='female-female'])"/>
                <xsl:text> indirect insults.</xsl:text>
                <br/>
                <hr/>
                <br/>
                <xsl:text>There are: </xsl:text>
                <xsl:apply-templates select="count(//insult/insultStart[@gender='female-male'])"/>
                <xsl:text> insults where a woman insults a man. Here is the break-down</xsl:text>
                <br/>
                <table border="1">
                    <tr>
                        <th>Insult Type</th>                       
                        <th>Speech Act Type</th>
                    </tr>
                    <xsl:for-each select="//insult/insultStart[@gender='female-male']">
                        <xsl:sort select="@insType"/>
                        <tr>
                            <td>
                                <xsl:value-of select="@insType"/>                
                            </td>
                            
                            <td>
                                <xsl:value-of select="@speechAct"/>
                            </td>
                        </tr>   
                    </xsl:for-each>                   
                </table> 
                <br/>
                <xsl:text>There are </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='direct' and @gender='female-male'])"/>
                <xsl:text> direct female-male insults and </xsl:text>
                <xsl:value-of select="count(//insult/insultStart[@speechAct='indirect' and @gender='female-male'])"/>
                <xsl:text> indirect insults.</xsl:text>
                <br/>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>