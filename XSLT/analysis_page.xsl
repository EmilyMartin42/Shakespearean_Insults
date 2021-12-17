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
                        were the most useful for answering our four sub-research questions. 
                    </p>
                        <ol class="list">
                            <li>Do the other features influence insult type? Specifically, is there
                                any correlation between insult count and insult type to play genre
                                (tragedy vs comedy)</li><br/>
                            <li>Is there a correlation between type of relationship and relationship
                                status (i.e is there animosity or not) and does the state of the
                                relationship lend to distinct insult types?</li><br/>
                            <li>In order to convey to the insultee that they are indeed being
                                insulted is there a particular maxim that is most often flouted? Is
                                there any correlation between maxim flouted and illocutionary speech
                                act type?</li><br/>
                            <li>Is there a correlation between the gender of the speaker and the
                                type of speech act (direct vs. indirect)? Are there certain
                                combinations of gender between speaker and hearer that lead to a
                                particular type of speech act and does it effect the direct vs
                                indirectness of the speech act?</li>
                        </ol>
                </div>
                <!-- I am going to start by creating a section for each of our research questions and print info/stats for each -->
                <h3 class="subTitle">Insult type</h3>
                <div class="text-box">
                    <p class="analysis">Does play genre have any influence on insult type? This plot
                        shows the differences in the insult types between comedies and
                        tragedies.</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/ins_typeXgenre-djb.svg"</xsl:comment>
                    </div>

                    <!--< Insults and their counts between comedies and tragedies -->
                    <h3>Total insult counts between genres</h3>
                    <p/>
                    <p class="analysis">Between the two tragedies there were a total of: <xsl:value-of
                            select="count($tragedies//insult)"/> insults and between the two
                        comedies there are a total of <xsl:value-of
                            select="count($comedies//insult)"/> insults</p>
                    <br/>
                    <h3 class="analysis">Our initial thoughts</h3>
                    <p class="analysis">Right off the bat there does not seem to be a very meaningful difference between the total insult counts between plays, in fact the counts differ by
                    only a few insults. However, there is more of a difference when we look at the insult type between genres. The most common type, in very even counts for
                    both is name call, followed by personal attack and a combination of the two. These three make up the vast majority of insult types in the tragedies, while
                    insult types in the comedies are most spread out. There are even 6 types that fail to appear in the tragedies altogether.</p>
                </div>

                <h3 class="subTitle">Relationship state and insult type</h3>
                <div class="text-box">
                    <p class="analysis">What effect do different types of relationships have on the state of those
                        relationships?</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/rel_state.svg"</xsl:comment>
                    </div>
                    <h3 class="analysis">Our initial thoughts</h3>
                    <p class="analysis">The majority of the insults are given between people who have a negative relationship state. The only positive relationship states are between
                    parents and their child, friends to friends and spouses. The state between acquaintances is almost evenly split between neutral and negative while
                    siblings to siblings and childen to parents are entirely negative. Note that self does not have any relationship state, because while we found it 
                    a useful tag it did not fall into scope for this research question as relationship state was mainly a guage of animosty between characters and 
                    therefore it would not have been meaningful to examine self.</p>
                </div>

                <h3 class="subTitle">Speech acts and Gricean maxims</h3>
                <div class="text-box">
                    <p class="analysis">Is there a particular maxim that is most often flouted and
                        does it co-occur with any illocutionary acts in particular?</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/maximXilloc.svg"</xsl:comment>
                    </div>
                    <h3 class="analysis">Our initial thoughts</h3>
                    <p class="analysis">As seen on the graph, representative illocutionary speech acts made up the majority of all illoctionary act types, with the major intersection
                    between it and the maxim of manner. The maxim of quality comes next in terms of overall counts, with relevance following. Many other intersections have few to no counts.</p>
                </div>
                <h3 class="subTitle">Gender and speech acts</h3>
                <div class="text-box">
                    <p class="analysis">Does the gender of either the speaker or the listener have an impact on the
                        indirect versus directness of the speech act?</p>
                    <div class="image-container">
                        <xsl:comment>#include virtual="images/genderXspeechAct.svg"</xsl:comment>
                    </div>
                    <h3 class="aanalysis">Our initial thoughts</h3>
                    <p class="analysis">Right off the bat we can see that insults between male characters are by far the most common, with insults between female characters being by far 
                    the lowest represented category. There does not appear to be a favored speech act type between direct and indirect, with a count of 105 and 104 respectively.
                    Interestingly, however, while there does not appear to be a correlation between insulter and speech act type, when the insultee is female the speech
                    acts are more often indirect, regardless of the gender of the insulter. The same trend applies in reverse with direct speech acts being more common
                    toward male insultees regardless of the gender of the insulter.</p>
                </div>
                <xsl:comment>#include virtual="footer.xhtml"</xsl:comment>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
