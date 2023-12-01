<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="altes-textverzeichnis" select="document('../../textverzeichnis-alt.xml')"/>
    <xsl:key name="periodica-abdrucke" match="tei:biblStruct" use="@xml:id"/>
    <xsl:template match="tei:biblStruct">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="*"/>
            <xsl:if test="key('periodica-abdrucke', @xml:id, $altes-textverzeichnis)">
                <xsl:element name="sex">
                    <xsl:copy-of select="key('periodica-abdrucke', @xml:id, $altes-textverzeichnis)//tei:note[@type='periodica']"/>
                </xsl:element>
                
            </xsl:if>
            
            
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
