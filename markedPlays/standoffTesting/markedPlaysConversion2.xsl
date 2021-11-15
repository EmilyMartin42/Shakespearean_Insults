<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <start>
            <xsl:apply-templates select="//title"/>
            <xsl:apply-templates select="//body"/>
            <xsl:apply-templates select="//insultStart" mode="standOff"/>
        </start>  
    </xsl:template>
    <xsl:template match="insultStart" mode="standOff">
        <insult>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="following-sibling::w[not(preceding-sibling::insultEnd)]"/>
        </insult>
    </xsl:template>
</xsl:stylesheet>
