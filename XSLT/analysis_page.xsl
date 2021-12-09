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
                    <p> Below is our analysis and overall findings. Because we looked at so many
                        different factors not all of them can be explored in detail here however,
                        through careful examination we were able to pull out the factors we thought
                        were the most useful for answering our four sub-research questions. <ol>
                            <li>Do the other features influence insult type? Specifically, is there
                                any correlation between insult count and insult type to play genre
                                (tragedy vs comedy)</li>
                            <li>Is there a correlation between type of relationship and relationship
                                status (i.e is there animosity or not) and does the state of the
                                relationship lend to distinct insult types?</li>
                            <li>In order to convey to the insultee that they are indeed being
                                insulted is there a particular maxim that is most often flouted? Is
                                there any correlation between maxim flouted and illocutionary speech
                                act type?</li>
                            <li>Is there a correlation between the gender of the speaker and the
                                type of speech act (direct vs. indirect)? Are there certain
                                combinations of gender between speaker and hearer that lead to a
                                particular type of speech act and does it effect the direct vs
                                indirectness of the speech act?</li>
                        </ol>
                    </p>
                </div>
                <!-- I am going to start by creating a section for each of our research questions and print info/stats for each -->
                <h3 class="subTitle">Insult type</h3>
                <div class="text-box">
                    <p class="wTable"> Here are the different types of insults and their counts, because multiple
                        insults types were allowed on one insult there are double counts. </p>
                    <table>
                        <tr>
                            <th>Insult type</th>
                            <th>Count</th>
                        </tr>
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
                    <p class="wTable">Insults and their counts in the tragedies. In total there are:
                            <xsl:value-of select="count($tragedies//insult)"/></p>
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
                    </table>
                    <p class="wTable">Insults and their counts in the comedies. In total there are:
                            <xsl:value-of select="count($comedies//insult)"/></p>
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
                    </table>
                </div>
                <h3 class="subTitle">Relationship state and insult type</h3>
                <div class="text-box">
                    <p>What effect do different types of relationships have on the state of those
                        relationships?</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/rel_state.svg"</xsl:comment>
                    </div>
                </div>

                <h3 class="subTitle">Speech acts and Gricean maxims</h3>
                <div class="text-box">
                    <p class="wTable">These are the illocutionary act types present on our insults</p>
                    <table>
                        <tr>
                            <th>Illocutionary type</th>
                            <th>Count</th>
                        </tr>
                        <xsl:for-each-group select="$all_plays//insult"
                            group-by="insultStart/@speechAct">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>

                            <!--<p>
                                <xsl:value-of
                                    select="current-grouping-key(), ':', count(current-group())"/>
                            </p>-->
                            <xsl:for-each-group select="current-group()"
                                group-by="insultStart/@illoc-type ! tokenize(.)">
                                <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                                <!--<p>
                                    <xsl:value-of
                                        select="current-grouping-key(), ':', count(current-group())"
                                    />
                                </p>-->
                                <tr>
                                    <td>
                                        <xsl:value-of select="current-grouping-key()"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="count(current-group())"/>
                                    </td>
                                </tr>

                            </xsl:for-each-group>
                        </xsl:for-each-group>
                    </table>
                    <p class="wTable">These are the maxims flouted in order to convey that these are, in fact, insults</p>
                    <table>
                        <tr>
                            <th>Maxim flouted</th>
                            <th>Count</th>
                        </tr>
                        <xsl:for-each-group select="$all_plays//insult"
                            group-by="insultStart/@speechAct">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                            <xsl:for-each-group select="current-group()"
                                group-by="insultStart/@maxim">
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
                        </xsl:for-each-group>
                    </table>
                </div>
                <h3 class="subTitle">Gender and speech acts</h3>
                <div class="text-box">
                    <p>Does the gender of either the speaker or the listener have an impact on the
                        indirect versus directness of the speech act?</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/genderXspeechAct.svg"</xsl:comment>
                    </div>
                    <!--<xsl:for-each-group select="$all_plays//insult" group-by="insultStart/@gender">
                        <xsl:sort select="current-grouping-key()"/>
                        <p>
                            <xsl:value-of select="current-grouping-key(), ':', count(current-group())"/>
                        </p>
                        <xsl:for-each-group select="current-group()"
                            group-by="insultStart/@speechAct">
                            <xsl:sort select="current-grouping-key() ! lower-case(.)"/>
                            <p>
                                <xsl:value-of
                                    select="current-grouping-key(), ':', count(current-group())"/>
                            </p>
                        </xsl:for-each-group> 
                    </xsl:for-each-group>-->
                </div>
                <xsl:comment>#include virtual="footer.xhtml"</xsl:comment>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
