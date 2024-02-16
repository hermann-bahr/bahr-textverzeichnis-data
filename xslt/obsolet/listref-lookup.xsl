<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="alt-textverzeichnis" select="document('../../alt-textverzeichnis.xml')"/>
    <xsl:key name="listRef" match="//*:listBibl[1]/*:biblStruct" composite="no"
        use="@xml:id"/>
    
    <xsl:template match="tei:listRef[tei:ptr[@type='HB-tv']]">
        <xsl:variable name="xmlid" select="ancestor::tei:biblStruct[1]/@xml:id"/>
        <xsl:choose>
            <xsl:when test="key('listRef', $xmlid, $alt-textverzeichnis)/descendant::*:listRef">
                <xsl:copy-of select="key('listRef', $xmlid, $alt-textverzeichnis)/descendant::*:listRef"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="@*|*"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
</xsl:stylesheet>
