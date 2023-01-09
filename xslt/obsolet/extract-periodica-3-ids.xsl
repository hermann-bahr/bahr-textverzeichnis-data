<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:body//tei:title[not(@ref) and not(@xml:id)]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="level">
                <xsl:text>j</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('HB-tv_periodica_', count(parent::tei:bibl/preceding-sibling::tei:bibl))"/>
            </xsl:attribute>
            <xsl:apply-templates/>
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
</xsl:stylesheet>
