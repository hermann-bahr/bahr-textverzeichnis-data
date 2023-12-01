<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <!-- das hier stellt nachdrucke auf kommentar um, wenn die ref in den listref ptrs ist-->
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="tei:ptr[contains(@target, ' ')]">
        <xsl:variable name="type" select="@type"/>
        <xsl:for-each select="tokenize(@target, ' ')">
        <xsl:element name="ptr" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:value-of select="$type"/>
            </xsl:attribute>
            <xsl:attribute name="target">
                <xsl:value-of select="."/>
            </xsl:attribute>
        </xsl:element><xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>