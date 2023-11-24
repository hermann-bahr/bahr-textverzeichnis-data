<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:listBibl">
        <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates/>
               
            
            
        </xsl:element>
        
    </xsl:template>
    <xsl:template match="tei:biblStruct[not(tei:analytic) and tei:monogr/tei:author/@ref='pmb10815']">
        <xsl:element name="item" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="corresp">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
           
            <xsl:value-of select="normalize-space(tei:monogr[1]/tei:title[@level='m'])"/>
            </xsl:element>
            <xsl:copy-of select="descendant::tei:date[@when][1]" copy-namespaces="no"></xsl:copy-of>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
