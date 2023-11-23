<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="tei:note[@type = 'toc']">
        <xsl:if test="descendant::tei:desc[1]">
        <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>toc</xsl:text>
            </xsl:attribute>
            <xsl:for-each select="tei:desc">
                <xsl:sort select="tokenize(@ana, '–')[1]" data-type="number"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:element>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
