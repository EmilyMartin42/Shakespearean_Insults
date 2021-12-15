<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- plays -->
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../../markedPlays/finals/?select=*.xml')"/>

    <!-- variables -->
    <xsl:variable name="max-wide" as="xs:integer" select="500"/>
    <xsl:variable name="max-high" as="xs:integer" select="400"/>
    <xsl:variable name="y-scale" as="xs:integer" select="10"/>
    <xsl:variable name="spacing" as="xs:integer" select="50"/>


    <xsl:template name="xsl:initial-template">
        <svg viewBox="-75 100 1000 800" width="100%">
            <g transform="translate(100, {$max-wide + 200})">
                <!-- axes -->
                <line x1="50" x2="{$max-wide + 100}" y1="0" y2="0" stroke="#E0E0E0"/>
                <line x1="50" x2="50" y1="0" y2="-{$max-high + 50}" stroke="#E0E0E0"/>
                
                <!-- labels -->
                <text x="{($max-wide + 150)  div 2}" y="-500" stroke="#E0E0E0" fill="#E0E0E0" text-anchor="middle" font-size="20">
                    Flouted maxims and illocutionary act type</text>
                <text x="{($max-wide + 150)  div 2}" y="60" fill="#E0E0E0" stroke="#E0E0E0" font-size="16" text-anchor="middle">
                    Illocutionary act type</text>
                <text x="{($max-wide)  div 2}" y="-45" transform="rotate(-90)" stroke="#E0E0E0" fill="#E0E0E0" font-size="16" text-anchor="middle">
                    Maxim flouted</text>
                
                <!-- Cheating to make the lines and labels print right -->
                <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@maxim">
                    <xsl:variable name="y-pos" as="xs:double"
                        select="($spacing * 2) + (position() - 1) * ($spacing * 2)"/>
                    <xsl:for-each select=".">
                        <line x1="50" x2="{$max-wide + 100}" y1="-{$y-pos}" y2="-{$y-pos}"
                            stroke="#E0E0E0" stroke-dasharray="4"/>
                        <text x="40" y="-{$y-pos - 2}" stroke="#E0E0E0" fill="#E0E0E0"
                            text-anchor="end">
                            <xsl:value-of select="
                                if (current-grouping-key() = 'relev')  then 'relevance'
                                else if (current-grouping-key() = 'man')  then 'manner'
                                else if (current-grouping-key() = 'quant')  then 'quantity'
                                else 'quality'"/>
                        </text>
                    </xsl:for-each>
                </xsl:for-each-group>
                
                <!-- grouping by illoc-type, drawing some lines then subgrouping -->
                <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@illoc-type">
                    <xsl:variable name="x-pos" as="xs:double"
                        select="($spacing * 2 + 50) + (position() - 1) * ($spacing * 2)"/>
                    <xsl:for-each select=".">
                        <line x1="{$x-pos}" x2="{$x-pos}" y1="0" y2="-{$max-high + 50}"
                            stroke="#E0E0E0" stroke-dasharray="4"/>
                        <text x="{$x-pos}" y="20" stroke="#E0E0E0" fill="#E0E0E0"
                            text-anchor="middle">
                            <xsl:value-of select="current-grouping-key()"/>
                        </text>
                    </xsl:for-each>
                    
                    <!-- circles, subgroup of illoc-type, so the area is equal to the count of each intersection -->
                    <xsl:for-each-group select="current-group()" group-by="insultStart/@maxim">
                        <xsl:variable name="maxim" as="xs:string" select="current-grouping-key()"/>
                        <xsl:variable name="area" as="xs:double" select="count(current-group())"/>
                        <xsl:variable name="y-pos" as="xs:double"
                            select="($spacing * 2) + (position() - 1) * ($spacing * 2)"/>
                        <xsl:variable name="r" as="xs:double"
                            select="10 * math:sqrt($area div math:pi())"/>
                        <xsl:for-each select=".">
                            <circle cx="{$x-pos}" cy="-{$y-pos}"
                                r="{15 * math:sqrt($area div math:pi())}" fill="#5D81B9" opacity=".75"/>
                            <text x="{$x-pos}" y="-{$y-pos - 3}" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0" font-size="10">
                                <xsl:value-of select="$area"/></text>
                        </xsl:for-each>
                    </xsl:for-each-group>
                </xsl:for-each-group>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
