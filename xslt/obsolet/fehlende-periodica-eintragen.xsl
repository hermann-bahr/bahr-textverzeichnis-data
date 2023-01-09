<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
  <xsl:param name="konkordanz" select="document('../../data/indices/listperiodica.xml')"/>
    <xsl:key name="konki" match="tei:bibl" use="tei:title/@ref"/>
    
    <xsl:template match="tei:title[@level='j' and .='']">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:choose>
                <xsl:when test="key('konki', @ref, $konkordanz)">
                    <xsl:value-of select="key('konki', @ref, $konkordanz)/tei:title/text()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>SEXSEX</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            
            
            
            
        </xsl:element>
        
    </xsl:template>
    
  
</xsl:stylesheet>
