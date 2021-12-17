<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- set a variable for all the plays so this can be run on all of them -->
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../../markedPlays/finals/?select=*.xml')"/>

    <xsl:variable name="barWidth" as="xs:integer" select="75"/>
    <xsl:variable name="barSpacing" as="xs:float" select="$barWidth div 2"/>
    <xsl:variable name="relCount" as="xs:integer"
        select="count(distinct-values($all_plays//insult/insultStart/@rel))"/>
    <xsl:variable name="xLength" as="xs:float" select="$relCount * ($barWidth + $barSpacing)"/>
    <xsl:variable name="yScale" as="xs:integer" select="400"/>
    <xsl:variable name="insults" as="element()*" select="//insults"/>

    <xsl:template name="xsl:initial-template">
        <svg width="150%" height="150%">
            <g transform="translate(200, 500)">
                <xsl:apply-templates select="$all_plays//insults" mode="insType"/>
                <!-- ==================== AXES BELOW ==================== -->
                <g>
                    <text x="{$xLength div 2 - 150}" y="-{$yScale + 25}" font-weight="bold">States
                        of Relationship Based on Different Relationships</text>
                    <text x="{$xLength div 2 - 125}" y="{50}" font-weight="bold">Relationship
                        between speaker and hearer.</text>
                    <text x="200" y="-75" transform="rotate(-90)" font-weight="bold">% of
                        insults</text>
                    <!-- I have no idea how to center text -->
                    <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black"/>
                    <line x1="0" y1="0" x2="0" y2="-{$yScale}" stroke="black"/>
                    <xsl:for-each select="(1 to ($yScale div 100))">
                        <line x1="0" y1="-{. * 100}" x2="{$xLength}" y2="-{. * 100}" stroke="black"
                            stroke-dasharray="3"/>
                        <text x="-45" y="-{. * 100 - 5}"><xsl:value-of select=". * 25"/>%</text>
                    </xsl:for-each>
                    <!-- ==================== LEGEND BELOW ==================== -->
                    <g>
                        <rect x="{$xLength + 20}" y="-{$yScale div 4}" height="15" width="15"
                            fill="green"/>
                        <text x="{$xLength + 45}" y="-{$yScale div 4 - 12.5}">Positive Relationship
                            State</text>
                        <rect x="{$xLength + 20}" y="-{$yScale div 4 * 2}" height="15" width="15"
                            fill="gray"/>
                        <text x="{$xLength + 45}" y="-{$yScale div 4 * 2 - 12.5}">Neutral
                            Relationship State</text>
                        <rect x="{$xLength + 20}" y="-{$yScale div 4 * 3}" height="15" width="15"
                            fill="red"/>
                        <text x="{$xLength + 45}" y="-{$yScale div 4 * 3 - 12.5}">Negative
                            Relationship State</text>
                    </g>
                </g>
            </g>
        </svg>
    </xsl:template>

    <!-- This code is not optimized at all, I am aware, but it is a working solution and we'll leave it at that. This is already the product of multiple hours. -->
    <xsl:template match="insults" mode="insType">
        <g transform="translate({$barSpacing}, 0)">
            <xsl:for-each-group select="$insults/insult" group-by="insultStart/@rel">
                <xsl:variable name="curRel" as="xs:string" select="current-grouping-key()"/>
                <xsl:variable name="curTotal" as="xs:integer" select="count(current-group())"/>
                <xsl:variable name="current" as="xs:integer" select="position()"/>
                <xsl:for-each-group select="insultStart" group-by="@rel-state">
                    <xsl:variable name="curState" as="xs:string" select="current-grouping-key()"/>
                    <xsl:variable name="stateTotal" select="count(current-group())"/>
                    <xsl:variable name="height" as="xs:float"
                        select="($stateTotal div $curTotal * $yScale)"/>
                    <xsl:variable name="color" as="xs:string" select="
                            if (current-grouping-key() = 'pos') then
                                'green'
                            else
                            if (current-grouping-key() = 'neg') then
                                    'red'
                                else
                                    'grey'
                            "/>
                    <text x="{($current - 1) * ($barWidth + $barSpacing)}" y="{position() * 20 + 75}"><xsl:value-of select="$stateTotal"/></text>
                    <text x="{($current - 1) * ($barWidth + $barSpacing)}" y="150"><xsl:value-of select="$curTotal"/></text>
                    <rect x="{($current - 1) * ($barWidth + $barSpacing)}" y="-{$height}"
                        height="{$height}" width="{$barWidth}" fill="{$color}"/>
                </xsl:for-each-group>
            </xsl:for-each-group>
        </g>
    </xsl:template>
</xsl:stylesheet>
