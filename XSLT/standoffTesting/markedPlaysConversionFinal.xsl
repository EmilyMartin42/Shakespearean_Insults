<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <start>
            <xsl:apply-templates select="//wordHoardHeader"/>
            <xsl:apply-templates select="//teiHeader"/>
            <xsl:apply-templates select="//text"/>
            <xsl:apply-templates select="//insultStart" mode="standOff"/>
        </start>
    </xsl:template>
    <xsl:template match="insultStart" mode="standOff">
        <insult>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates
                select="following-sibling::*[not(preceding-sibling::insultEnd) and not(self::insultEnd)]"/>
            <!-- The only idea I have left for this is to use "following" instead of "following-sibling" and ensuring that it only grabs words and punctuation. Although this would also grab lines with no insult starts or end tags methinks -->
        </insult>
    </xsl:template>
</xsl:stylesheet>
