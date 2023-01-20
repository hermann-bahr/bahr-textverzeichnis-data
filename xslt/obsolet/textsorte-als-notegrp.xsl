<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:template match="tei:biblStruct">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*"/>
            <xsl:element name="noteGrp" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>keywords</xsl:text>
                </xsl:attribute>
            <xsl:for-each select="tokenize(@type, '_')">
                <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">
                        <xsl:value-of select="."/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </xsl:element>
            </xsl:for-each>
                <xsl:for-each select="tokenize(@subtype, '_')">
                    <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="subtype">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
            <xsl:for-each select="tei:biblStruct/tei:monogr/tei:title[@level = 'm' and not(@ref) and not(ancestor::tei:biblStruct/@sameAs='nach1939')]">
                <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="."/>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
