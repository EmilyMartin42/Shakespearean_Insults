<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sha="http://insults.obdurodon.org"
    exclude-result-prefixes="xs" xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!-- Yes, this function is recursive. Yes, there is probably a better way to do this. 
        No, I don't care to spend 5 hours figuring it out. 
        Yes, you can add more punctuation marks as you need them. 
        Just add another iteration check and change the end case (make sure it's always negative one.)
        Yes, this function gets less efficient the more punctuation marks you add.-->
    <xsl:function name="sha:normalize" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:param name="iteration" as="xs:integer"/>
        <xsl:choose>
            <xsl:when test="$iteration = 1">
                <xsl:value-of select="sha:normalize(replace($input, ' ,', ','), ($iteration + 1))"/>
            </xsl:when>
            <xsl:when test="$iteration = 2">
                <xsl:value-of select="sha:normalize(replace($input, ' \.', '.'), ($iteration + 1))"
                />
            </xsl:when>
            <xsl:when test="$iteration = 3">
                <xsl:value-of select="sha:normalize(replace($input, ' !', '!'), -1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="replace($input, ' :', ':')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="/">
        <xsl:apply-templates select="//insult" mode="readView"/>
    </xsl:template>
    <xsl:template match="insult" mode="readView">
        <p>
            <xsl:attribute name="class"><xsl:value-of select="insultStart/@*"/></xsl:attribute>
            <xsl:apply-templates select="sha:normalize(normalize-space(.), 1)"/>
        </p>
    </xsl:template>
</xsl:stylesheet>
