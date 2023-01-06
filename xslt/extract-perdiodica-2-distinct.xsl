<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:bibl">
        <xsl:choose>
            <xsl:when test="tei:title/@ref">
                <xsl:choose>
                    <xsl:when test="tei:title/@ref = preceding-sibling::tei:bibl/tei:title/@ref"/>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>   
                </xsl:choose>
                
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="tei:title/. = preceding-sibling::tei:bibl/tei:title/."/>
                    <xsl:otherwise>
                        <xsl:copy-of select="."/>
                    </xsl:otherwise>   
                </xsl:choose>
                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
