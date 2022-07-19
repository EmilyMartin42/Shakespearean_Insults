<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="#all" version="3.0">
    <!-- =============================================================== -->
    <!--                                                                 -->
    <!-- For future reference:                                           -->
    <!--   I find it easiest to draw a butterfly chart directly in the   -->
    <!--     lower right, instead of drawing in the upper right and      -->
    <!--     shifting down                                               -->
    <!--   I also find it easiest to put the midpoint at X = 0, draw in  -->
    <!--     both negative and positive X space, and then shift right    -->
    <!-- =============================================================== -->
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <!-- plays -->
    <xsl:variable name="tragedies" as="document-node()+" select="doc('../../markedPlays/finals/hamFinal.xml'), doc('../../markedPlays/finals/othFinal.xml')"/>
    <xsl:variable name="comedies" as="document-node()+" select="doc('../../markedPlays/finals/comFinal.xml'), doc('../../markedPlays/finals/mndFinal.xml')"/>
    <xsl:variable name="all-plays" as="document-node()+" select="$tragedies | $comedies"/>


    <!-- Variables -->
    <xsl:variable name="bar-wide" as="xs:integer" select="40"/>
    <xsl:variable name="space" as="xs:integer" select="$bar-wide div 2"/>
    <xsl:variable name="max-wide" as="xs:integer" select="(count($all-plays//insultStart[@insType='nameCall']) * $x-scale) + 60"/>
    <xsl:variable name="y-scale" as="xs:integer" select="4"/>
    <xsl:variable name="x-scale" as="xs:integer" select="10"/>
    <xsl:variable name="distinct-insult-types" as="xs:string+" select="$all-plays//@insType => distinct-values()"/>
    <xsl:variable name="max-high" as="xs:integer" select="($bar-wide + $space) * count($distinct-insult-types)"/>
    <xsl:variable name="mid" as="xs:integer" select="($max-wide div 2)"/>
    <xsl:variable name="ruling-color" as="xs:string" select="'#E0E0E0'"/>

    <xsl:template name="xsl:initial-template">
        <xsl:result-document href="../../webContent/images/ins_typeXgenre.svg">
            <svg viewBox="-100 0 2100 1000" width="100%">
                <g transform="translate(150, {$max-high + 100})">
                    <!-- axes-->
                    <line x1="0" x2="{$max-wide}" y1="0" y2="0" stroke="{$ruling-color}"/>
                    <line x1="0" x2="{$max-wide}" y1="-{$max-high}" y2="-{$max-high}" stroke="{$ruling-color}"/>
                    <line x1="0" x2="0" y1="0" y2="-{$max-high}" stroke="{$ruling-color}"/>
                    <line x1="{$max-wide}" x2="{$max-wide}" y1="0" y2="-{$max-high}" stroke="{$ruling-color}"/>
                    <line x1="{$mid}" x2="{$mid}" y1="0" y2="-{$max-high}" stroke="{$ruling-color}"/>

                    <!-- labels -->
                    <text x="{$mid}" y="-{$max-high + 60}" fill="{$ruling-color}" font-size="22" text-anchor="middle">Insult type counts by genre</text>
                    <text x="{$mid div 2}" y="-{$max-high + 30}" fill="{$ruling-color}" text-anchor="middle">Tragedies</text>
                    <text x="{$mid + $mid div 2}" y="-{$max-high + 30}" fill="{$ruling-color}" text-anchor="middle">Comedies</text>

                    <!-- ==================================================== -->
                    <!-- Vertical ruling lines and labels                     -->
                    <!--                                                      -->
                    <!-- ==================================================== -->
                    <xsl:for-each select="0 to ($mid div 100)">
                        <xsl:variable name="left-x-pos" as="xs:double" select="$mid + 100 * current()"/>
                        <xsl:variable name="right-x-pos" as="xs:double" select="$mid - 100 * current()"/>
                        <!-- ================================================ -->
                        <!-- Comedies on right                                -->
                        <!-- ================================================ -->
                        <line x1="{$left-x-pos}" y1="0" x2="{$left-x-pos}" y2="-{$max-high}" stroke="{$ruling-color}" stroke-dasharray="3"/>
                        <text x="{$left-x-pos}" y="-{$max-high + 5}" fill="{$ruling-color}" text-anchor="middle">
                            <xsl:value-of select="(position() - 1) * 10"/>
                        </text>
                        <!-- ================================================ -->
                        <!-- Tragedies on left                                -->
                        <!-- ================================================ -->
                        <line x1="{$right-x-pos}" y1="0" x2="{$right-x-pos}" y2="-{$max-high}" stroke="{$ruling-color}" stroke-dasharray="3"/>
                        <text x="{$right-x-pos}" y="-{$max-high + 5}" fill="{$ruling-color}" text-anchor="middle">
                            <xsl:value-of select="(position() - 1) * 10"/>
                        </text>
                    </xsl:for-each>

                    <!-- ==================================================== -->
                    <!-- Bars                                                 -->
                    <!--                                                      -->
                    <!-- Strategy:                                            -->
                    <!--   Count all insult types for entire corpus to keep   -->
                    <!--     bars in sync on both sides; sort by total        -->
                    <!--   Draw and label both bars inside same loop          -->
                    <!-- ==================================================== -->
                    <xsl:for-each select="$distinct-insult-types">
                        <xsl:sort select="count($all-plays//@insType[. eq current()])"/>
                        <xsl:variable name="y-pos" as="xs:double" select="($space * 4) + (position() - 1.5) * ($bar-wide + $space)"/>
                        <xsl:variable name="y-pos-text" as="xs:double" select="$y-pos - $bar-wide div 2"/>
                        <!-- ================================================ -->
                        <!-- Comedies (right, blue)                            -->
                        <!-- ================================================ -->
                        <xsl:variable name="com-insult-count" as="xs:integer" select="count($comedies//@insType[. eq current()])"/>
                        <xsl:variable name="bar-width" as="xs:integer" select="$com-insult-count * $x-scale"/>
                        <rect x="{$mid}" y="-{$y-pos}" width="{$bar-width}" height="{$bar-wide}" fill="#5D81B9"/>
                        <text x="{$mid + $bar-width + 10}" y="-{$y-pos-text}" dominant-baseline="middle" fill="{$ruling-color}">
                            <xsl:value-of select="$com-insult-count"/>
                        </text>
                        <text x="{$mid + 820}" y="-{$y-pos-text}" fill="{$ruling-color}">
                            <xsl:value-of select="current()"/>
                        </text>
                        <!-- ================================================ -->
                        <!-- Tragedies (left, red)                          -->
                        <!-- ================================================ -->
                        <xsl:variable name="trag-insult-count" as="xs:integer" select="count($tragedies//@insType[. eq current()])"/>
                        <xsl:variable name="bar-width" as="xs:integer" select="$trag-insult-count * $x-scale"/>
                        <rect x="{$mid - $bar-width}" y="-{$y-pos}" width="{$bar-width}" height="{$bar-wide}" fill="#870C1D"/>
                        <text x="{$mid - $bar-width - 10}" y="-{$y-pos - $bar-wide div 2}" dominant-baseline="middle" fill="{$ruling-color}" text-anchor="end">
                            <xsl:value-of select="$trag-insult-count"/>
                        </text>
                        <text x="{$mid - 820}" y="-{$y-pos-text}" fill="{$ruling-color}" text-anchor="end">
                            <xsl:value-of select="current()"/>
                        </text>
                    </xsl:for-each>
                </g>
            </svg>
        </xsl:result-document>
    </xsl:template>
</xsl:stylesheet>
