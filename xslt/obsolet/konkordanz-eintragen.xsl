<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
  <xsl:param name="konkordanz" select="document('../../data/indices/konkordanz.xml')"/>
    <xsl:key name="konki" match="row" use="identifier"/>
    
    <xsl:template match="tei:title[@level='j' and starts-with(@xml:id, 'HB-tv')]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="level">
                <xsl:text>j</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:attribute name="ref">
                <xsl:choose>
                    <xsl:when test="key('konki', @xml:id, $konkordanz)">
                        <xsl:value-of select="concat('pmb', key('konki', @xml:id, $konkordanz)/pmb_id/text())"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@xml:id"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:copy-of select="text()"/>
            
            
            
        </xsl:element>
        
    </xsl:template>
    
  
</xsl:stylesheet>
