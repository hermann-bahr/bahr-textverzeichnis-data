<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <!-- das hier stellt nachdrucke auf kommentar um, wenn die ref in den listref ptrs ist-->
    <xsl:mode on-no-match="shallow-copy"/>
    
    
    <xsl:template match="tei:note[@type='periodica']/tei:bibl[tei:title[@level='a' and @ref]]">
       <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="type">
               <xsl:text>obsolete</xsl:text>
           </xsl:attribute>
            <xsl:copy-of select="*"/>
       </xsl:element>
    </xsl:template>
    <xsl:template match="tei:note[@type='monographies']/tei:bibl[tei:title[@level='a' and @ref]]">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>obsolete</xsl:text>
            </xsl:attribute>
            <xsl:copy-of select="*"/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>