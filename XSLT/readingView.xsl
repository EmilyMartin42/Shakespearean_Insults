<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:sha="http://insults.obdurodon.org" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no" indent="yes"/>
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>
                    <xsl:value-of select="//titleStmt/title"/>
 Reading View</title>
                <link rel="stylesheet" type="text/css" href="CSS/index.css"/>
            </head>
            <body class="corp">
                <xsl:comment>#include virtual="menu.xhtml"</xsl:comment>
                <div class="pagination">
                    <xsl:choose>
                        <xsl:when test="//titleStmt/shortTitle = 'Hamlet'">
                            <a class="active" href="hamReading.xhtml">Hamlet</a>
                            <a href="othReading.xhtml">Othello</a>
                            <a href="mndReading.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeReading.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Othello'">
                            <a href="hamReading.xhtml">Hamlet</a>
                            <a class="active" href="othReading.xhtml">Othello</a>
                            <a href="mndReading.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeReading.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Midsummer Nights Dream'">
                            <a href="hamReading.xhtml">Hamlet</a>
                            <a href="othReading.xhtml">Othello</a>
                            <a class="active" href="mndReading.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeReading.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Comedy of Errors'">
                            <a href="hamReading.xhtml">Hamlet</a>
                            <a href="othReading.xhtml">Othello</a>
                            <a href="mndReading.xhtml">A Midsummer Night's Dream</a>
                            <a class="active" href="coeReading.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                    </xsl:choose>
                </div>
                <h1 id="mainTitle">
                    <xsl:value-of select="//titleStmt/title"/>
                </h1>
                <xsl:apply-templates select="//body/div/div/*[name() ne 'wordHoardHeader']"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="head">
        <h2 class="actHead">
            <xsl:value-of select="."/>
        </h2>
    </xsl:template>
    <xsl:template match="stage">
        <p class="stage">
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    <xsl:template match="sp">
        <div class="speech">
            <h3 class="speaker">
                <xsl:value-of select="speaker"/>
            </h3>
            <xsl:apply-templates select="wordHoardTaggedLine"/>
            <xsl:apply-templates select="wordHoardTaggedLine/stage"/>
        </div>
    </xsl:template>
    <xsl:template match="wordHoardTaggedLine">
        <p>
            <xsl:if test=".[child::node()/name() = ('insultStart', 'insultEnd')]">
                <xsl:attribute name="class">
                    <xsl:text>textInsult</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="string-join(node()[name() ne 'stage']) => normalize-space() => replace(' ([.,:;?!])', '$1')"/>
        </p>
    </xsl:template>
</xsl:stylesheet>