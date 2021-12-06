<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- Variable for all the plays -->
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../../markedPlays/finals/?select=*.xml')"/>
    <!-- Other variables -->
    <xsl:variable name="bar-wide" as="xs:integer" select="100"/>
    <xsl:variable name="space" as="xs:integer" select="$bar-wide div 2"/>
    <xsl:variable name="max-wide" as="xs:integer"
        select="($bar-wide + $space) * count(distinct-values($all_plays//@speechAct))"/>
    <xsl:variable name="y-scale" as="xs:integer" select="4"/>
    <xsl:variable name="max-high" as="xs:integer" select="$y-scale * 80"/>
    
    
    <xsl:template name="xsl:initial-template">
        <svg height="1000" width="1000">
            <xsl:apply-templates select="$all_plays//insultStart[@gender = 'male-male']"/>
            <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@gender">
                <xsl:variable name="currentGroup" as="xs:string" select="current-grouping-key()"/>
                <xsl:variable name="gen_count" as="xs:integer" select="count(current-group())"/>
                <xsl:variable name="yshift" as="xs:integer" select="
                    if (current-grouping-key() = 'male-male') then
                    1
                    else
                    if (current-grouping-key() = 'female-female') then
                    1
                    else
                    2"/>
                <xsl:variable name="xshift" as="xs:integer" select="
                    if (current-grouping-key() = 'male-male') then
                    0
                    else
                    if (current-grouping-key() = 'female-male') then
                    0
                    else
                    1"/>
                <!--<p>
                        
                        <xsl:value-of select="$currentGroup"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="$gen_count"/>
                    </p>-->
                <g transform="translate({50 + $max-wide * $xshift}, {($max-high + 200) * $yshift})">
                    <!-- axis -->
                    <line x1="50" x2="{$max-wide}" y1="0" y2="0" stroke="black"/>
                    <line x1="50" x2="50" y1="0" y2="-{$max-high + 20}" stroke="black"/>
                    <!-- scale markers -->
                    <xsl:for-each select="(1 to ($max-high div 40))">
                        <line x1="50" y1="-{. * $y-scale * 10}" x2="{$max-wide}"
                            y2="-{. * $y-scale * 10}" stroke="black" stroke-dasharray="3"/>
                        <text x="25" y="-{. * ($y-scale * 10) - 5}">
                            <xsl:value-of select=". * 10"/>
                        </text>
                    </xsl:for-each>
                    
                    <!-- labels -->
                    <text x="75" y="-{$max-high + 130}" font-size="18">Direct vs. Indirect insult
                        counts between male speakers</text>
                    <text x="{$max-high div 2}" y="15" transform="rotate(-90)">Insult count</text>
                    <text x="{$max-wide div 2}" y="45">Speech act type</text>
                    <xsl:for-each-group select="current-group()" group-by="insultStart/@speechAct">
                        <xsl:sort select="current-grouping-key()"/>
                        <xsl:variable name="sA-type" select="current-grouping-key()"/>
                        <xsl:variable name="sA-count" as="xs:integer"
                            select="count(current-group())"/>
                        <xsl:variable name="x-pos" as="xs:double"
                            select="($space * 2) + (position() - 1) * ($bar-wide + $space)"/>
                        <xsl:variable name="color" as="xs:string" select="
                            if (current-grouping-key() = ('direct')) then
                            '#D912F8'
                            else
                            '#12E6F8'"/>
                        
                        <xsl:for-each select=".">
                            <rect x="{$x-pos}" y="-{$sA-count * $y-scale}" width="{$bar-wide}"
                                height="{$sA-count * $y-scale}" fill="{$color}"/>
                            <text x="{$x-pos}" y="-{$max-high}">
                                <xsl:value-of select="current-grouping-key()"/>
                            </text>
                            <!--<xsl:value-of select="$sA-type"/>
                                <xsl:text>: </xsl:text>
                                <xsl:value-of select="$sA-count"/>-->
                        </xsl:for-each>
                        
                    </xsl:for-each-group>
                </g>
            </xsl:for-each-group>
        </svg>
    </xsl:template>
    <!-- <xsl:template match="insultStart[@gender='male-male']">
         <xsl:variable name="direct" as="xs:double" select="count($all_plays//insult/insultStart[@speechAct='direct' and @gender='male-male'])"/>
         <xsl:variable name="indirect" as="xs:double" select="count($all_plays//insult/insultStart[@speechAct='indirect' and @gender='male-male'])"/>
         
         <!-\- bars  -\->
         <rect x="100" y="-{$indirect * $y-scale}" width="{$bar-wide}" height="{$indirect * $y-scale}" fill="green"/>
         <rect x="250" y="-{$direct * $y-scale}" width="{$bar-wide}" height="{$direct * $y-scale}" fill="blue"/>
         <!-\- bar labels -\->
         <text x="125" y="20">Indirect</text>
         <text x="280" y="20">Direct</text>
     </xsl:template> -->
    
    
</xsl:stylesheet>