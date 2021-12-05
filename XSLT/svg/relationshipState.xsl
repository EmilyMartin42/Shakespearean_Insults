<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg" version="3.0">
    <xsl:output method="xml" indent="yes"/>
    <!-- An attempt to run this on all the plays -->
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../../markedPlays/finals/?select=*.xml')"/>

    <xsl:variable name="barWidth" as="xs:integer" select="100"/>
    <xsl:variable name="barSpacing" as="xs:float" select="$barWidth div 2"/>
    <xsl:variable name="relCount" as="xs:integer"
        select="count(distinct-values($all_plays//insult/insultStart/@rel))"/>
    <xsl:variable name="xLength" as="xs:float" select="$relCount * ($barWidth + $barSpacing)"/>
    <xsl:variable name="yScale" as="xs:integer" select="400"/>
    <xsl:variable name="insults" as="element()*" select="$all_plays//insults"/>

    <xsl:template name="xsl:initial-template">
     <!--   <xsl:template match="$all_plays"> -->
            <svg width="1000%" height="1000%">
                <g transform="translate(200, 500)">
                    <xsl:apply-templates select="$all_plays//insults" mode="insType"/>
                    <!-- ==================== AXES BELOW ==================== -->
                    <g>
                        <text x="{$xLength div 2 - 150}" y="-{$yScale + 25}" font-weight="bold"
                            >States of Relationship Based on Different Relationships</text>
                        <text x="{$xLength div 2 - 125}" y="{50}" font-weight="bold">Relationship
                            between perpatrator and victim.</text>
                        <text x="200" y="-75" transform="rotate(-90)" font-weight="bold">% of
                            insults</text>
                        <!-- I have no idea how to center text -->
                        <line x1="0" y1="0" x2="{$xLength}" y2="0" stroke="black"/>
                        <line x1="0" y1="0" x2="0" y2="-{$yScale}" stroke="black"/>
                        <xsl:for-each select="(1 to ($yScale div 100))">
                            <line x1="0" y1="-{. * 100}" x2="{$xLength}" y2="-{. * 100}"
                                stroke="black" stroke-dasharray="3"/>
                            <text x="-45" y="-{. * 100 - 5}"><xsl:value-of select=". * 25"/>%</text>
                        </xsl:for-each>
                        <!-- ==================== LEGEND BELOW ==================== -->
                        <g>
                            <rect x="{$xLength + 20}" y="-{$yScale div 4}" height="15" width="15"
                                fill="green"/>
                            <text x="{$xLength + 45}" y="-{$yScale div 4 - 12.5}">Positive
                                Relationship State</text>
                            <rect x="{$xLength + 20}" y="-{$yScale div 4 * 2}" height="15"
                                width="15" fill="gray"/>
                            <text x="{$xLength + 45}" y="-{$yScale div 4 * 2 - 12.5}">Neutral
                                Relationship State</text>
                            <rect x="{$xLength + 20}" y="-{$yScale div 4 * 3}" height="15"
                                width="15" fill="red"/>
                            <text x="{$xLength + 45}" y="-{$yScale div 4 * 3 - 12.5}">Negative
                                Relationship State</text>
                        </g>
                    </g>
                </g>
            </svg>
        </xsl:template>
    
    <!-- This code is not optimized at all, I am aware, but it is a working solution and we'll leave it at that. This is already the product of multiple hours. -->
    <xsl:template match="$all_plays//insults" mode="insType">
        <xsl:variable name="insultTotal" as="xs:integer" select="count(insult/insultStart)"/>
        <g transform="translate({$barSpacing}, 0)">
            <xsl:for-each select="1 to $relCount">
                <xsl:variable name="i" as="xs:integer" select="."/>
                <xsl:variable name="relType" as="xs:string"
                    select="distinct-values($insults/insult/insultStart/@rel)[$i]"/>
                <xsl:variable name="curTotal" as="xs:integer"
                    select="count($insults/insult/insultStart[@rel = $relType])"/>
                <xsl:variable name="posTotal" as="xs:integer"
                    select="count($insults/insult/insultStart[@rel = $relType and @rel-state = 'pos'])"/>
                <xsl:variable name="posHeight" as="xs:float"
                    select="($posTotal div $curTotal * $yScale)"/>
                <xsl:variable name="neutralTotal" as="xs:integer"
                    select="count($insults/insult/insultStart[@rel = $relType and @rel-state = 'neutral'])"/>
                <xsl:variable name="neutralHeight" as="xs:float"
                    select="($neutralTotal div $curTotal * $yScale)"/>
                <xsl:variable name="negTotal" as="xs:integer"
                    select="count($insults/insult/insultStart[@rel = $relType and @rel-state = 'neg'])"/>
                <xsl:variable name="negHeight" as="xs:float"
                    select="($negTotal div $curTotal * $yScale)"/>
                <rect x="{($i - 1) * ($barWidth + $barSpacing)}" y="-{$posHeight}"
                    height="{$posHeight}" width="{$barWidth}" fill="green"/>
                <rect x="{($i - 1) * ($barWidth + $barSpacing)}" y="-{$neutralHeight + $posHeight}"
                    height="{$neutralHeight}" width="{$barWidth}" fill="gray"/>
                <rect x="{($i - 1) * ($barWidth + $barSpacing)}"
                    y="-{$negHeight + $posHeight + $neutralHeight}" height="{$negHeight}"
                    width="{$barWidth}" fill="crimson"/>
                <text x="{($i - 1) * ($barWidth + $barSpacing)}" y="25">
                    <xsl:value-of select="$relType"/>
                </text>
            </xsl:for-each>
        </g>
    </xsl:template>
</xsl:stylesheet>
