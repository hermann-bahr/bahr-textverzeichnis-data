<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:template match="tei:listBibl">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:for-each select="tei:biblStruct[tei:monogr/tei:title[@level = 'm' and starts-with(@ref, 'HB-tv_m')]]">
                
                    <xsl:copy-of select="."/>
                
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
