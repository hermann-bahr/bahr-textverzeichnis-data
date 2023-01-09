<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="no" method="text" encoding="utf-8" omit-xml-declaration="true"/>
    
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="descendant::tei:body/descendant::tei:title[@xml:id]"></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="tei:title">
        <xsl:value-of select="@xml:id"/>
        <xsl:text>;</xsl:text>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:text>&#xA;</xsl:text>
        
        
    </xsl:template>
</xsl:stylesheet>
