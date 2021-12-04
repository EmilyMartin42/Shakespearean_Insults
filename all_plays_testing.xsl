<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('markedPlays/finals/?select=*.xml')"/>
    <xsl:variable name="tragedies" as="document-node()+"
        select="collection('markedPlays/finals/?select=hamFinal.xml')"/>
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>Shakespeare's Slights</title>
                <link rel="stylesheet" type="text/css" href="CSS/index.css"/>
            </head>
            <body class="analysis">
                <!--
                <xsl:for-each-group select="$all_plays//insult"
                    group-by="insultStart/@insType ! tokenize(.)">
                    <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                    <p>
                        <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                    </p>
                    <xsl:for-each-group select="current-group()"
                        group-by="insultStart/@speechAct">
                        <p>
                            <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                    </xsl:for-each-group>
                    <xsl:for-each-group select="current-group()"
                        group-by="insultStart/@gender">
                        <p>
                            <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                    </xsl:for-each-group>
                    
                -->
                <h1>Analysis of our results</h1>
                <!-- I am going to start by creating a section for each of our research questions and print info/stats for each -->
                <h2 class="subTitle">Insult type</h2>
                <p>
                    Here are the different types of insults and their counts, because multiple insults types were
                    allowed on one insult there are double counts.
                </p>
                <table>
                    <tr>
                        <th>Insult type</th>
                        <th>Count</th>
                    </tr>
                    <!-- tokenized version, gets rid of multiple values -->
                    <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@insType ! tokenize(.)">
                        <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                        <tr>
                            <td>
                                <xsl:value-of select="current-grouping-key()"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(current-group())"/>
                            </td>
                        </tr>
                    </xsl:for-each-group>
                    <!-- not tokenized, counts instypes with multiple values as a singular unit -->
                    <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@insType">
                        <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                        <tr>
                            <td>
                                <xsl:value-of select="current-grouping-key()"/>
                            </td>
                            <td>
                                <xsl:value-of select="count(current-group())"/>
                            </td>
                        </tr>
                    </xsl:for-each-group>
            <!--
                        <xsl:for-each-group select="current-group()"
                            group-by="insultStart/@speechAct">
                            <p>
                                <xsl:value-of
                                    select="current-grouping-key(), ':', count(current-group())"/>
                            </p>
                        </xsl:for-each-group>
                        <xsl:for-each-group select="current-group()"
                            group-by="insultStart/@insType ! tokenize(.)">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                            <p>
                                <xsl:value-of
                                    select="current-grouping-key(), ':', count(current-group())"/>
                            </p>
                        </xsl:for-each-group>
                    </xsl:for-each-group> 
            -->
                </table>
                <h2>Relationship state and insult type</h2>
                
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
