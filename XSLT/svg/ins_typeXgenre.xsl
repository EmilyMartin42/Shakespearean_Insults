<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- plays -->
    <xsl:variable name="tragedies" as="document-node()+"
        select="doc('../../markedPlays/finals/hamFinal.xml'), doc('../../markedPlays/finals/othFinal.xml')"/>
    <xsl:variable name="comedies" as="document-node()+"
        select="doc('../../markedPlays/finals/comFinal.xml'), doc('../../markedPlays/finals/mndFinal.xml')"/>
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../../markedPlays/finals/?select=*.xml')"/>


    <!-- Variables -->
    <xsl:variable name="bar-wide" as="xs:integer" select="40"/>
    <xsl:variable name="space" as="xs:integer" select="$bar-wide div 2"/>
    <xsl:variable name="max-wide" as="xs:integer" select="1100"/>
    <xsl:variable name="y-scale" as="xs:integer" select="4"/>
    <xsl:variable name="x-scale" as="xs:integer" select="10"/>
    <xsl:variable name="max-high" as="xs:integer"
        select="($bar-wide + $space) * count(distinct-values($all_plays//@insType))"/>
    <xsl:variable name="mid" as="xs:integer" select="($max-wide div 2) + 25"/>
  

    <xsl:template name="xsl:initial-template">
        <svg height="{$max-high + 200}" width="{$max-wide + 350}">
            <g transform="translate(150, {$max-high + 100})">
                <!-- axes-->
                <line x1="50" x2="{$max-wide}" y1="0" y2="0" stroke="#E0E0E0"/>
                <line x1="50" x2="{$max-wide}" y1="-{$max-high}" y2="-{$max-high}" stroke="#E0E0E0"/>
                <line x1="50" x2="50" y1="0" y2="-{$max-high}" stroke="#E0E0E0"/>
                <line x1="{$max-wide}" x2="{$max-wide}" y1="0" y2="-{$max-high}" stroke="#E0E0E0"/>
                <line x1="{$mid}" x2="{$mid}" y1="0" y2="-{$max-high}"
                    stroke="#E0E0E0"/>
                
                <!-- labels -->
                <text x="{$mid}" y="-{$max-high + 60}" stroke="#E0E0E0" font-size="22" fill="#E0E0E0" text-anchor="middle">Insult type counts by genre</text>
                <text x="{$mid div 2}" y="-{$max-high + 30}" stroke="#E0E0E0" fill="#E0E0E0" text-anchor="middle">Tragedies</text>
                <text x="{$mid + $mid div 2}" y="-{$max-high + 30}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">Comedies</text>

                <!-- scale markers, probably shouldn't be hardcoded but I was having trouble making them mirror images without -->
                <!-- comedies -->
                <line x1="{$mid}" y1="0" x2="{$mid}" y2="-{$max-high}"/>
                <text x="{$mid}" y="-{$max-high + 5}" stroke="#E0E0E0" text-anchor="middle">0</text>
                <line x1="{$mid + 100}" y1="0" x2="{$mid + 100}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid + 100}" y="-{$max-high + 5}" stroke="#E0E0E0"  fill ="#E0E0E0" text-anchor="middle">10</text>
                <line x1="{$mid + 200}" y1="0" x2="{$mid + 200}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid + 200}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">20</text>
                <line x1="{$mid + 300}" y1="0" x2="{$mid + 300}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid + 300}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">30</text>
                <line x1="{$mid + 400}" y1="0" x2="{$mid + 400}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid + 400}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">40</text>
                <line x1="{$mid + 500}" y1="0" x2="{$mid + 500}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid + 500}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">50</text>
                
                <!-- tragedies -->
                <line x1="{$mid - 100}" y1="0" x2="{$mid - 100}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid - 100}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">10</text>
                <line x1="{$mid - 200}" y1="0" x2="{$mid - 200}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid - 200}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">20</text>
                <line x1="{$mid - 300}" y1="0" x2="{$mid - 300}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid - 300}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">30</text>
                <line x1="{$mid - 400}" y1="0" x2="{$mid - 400}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid - 400}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">40</text>
                <line x1="{$mid - 500}" y1="0" x2="{$mid - 500}" y2="-{$max-high}" stroke="#E0E0E0" stroke-dasharray="3"/>
                <text x="{$mid - 500}" y="-{$max-high + 5}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">50</text>

                <!-- bars -->
                <xsl:for-each-group select="$comedies//insult" group-by="insultStart/@insType">
                    <xsl:sort select="count(current-group())"/>
                    <xsl:variable name="count" as="xs:integer" select="count(current-group())"/>
                    <xsl:variable name="com_types" as="xs:string" select="current-grouping-key()"/>
                    <xsl:variable name="y-pos" as="xs:integer" select="
                            ($space * 4) + (position() - 1) * ($bar-wide + $space)"/>
                    <rect x="{$mid}" y="-{$y-pos}" height="{$bar-wide}"
                        width="{$count * $x-scale}" fill="red"/>
                    <!--<text x="{($max-wide div 2) + ($count * $x-scale) + 35}" y="-{$y-pos - 25}" text-anchor="beginning">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>-->
                    <text x="{$max-wide + 10}" y="-{$y-pos - 25}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="beginning">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>
                    <text x="40" y="-{$y-pos - 25}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="end">
                        <xsl:value-of select="current-grouping-key()"/>
                    </text>
                    <text x="{($max-wide div 2) + ($count * $x-scale) + 35}" y="-{$y-pos - 25}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="middle">
                        <xsl:value-of select="count(current-group())"/>
                    </text>
                    
                    <xsl:for-each-group select="$tragedies//insult" group-by="insultStart/@insType">
                        <xsl:variable name="tcount" as="xs:integer" select="
                            if ($com_types != current-grouping-key()) then 0
                            else count(current-group())"/>
                        <rect x="{$mid - ($tcount * $x-scale)}" y="-{$y-pos}" height="{$bar-wide}"
                            width="{$tcount * $x-scale}" fill="green"/>
                        <text x="{$mid - ($tcount * $x-scale) - 5}" y="-{$y-pos - 25}" stroke="#E0E0E0" fill ="#E0E0E0" text-anchor="end">
                            <xsl:value-of select="$tcount"/>
                        </text>
                    </xsl:for-each-group>
                </xsl:for-each-group>
                
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
