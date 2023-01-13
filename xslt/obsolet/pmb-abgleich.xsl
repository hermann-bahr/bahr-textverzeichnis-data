<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:param name="uris" select="document('../../uris.xml')"/>
    <xsl:key name="uri-lookup" match="item" use="URL[@type]"
        ></xsl:key>
    
    
    
    <xsl:template match="tei:title/@ref[starts-with(., 'HB-tv')]">
        <xsl:variable name="lookup" select="concat('pmb', key('uri-lookup', ., $uris)/Entity_ID)"/>
        <xsl:attribute name="ref">
        <xsl:choose>
            <xsl:when test="$lookup='pmb' or $lookup=''">
                <xsl:text>SUX</xsl:text>
                <xsl:value-of select="."/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>SIX</xsl:text>
                <xsl:value-of select="$lookup"/>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
  
  
  
    

</xsl:stylesheet>
