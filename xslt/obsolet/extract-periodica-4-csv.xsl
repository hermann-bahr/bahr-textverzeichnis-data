<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="no" method="text" encoding="utf-8" omit-xml-declaration="true"/>
    
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="descendant::tei:body//tei:biblStruct[tei:analytic[tei:title/@ref] and tei:monogr/tei:title/@ref]">
        </xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct">
        
        <xsl:value-of select="replace(tei:analytic/tei:title/@ref, 'pmb', '')"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="replace(tei:monogr/tei:title/@ref, 'pmb', '')"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="descendant::tei:monogr//tei:date/@when[1]"/>
        <xsl:text>&#xA;</xsl:text>
        
        
    </xsl:template>
</xsl:stylesheet>
