<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:bibl[@ana]"/>
    
    <xsl:template match="tei:note[@type='periodica' or @type='monographies' and not(child::*)]"/>
    
    <xsl:template match="tei:biblStruct[tei:ref[@type='abdrucke'][2]]">
            <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:copy-of select="@*|*[not(self::tei:ref[@type='abdrucke'])]"/>
                <xsl:element name="ref">
                    <xsl:attribute name="type">
                        <xsl:text>abdrucke</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="listRef" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:copy-of select="descendant::tei:ptr[@type='textref' and not(@target=preceding-sibling::tei:ptr/@target)]"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        
    </xsl:template>
    
</xsl:stylesheet>
