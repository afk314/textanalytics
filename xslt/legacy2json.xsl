<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:xs="http://www.w3.org/2001/XMLSchema" 
xmlns:xhtml="http://www.w3.org/1999/xhtml" 
exclude-result-prefixes="xs" 
version="1.0">

	<xsl:output method="text" encoding="utf-8" indent="no"/>


	<xsl:template match="section.meta-data/meta-data.title">
	</xsl:template>

	<xsl:template match="//*[@class='HwAccessibilityText']"></xsl:template>
	<xsl:template match="//*[@class='HwSectionTitle']"></xsl:template>
	<xsl:template match="/">
        <xsl:text>{"hwid-content": "</xsl:text><xsl:value-of select="hw.doc/@hwid-content"/>
		<xsl:text>","type": "</xsl:text><xsl:value-of select="hw.doc/@type"/>
        <xsl:text>","contentVersion": "</xsl:text><xsl:value-of select="hw.doc/@contentVersion"/>
        <xsl:text>","rank": "</xsl:text><xsl:value-of select="hw.doc/@rank"/>
        <xsl:text>","titles": [</xsl:text>
			<xsl:for-each select="/hw.doc/doc.meta-data/meta-data.titles">
        		<xsl:text>{"audience": "</xsl:text><xsl:value-of select="meta-data.title/@audience"/>
        		<xsl:text>","title": "</xsl:text><xsl:value-of select="meta-data.title"/>
                <xsl:text>"}</xsl:text>
			</xsl:for-each>
		 <xsl:text>],"sections": [</xsl:text>
		 <xsl:for-each select="/hw.doc/doc.sections/doc.section">
		 	<xsl:text>{"section": "title": "</xsl:text>
			<xsl:value-of select="section.meta-data/meta-data.title"/>
		 	<xsl:text>","type": "</xsl:text>
			<xsl:value-of select="section.std/@type"/>
		 	<xsl:text>","body": "</xsl:text>
			<xsl:apply-templates select="section.std"/>
			<xsl:text>"}  </xsl:text>
		</xsl:for-each>
		<xsl:text> ] } </xsl:text>
	</xsl:template>


	<xsl:template match="text()">
	    <xsl:call-template name="escapeJson"/>
	</xsl:template>


  <xsl:template name="escapeJson">
    <xsl:call-template name="escapeQuote">
      <xsl:with-param name="pText">
        <xsl:call-template name="jsonescape">
          <xsl:with-param name="str" select="." />
        </xsl:call-template>          
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="escapeQuote">
      <xsl:param name="pText" select="concat(normalize-space(.),' ')" />
      <xsl:if test="string-length($pText) >0">
          <xsl:value-of select="substring-before(concat($pText, '&quot;'), '&quot;')" />

          <xsl:if test="contains($pText, '&quot;')">
              <xsl:text>\"</xsl:text>    
              <xsl:call-template name="escapeQuote">
                  <xsl:with-param name="pText" select="substring-after($pText, '&quot;')" />
              </xsl:call-template>
          </xsl:if>

      </xsl:if>
  </xsl:template>

  <xsl:template name="jsonescape">
   <xsl:param name="str" select="."/>
   <!-- xsl:param name="escapeChars" select="'\&quot;'" / -->
   <xsl:param name="escapeChars" select="assd" />

   <xsl:variable name="first" select="substring(translate($str, translate($str, $escapeChars, ''), ''), 1, 1)" />
   <xsl:choose>
      <xsl:when test="$first">
        <xsl:value-of select="concat(substring-before($str, $first), '\', $first)"/>
        <xsl:call-template name="jsonescape">
          <xsl:with-param name="str" select="substring-after($str, $first)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
          <xsl:value-of select="concat(normalize-space($str),' ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

<!-- Stylus Studio meta-information - (c) 2004-2009. Progress Software Corporation. All rights reserved.

<metaInformation>
	<scenarios>
		<scenario default="yes" name="Scenario1" userelativepaths="no" externalpreview="no" url="file:///c:/Temp/cpain.xml" htmlbaseurl="" outputurl="file:///c:/Temp/cpain.txt" processortype="saxon8" useresolver="no" profilemode="0" profiledepth=""
		          profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext="" validateoutput="no" validator="internal"
		          customvalidator="">
			<advancedProp name="sInitialMode" value=""/>
			<advancedProp name="schemaCache" value="||"/>
			<advancedProp name="bXsltOneIsOkay" value="true"/>
			<advancedProp name="bSchemaAware" value="false"/>
			<advancedProp name="bGenerateByteCode" value="false"/>
			<advancedProp name="bXml11" value="false"/>
			<advancedProp name="iValidation" value="0"/>
			<advancedProp name="bExtensions" value="true"/>
			<advancedProp name="iWhitespace" value="0"/>
			<advancedProp name="sInitialTemplate" value=""/>
			<advancedProp name="bTinyTree" value="true"/>
			<advancedProp name="xsltVersion" value="2.0"/>
			<advancedProp name="bWarnings" value="true"/>
			<advancedProp name="bUseDTD" value="false"/>
			<advancedProp name="iErrorHandling" value="fatal"/>
		</scenario>
	</scenarios>
	<MapperMetaTag>
		<MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/>
		<MapperBlockPosition></MapperBlockPosition>
		<TemplateContext></TemplateContext>
		<MapperFilter side="source"></MapperFilter>
	</MapperMetaTag>
</metaInformation>
-->