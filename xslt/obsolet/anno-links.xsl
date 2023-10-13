<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    
    
    <xsl:template match="tei:ref[@type='URL' and . ='https://anno.onb.ac.at/cgi-content/anno?aid=nwj']">
        <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>URL</xsl:text>
            </xsl:attribute>
            <xsl:variable name="imprint" select="ancestor::tei:biblStruct/tei:monogr[1]/tei:imprint"/>
            <xsl:variable name="datum" select="replace($imprint/tei:date/@when, '-', '')"/>
            <xsl:variable name="seite">
                <xsl:choose>
                    <xsl:when test="contains($imprint/tei:biblScope[@unit='page'], '–')">
                        <xsl:value-of select="substring-before($imprint/tei:biblScope[@unit='page'], '–')"/>
                    </xsl:when>
                    <xsl:when test="contains($imprint/tei:biblScope[@unit='page'], '-')">
                        <xsl:value-of select="substring-before($imprint/tei:biblScope[@unit='page'], '-')"/>
                    </xsl:when>
                    <xsl:when test="contains($imprint/tei:biblScope[@unit='page'], ' ')">
                        <xsl:value-of select="substring-before($imprint/tei:biblScope[@unit='page'], ' ')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$imprint/tei:biblScope[@unit='page']"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:value-of select="concat('https://anno.onb.ac.at/cgi-content/anno?aid=nwj&amp;datum=', $datum, '&amp;seite=', $seite)"/>
           
        
        </xsl:element>
        
        

    </xsl:template>
    
    
</xsl:stylesheet>
