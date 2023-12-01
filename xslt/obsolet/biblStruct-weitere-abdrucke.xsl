<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <!-- das hier schaut ob in note[periodica] oder note[monographies analytic-refs sind] und
    baut neue listRef-->
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:template match="tei:biblStruct">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
        <xsl:copy-of select="@*|node()"/>
        <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="type">
                <xsl:text>neuneu</xsl:text>
            </xsl:attribute>
            <xsl:if test="tei:note[@type = 'periodica']/tei:bibl[tei:title[@level='a']/@ref] or 
                tei:note[@type = 'monographies']/tei:bibl/tei:title[@level = 'a' and @ref] or 
                tei:ref[@type = 'abdrucke']/tei:listRef/tei:ptr">
            <xsl:element name="listRef" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:for-each select="tei:note[@type = 'periodica']/tei:bibl[tei:title[@level='a']/@ref]">
                    <xsl:element name="ptr" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>textref</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="tei:title[@level='a']/@ref"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
                <xsl:for-each
                    select="tei:note[@type = 'monographies']/tei:bibl/tei:title[@level = 'a' and @ref]">
                    <xsl:element name="ptr" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>textref</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="@ref"/>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
                <xsl:copy-of select="tei:ref[@type = 'abdrucke']/tei:listRef/tei:ptr"/>
            </xsl:element>
            </xsl:if>
        </xsl:element>
        </xsl:element>
            
    </xsl:template>
</xsl:stylesheet>
