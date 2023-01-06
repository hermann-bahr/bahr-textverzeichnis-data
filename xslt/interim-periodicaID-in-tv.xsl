<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:param name="periodica"
        select="document('../data/indices/listPeriodica.xml')"/>
    <xsl:key name="periodica-lookup" match="tei:listBibl/tei:bibl/tei:title" 
        use="." />
    
    
    
    <xsl:template match="tei:title[@level='j' and not(@ref)]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="level">
                <xsl:text>j</xsl:text>
            </xsl:attribute>
            <xsl:if test="key('periodica-lookup', ., $periodica)">
            <xsl:attribute name="ryf">
                <xsl:choose>
                    <xsl:when test="key('periodica-lookup', ., $periodica)/@ref">
                        <xsl:value-of select="key('periodica-lookup', ., $periodica)/@ref"/>
                    </xsl:when>
                    <xsl:when test="key('periodica-lookup', ., $periodica)/@xml:id">
                        <xsl:value-of select="key('periodica-lookup', ., $periodica)/@xml:id"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="text()"/>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>
