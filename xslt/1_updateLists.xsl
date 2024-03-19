<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    <!-- angewandt auf bestehende listperson.xml etc. -->
    
    
    <xsl:template match="tei:listPerson/tei:person[@xml:id]">
        <xsl:variable name="nummer" select="replace(@xml:id, 'pmb','')"/>
        <xsl:variable name="eintrag"
            select="fn:escape-html-uri(concat('https://pmb.acdh.oeaw.ac.at/apis/tei/person/', $nummer))"
            as="xs:string"/>
        <xsl:choose>
            <xsl:when test="doc-available($eintrag)">
                <xsl:variable name="entry" select="document($eintrag)"/>
                <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="replace($entry/*:person/@xml:id, 'person__', 'pmb')"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$entry/*:person/*" copy-namespaces="no"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="error">
                    <xsl:attribute name="type">
                        <xsl:text>person</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="$nummer"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
