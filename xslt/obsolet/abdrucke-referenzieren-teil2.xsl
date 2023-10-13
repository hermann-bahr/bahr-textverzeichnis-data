<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:bibl[@mmid]">
        <xsl:variable name="seite" select="tei:biblScope[@unit='page']"/>
        <xsl:variable name="nummer" select="replace(tei:title/@ref, '#', '')"/>
        <xsl:choose>
            <xsl:when test="ancestor::tei:*/tei:biblStruct[tei:monogr[tei:imprint/tei:biblScope[@unit='page' and .=$seite]]/tei:title/@ref = $nummer]">
                <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="ina">
                        <xsl:value-of select="ancestor::tei:*/tei:biblStruct[tei:monogr[tei:imprint/tei:biblScope[@unit='page' and .=$seite]]/tei:title/@ref = $nummer]/@xml:id"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."></xsl:copy-of>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    <!-- <xsl:template match="tei:bibl/@mid">
        <xsl:choose>
            <xsl:when test=". = ancestor::tei:listBibl/tei:biblStruct/@mid">
                <xsl:variable name="aktuell" select="."/>
                <xsl:attribute name="ref">
                <xsl:value-of select="ancestor::tei:listBibl/tei:biblStruct[$aktuell=@mid]/@xml:id"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="mid">
                <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template> -->
    
    
</xsl:stylesheet>
