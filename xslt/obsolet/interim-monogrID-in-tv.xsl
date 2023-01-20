<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    
    
    
    <xsl:template match="tei:monogr/tei:title[@level='m' and not(@ref)]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="level">
                <xsl:text>m</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="ryf">
                <xsl:value-of select="concat('HB-tv_monogr_', ancestor::tei:biblStruct/count(preceding-sibling::tei:biblStruct))"/>
            </xsl:attribute>
            <xsl:copy-of select="text()"/>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>
