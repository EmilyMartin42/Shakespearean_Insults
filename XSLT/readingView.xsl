<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sha="http://insults.obdurodon.org"
    exclude-result-prefixes="xs" xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="no" include-content-type="no"
        indent="yes"/>
    <!-- Yes, this function is recursive. Yes, there is probably a better way to do this. 
        No, I don't care to spend 5 hours figuring it out. 
        Yes, you can add more punctuation marks as you need them. 
        Just add another iteration check and change the end case (make sure it's always negative one.)
        Yes, this function gets less efficient the more punctuation marks you add.-->
    <xsl:function name="sha:normalize" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:param name="iteration" as="xs:integer"/>
        <xsl:choose>
            <xsl:when test="$iteration = 1">
                <xsl:value-of select="sha:normalize(replace($input, ' ,', ','), ($iteration + 1))"/>
            </xsl:when>
            <xsl:when test="$iteration = 2">
                <xsl:value-of select="sha:normalize(replace($input, ' \.', '.'), ($iteration + 1))"
                />
            </xsl:when>
            <xsl:when test="$iteration = 3">
                <xsl:value-of select="sha:normalize(replace($input, ' !', '!'), ($iteration + 1))"/>
            </xsl:when>
            <xsl:when test="$iteration = 4">
                <xsl:value-of select="sha:normalize(replace($input, ' ;', ';'), -1)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="replace($input, ' :', ':')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title><xsl:value-of select="//titleStmt/title"/> Insults</title> <!-- This needs changed per insultPage -->
                <link rel="stylesheet" type="text/css" href="CSS/index.css"/>
            </head>
            <body>
                <xsl:comment>#include virtual="menu.xhtml"</xsl:comment>
                <div class="pagination">
                    <xsl:choose>
                        <xsl:when test="//titleStmt/shortTitle = 'Hamlet'">
                            <a class="active" href="hamInsults.xhtml">Hamlet</a>
                            <a href="othInsults.xhtml">Othello</a>
                            <a href="mndInsults.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeInsults.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Othello'">
                            <a href="hamInsults.xhtml">Hamlet</a>
                            <a class="active" href="othInsults.xhtml">Othello</a>
                            <a href="mndInsults.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeInsults.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Midsummer Nights Dream'">
                            <a href="hamInsults.xhtml">Hamlet</a>
                            <a href="othInsults.xhtml">Othello</a>
                            <a class="active" href="mndInsults.xhtml">A Midsummer Night's Dream</a>
                            <a href="coeInsults.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                        <xsl:when test="//titleStmt/shortTitle = 'Comedy of Errors'">
                            <a href="hamInsults.xhtml">Hamlet</a>
                            <a href="othInsults.xhtml">Othello</a>
                            <a href="mndInsults.xhtml">A Midsummer Night's Dream</a>
                            <a class="active" href="coeInsults.xhtml">The Comedy of Errors</a>
                        </xsl:when>
                    </xsl:choose>
                </div>
                <h1 id="mainTitle">Insults in <xsl:value-of select="//titleStmt/title"/></h1> <!-- This needs changed per insultPage -->
                <div id="insultFlex"> <!-- This is where insults would go -->
                    <xsl:apply-templates select="//insult" mode="readView"/>
                </div>
                <div id="mainContainer">
                    <h3>Sort by tags:</h3>
                    <!-- Start of collapsible -->
                    <button type="button" class="collapsible">Insult Type</button>
                    <div class="content">
                        <label class="container">Personal Attack <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Name Calling <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Sex/Gender-based Insult <input type="checkbox"
                            checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Backhanded Compliment <input type="checkbox"
                            checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Slander <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                    </div>
                    <!-- Start of collapsible -->
                    <button type="button" class="collapsible">Gender</button>
                    <div class="content">
                        <label class="container">Male to male <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Male to female <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Female to female <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Female to male <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                    </div>
                    <!-- Start of collapsible -->
                    <button type="button" class="collapsible">Relationship</button>
                    <div class="content">
                        <label class="container">Parent to child <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Child to parent <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Sibling to sibling <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Friend to friend <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Couple to couple <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Acquantance to acquantance <input type="checkbox"
                            checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <label class="container">Self <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                    </div>
                    <!-- Start of collapsible -->
                    <button type="button" class="collapsible">Speech Act</button> <!-- This portion needs to be renamed and new CSS elements created -->
                    <div class="content">
                        <label class="container">Direct <input type="checkbox" checked="checked" />
                            <span class="checkmark"></span><br />
                        </label>
                        <button type="button" class="collapsible">Indirect</button>
                        <div class="content">
                            <button type="button" class="collapsible">Maxims</button>
                            <div class="content">
                                <label class="container">Quality <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Quantity <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Relevance <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Manner <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                            </div>
                            <button type="button" class="collapsible">Illocutionary Acts</button>
                            <div class="content">
                                <label class="container">Representative <input type="checkbox"
                                    checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Directive <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Commissive <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Expressive <input type="checkbox" checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                                <label class="container">Declarative <input type="checkbox"
                                    checked="checked" />
                                    <span class="checkmark"></span><br />
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <script src="collapsible.js"></script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="insult" mode="readView">
        <p>
            <xsl:attribute name="class"><xsl:value-of select="insultStart/@*"/><xsl:text> p</xsl:text></xsl:attribute>
            <xsl:apply-templates select="sha:normalize(normalize-space(.), 1)"/>
        </p>
    </xsl:template>
</xsl:stylesheet>
