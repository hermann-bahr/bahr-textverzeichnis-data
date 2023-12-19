<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
  <xsl:param name="konkordanz" select="document('../../listperson-wikidata-uris.xml')"/>
    <xsl:key name="konki" match="row" use="*:person_idno"/>
    
    <xsl:template match="tei:idno[@type='TSN']">
        <xsl:copy-of select="."/>
        <xsl:variable name="current" select="text()"/>
        <xsl:if test="key('konki', $current, $konkordanz)">
        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>wikidata</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="key('konki', $current, $konkordanz)[1]//*:wikidata[1]"/>
            
            
            
            
            
            
        </xsl:element>
        </xsl:if>
    </xsl:template>
    
  
</xsl:stylesheet>
