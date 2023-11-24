<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="bibListDoc" select="document('../../data/indices/listBibliografie.xml')"/>
    <xsl:template match="tei:note[@type = 'monographies']//tei:title[@level = 'm' and not(@ref)]">
        <xsl:variable name="matchingTitle"
            select="$bibListDoc//tei:list/tei:item[tei:title[text() = current()/text()]]/@corresp" as="xs:string?"/>
        <xsl:variable name="matchingTitle2"
            select="$bibListDoc//tei:list/tei:item[tei:title[text() = current()/text()]][2]/@corresp" as="xs:string?"/>
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:choose>
                <xsl:when test="normalize-space($matchingTitle) = '' or empty($matchingTitle)"/>
                <xsl:when test="$matchingTitle2 != ''"/>
                <xsl:when test=". = 'Essays'"/>
                <xsl:otherwise>
                    <xsl:attribute name="ref" select="$matchingTitle"/>
                </xsl:otherwise>
            </xsl:choose>
            
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
