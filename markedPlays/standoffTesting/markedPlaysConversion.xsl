<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <start>
        <xsl:apply-templates select="//title"/>
        <xsl:apply-templates select="//body"/>
            <xsl:copy-of select="//insultStart"/>
        <xsl:copy-of select="//insultStart/following-sibling::w[not(preceding-sibling::insultEnd)]"/>
            <!-- ^ This doesn't span multiple lines. Find a way to grab all w's with following 
                insultEnd children as they are also part of insults. There is another problem
            with this that I can't quite explain with words, so run the output on the test XML
            and see for yourself what I mean. Check at the end of the document-->
        </start>
    </xsl:template>
    <xsl:template match="start/insultStart"> 
        <!-- ^ Doesn't do anything because it isn't part of the original document. 
        Two part transformation?-->
        <insult>
            <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="following-sibling::w"/>
        </insult>
    </xsl:template>
</xsl:stylesheet>