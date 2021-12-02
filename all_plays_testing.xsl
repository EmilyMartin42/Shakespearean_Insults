<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('markedPlays/finals/?select=*.xml')"/>
    <xsl:template name="xsl:initial-template">
        <html>
            <head>
                <title>test</title>
            </head>
            <body>
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
                
                <xsl:for-each-group select="$all_plays//insult"
                    group-by="insultStart/@gender">
                    <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                    <hr/>
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
                        group-by="insultStart/@insType">
                        <p>
                            <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                    </xsl:for-each-group>
                    
                </xsl:for-each-group>
               
                </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
