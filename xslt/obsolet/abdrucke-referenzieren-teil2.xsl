<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:bibl/@mid">
        <xsl:choose>
            <xsl:when test=". = ancestor::tei:listBibl/tei:biblStruct/@mid">
                <xsl:variable name="aktuell" select="."/>
                <xsl:attribute name="ref">
                <xsl:value-of select="ancestor::tei:listBibl/tei:biblStruct[$aktuell=@mid]/@xml:id"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="mid">
                <xsl:value-of select="@mid"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>
