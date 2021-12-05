<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>

    <xsl:variable name="all_plays" as="document-node()+"
        select="collection('../markedPlays/finals/?select=*.xml')"/>
    <xsl:variable name="tragedies" as="document-node()+"
        select="doc('../markedPlays/finals/hamFinal.xml'), doc('../markedPlays/finals/othFinal.xml')"/>
    <xsl:variable name="comedies" as="document-node()+"
        select="doc('../markedPlays/finals/comFinal.xml'), doc('../markedPlays/finals/mndFinal.xml')"/>
    <xsl:template name="xsl:initial-template">

        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="CSS/index.css"/>
                <title>Shakespeare's Slights</title>
            </head>
            <body class="analysis">
                <xsl:comment>#include virtual="menu.xhtml"</xsl:comment>
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
                <h2 class="subTitle">Analysis</h2>  
                <div class="text-box">
                <p>
                    Below is our analysis and overall findings. Because we looked at so many different factors not all of them can be explored in detail here however, 
                    through careful examination we were able to pull out the factors we thought were the most useful for answering our four sub-research questions. 
                    <ol>
                        <li>What role does insult type play and how does it influence other interconnected features?</li>
                        <li>What types of relationship state are more common for those who are closer, and do the insults they use on each other have a distinct type. 
                            Does the state of the relationship lend to distinct insult types?</li>
                        <li>Do particular illocutionary speech act types tend to employ to the flouting of a specific maxim in order to convey them?</li>
                        <li>Does gender have an effect on insult type and does it effect the direct vs indirectness of the speech act?</li>
                    </ol>
                </p>
                </div>
                <!-- I am going to start by creating a section for each of our research questions and print info/stats for each -->
                <h3 class="subTitle">Insult type</h3>
                <div class="text-box">
                    <p> Here are the different types of insults and their counts, because multiple
                        insults types were allowed on one insult there are double counts. </p>
                    <table>
                        <tr>
                            <th>Insult type</th>
                            <th>Count</th>
                        </tr>
                        <!-- tokenized version, gets rid of multiple values -->
                        <xsl:for-each-group select="$all_plays//insult"
                            group-by="insultStart/@insType ! tokenize(.)">
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
                        <xsl:for-each-group select="$all_plays//insult"
                            group-by="insultStart/@insType">
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
                    </table>
                    <!-- Insults and their counts between comedies and tragedies -->
                    <p>Insults and their counts in the tragedies</p>
                    <table>
                        <tr>
                            <th>Insult type</th>
                            <th>Count</th>
                        </tr>
                        <!-- tokenized version, gets rid of multiple values -->
                        <xsl:for-each-group select="$tragedies//insult"
                            group-by="insultStart/@insType ! tokenize(.)">
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
                        <!--
                        <xsl:for-each-group select="$tragedies//insult"
                            group-by="insultStart/@insType">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                            </tr>
                        </xsl:for-each-group>     -->                   
                    </table>
                    <p>Insults and their counts in the comedies</p>
                    <table>
                        <tr>
                            <th>Insult type</th>
                            <th>Count</th>
                        </tr>
                        <!-- tokenized version, gets rid of multiple values -->
                        <xsl:for-each-group select="$comedies//insult"
                            group-by="insultStart/@insType ! tokenize(.)">
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
                        <!--
                        <xsl:for-each-group select="$comedies//insult"
                            group-by="insultStart/@insType">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td>
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                            </tr>
                        </xsl:for-each-group>    -->                     
                    </table>
                </div>
                <h3 class="subTitle">Relationship state and insult type</h3>
                <div class="text-box">
                    <p> We can probably put Masons svg here, run with all the plays </p>
                </div>
            
                <h3 class="subTitle">Speech acts and Gricean maxims</h3>
                <div class="text-box">
                <xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@speechAct">
                    <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                    <p>
                        <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                    </p>
                    <xsl:for-each-group select="current-group()"
                        group-by="insultStart/@illoc-type ! tokenize(.)">
                        <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                        <p>
                            <xsl:value-of
                                select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                    </xsl:for-each-group> 
                    <xsl:for-each-group select="current-group()"
                        group-by="insultStart/@maxim ! tokenize(.)">
                        <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                        <p>
                            <xsl:value-of
                                select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                    </xsl:for-each-group>
                </xsl:for-each-group>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
