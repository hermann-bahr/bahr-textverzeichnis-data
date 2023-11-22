<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct">
        <xsl:copy>
            <xsl:apply-templates select="@*[not(name()='sortKey')]"/>
            <xsl:attribute name="prev">
                <xsl:value-of select="preceding-sibling::tei:biblStruct[1]/@xml:id"/>
            </xsl:attribute>
            <xsl:attribute name="next">
                <xsl:value-of select="following-sibling::tei:biblStruct[1]/@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>