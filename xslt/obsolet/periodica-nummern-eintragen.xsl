<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="listperiodica" select="document('../../data/indices/listperiodica.xml')"/>
    <xsl:key name="periodica-abdrucke" match="tei:bibl/tei:title[@level='j']" use="normalize-space(substring-before(text(), '.'))"/>
    <xsl:template match="tei:title[@level='j' and not(@ref)]">
        <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="sex">
                <xsl:value-of select="key('periodica-abdrucke', normalize-space(.) , $listperiodica)/@ref"/>
            </xsl:attribute>
            <xsl:copy-of select="text()"/>
            
            
            
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
