<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="tei:note[@type='toc']"/>
    
    <xsl:template match="tei:biblStruct[@type='Book']">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*"/>
            <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>toc</xsl:text>
                </xsl:attribute>
                <xsl:variable name="xmlid" select="@xml:id"/>
                <xsl:for-each select="ancestor::tei:listBibl/tei:biblStruct[tei:analytic and tei:monogr/tei:title[@level='m']/@ref=$xmlid]">
                    <xsl:element name="desc" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="ana">
                            <xsl:value-of select="tei:monogr[1]/descendant::tei:biblScope[@unit='page'][1]"/>
                        </xsl:attribute>
                        <xsl:attribute name="corresp">
                            <xsl:value-of select="concat('#', @xml:id)"/>
                        </xsl:attribute>
                        <xsl:value-of select="tei:analytic/tei:title"/>
                    </xsl:element>
                </xsl:for-each>
                
                
            </xsl:element>
            
            
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
</xsl:stylesheet>