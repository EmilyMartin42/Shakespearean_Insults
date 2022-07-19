<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all" version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <!-- Variable for all the plays -->
    <xsl:variable name="all_plays" as="document-node()+" select="collection('../../markedPlays/finals/?select=*.xml')"/>

    <!-- Other variables -->
    <xsl:variable name="bar-wide" as="xs:integer" select="100"/>
    <xsl:variable name="space" as="xs:integer" select="$bar-wide div 2"/>
    <xsl:variable name="max-wide" as="xs:integer" select="($bar-wide + $space) * count(distinct-values($all_plays//@speechAct))"/>
    <xsl:variable name="y-scale" as="xs:integer" select="4"/>
    <xsl:variable name="max-high" as="xs:integer" select="$y-scale * 80"/>

    <xsl:template name="xsl:initial-template">
        <xsl:result-document href="../../webContent/images/genderXspeechAct.svg">
            <svg viewBox="50 0 1000 1100" width="100%" class="speech_acts">
                <!-- Group by gender -->
                <xsl:apply-templates select="$all_plays//insultStart[@gender = 'male-male']"/>
                <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@gender">
                    <xsl:variable name="currentGroup" as="xs:string" select="current-grouping-key()"/>
                    <xsl:variable name="gen_count" as="xs:integer" select="count(current-group())"/>
                    <!-- variables to shift each graph according to group -->
                    <xsl:variable name="yshift" as="xs:double" select="
                    if (current-grouping-key() = 'male-male') then
                    1
                    else
                    if (current-grouping-key() = 'female-female') then
                    1
                    else
                    2"/>
                    <xsl:variable name="xshift" as="xs:double" select="
                    if (current-grouping-key() = 'male-male') then
                    0
                    else
                    if (current-grouping-key() = 'female-male') then
                    0
                    else
                    1.25"/>

                    <g transform="translate({50 + $max-wide * $xshift}, {($max-high + 200) * $yshift})">
                        <!-- axis -->
                        <line x1="50" x2="{$max-wide}" y1="0" y2="0" stroke="#E0E0E0"/>
                        <line x1="50" x2="50" y1="0" y2="-{$max-high + 20}" stroke="#E0E0E0"/>
                        <!-- scale markers -->
                        <xsl:for-each select="(1 to ($max-high div 40))">
                            <line x1="50" y1="-{. * $y-scale * 10}" x2="{$max-wide}" y2="-{. * $y-scale * 10}" stroke="#E0E0E0" stroke-dasharray="3"/>
                            <text x="25" y="-{. * ($y-scale * 10) - 5}" stroke="#E0E0E0" fill="#E0E0E0">
                                <xsl:value-of select=". * 10"/>
                            </text>
                        </xsl:for-each>

                        <!-- labels -->
                        <text x="{($max-wide div 2) + 25}" y="-{$max-high + 80}" font-size="18" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0">
                        Speech act counts between <xsl:value-of select="current-grouping-key()" />
                        </text>
                        <text x="{$max-high div 2}" y="15" transform="rotate(-90)" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0">Speech act count</text>
                        <text x="{$max-wide div 2}" y="45" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0">Speech act type</text>

                        <!-- sub-group by speech act -->
                        <xsl:for-each-group select="current-group()" group-by="insultStart/@speechAct">
                            <xsl:sort select="current-grouping-key()"/>
                            <xsl:variable name="sA-type" select="current-grouping-key()"/>
                            <xsl:variable name="sA-count" as="xs:integer" select="count(current-group())"/>
                            <xsl:variable name="x-pos" as="xs:double" select="($space * 2) + (position() - 1) * ($bar-wide + $space)"/>
                            <xsl:variable name="color" as="xs:string" select="
                            if (current-grouping-key() = ('direct')) then
                            '#870C1D'
                            else
                            '#5D81B9'"/>

                            <xsl:for-each select=".">
                                <rect x="{$x-pos}" y="-{$sA-count * $y-scale}" width="{$bar-wide}" height="{$sA-count * $y-scale}" fill="{$color}"/>
                                <text x="{$x-pos + $bar-wide div 2}" y="{$max-high div 15}" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </text>
                                <text x="{$x-pos + $bar-wide div 2}" y="-{$sA-count * $y-scale + 5}" text-anchor="middle" stroke="#E0E0E0" fill="#E0E0E0">
                                    <xsl:value-of select="$sA-count"/>
                                </text>

                            </xsl:for-each>
                        </xsl:for-each-group>
                    </g>
                </xsl:for-each-group>
            </svg>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
