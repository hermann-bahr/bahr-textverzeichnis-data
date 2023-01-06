<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:template match="tei:body/tei:listBibl">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="tei:biblStruct[not(@sameAs)]"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct[not(@sameAs) and child::tei:analytic]">
            <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="@*"/>
                    <xsl:copy-of select="child::tei:analytic" copy-namespaces="false"/>
                    <xsl:copy-of copy-namespaces="false" select="tei:note[not(@type)]"/>
                    <xsl:copy-of copy-namespaces="false" select="tei:note[@type='bibliographical-statement']"></xsl:copy-of>
                    <xsl:copy-of select="descendant::tei:date[1]" copy-namespaces="false"/>
                <xsl:copy-of select="descendant::tei:ref[@type='URL']" copy-namespaces="false"/>
                </xsl:element>
            
        
    </xsl:template>
</xsl:stylesheet>
