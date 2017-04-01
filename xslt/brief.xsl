<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="text"/>
    <xsl:template match="/">
        {
        "hwid-content": "<xsl:value-of select="hw.doc/@hwid-content"/>",
        "type": "<xsl:value-of select="hw.doc/@type"/>",
        "contentVersion": "<xsl:value-of select="hw.doc/@contentVersion"/>",
        "rank": "<xsl:value-of select="hw.doc/@rank"/>",
        "titles": [<xsl:for-each select="/hw.doc/doc.meta-data/meta-data.titles">
            {
                "audience": "<xsl:value-of select="meta-data.title/@audience"/>",
                "title": "<xsl:value-of select="meta-data.title"/>"
            } </xsl:for-each>
         ],
            "body": "<xsl:for-each select="/hw.doc/doc.prebuilt/prebuilt.content"><xsl:copy><xsl:apply-templates select="node()|@*"/></xsl:copy>
            <!-- xsl:value-of select="."/ -->     
        }</xsl:for-each>"
           
    </xsl:template>
                   


         
    <xsl:template match="*/text()[normalize-space()]">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>
    
    <xsl:template match="*/text()[not(normalize-space())]" />
            
    <xsl:character-map name="m1">
        <xsl:output-character character='"' string="\"/>
    </xsl:character-map>
</xsl:stylesheet>