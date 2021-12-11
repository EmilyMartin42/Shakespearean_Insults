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
                <xsl:value-of select="sha:normalize(replace($input, ' \?', '?'), ($iteration + 1))"/>
            </xsl:when>
            <xsl:when test="$iteration = 5">
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
                <title><xsl:value-of select="//titleStmt/title"/> Insults</title>
                <!-- This needs changed per insultPage -->
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
                <h1 id="mainTitle">Insults in <xsl:value-of select="//titleStmt/title"/></h1>
                <!-- This needs changed per insultPage -->
                <div id="insultFlex">
                    <!-- This is where insults would go -->
                    <xsl:apply-templates select="//insult" mode="readView"/>
                </div>
                <xsl:comment>#include virtual="insultSort.xhtml"</xsl:comment>
                <script src="sort.js"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="insult" mode="readView">
        <xsl:variable name="insType" as="xs:string" select="insultStart/@insType"/>
        <xsl:variable name="gender" as="xs:string?" select="insultStart/@gender"/>
        <xsl:variable name="rel" as="xs:string?" select="insultStart/@rel"/>
        <xsl:variable name="relState" as="xs:string?" select="insultStart/@rel-state"/>
        <xsl:variable name="speechAct" as="xs:string?" select="insultStart/@speechAct"/>
        <xsl:variable name="illocType" as="xs:string?" select="insultStart/@illoc-type"/>
        <xsl:variable name="maxim" as="xs:string?" select="insultStart/@maxim"/>
        <p>
            <xsl:attribute name="class">
                <xsl:value-of select="insultStart/@*"/>
                <xsl:text> insult</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates select="sha:normalize(normalize-space(.), 1)"/>
            <span>
                <xsl:attribute name="title" select="
                    concat('Insult Type: ', $insType, codepoints-to-string(9), 'Gender: ', $gender, codepoints-to-string(10), 'Relationship: ', $rel, codepoints-to-string(9), 'Relationship State: ', $relState, codepoints-to-string(10), 'Speech Act: ', $speechAct, codepoints-to-string(9), 'Illocutionary Type: ', $illocType, codepoints-to-string(10), 'Maxim: ', $maxim)"/>
                <xsl:text>  &#9432;</xsl:text>
            </span>
        </p>
    </xsl:template>
</xsl:stylesheet>
