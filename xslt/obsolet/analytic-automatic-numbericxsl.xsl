<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="textverzeichnis-kopie" select="document('../../textverzeichnis-kopie.xml')"/>
    <xsl:key name="textverzeichnis-abdrucke" match="tei:biblStruct[tei:note[@type='toc']]" use="@xml:id"/>
    <xsl:template match="tei:note[@type='monographies']/tei:bibl[tei:title[@level='m' and @ref] and tei:title[@level='a' and not(@ref)] and not(author) and tei:biblScope[@unit='page']]">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|node()[not(self::tei:title[@level='a'])]"/>
            <xsl:variable name="reff" select="tei:title[@level='m']/@ref"/>
            <xsl:variable name="seitenbereich" select="tei:biblScope[@unit='page']"/>
            <xsl:if test="key('textverzeichnis-abdrucke', $reff, $textverzeichnis-kopie)/tei:note[@type='toc']/tei:desc[@ana= $seitenbereich]">
                <xsl:variable name="eintrag" select="key('textverzeichnis-abdrucke', $reff, $textverzeichnis-kopie)/tei:note[@type='toc']/tei:desc[@ana= $seitenbereich]"/>
                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="level">
                        <xsl:text>sex</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="ref">
                        <xsl:value-of select="$eintrag/@corresp"/>
                    </xsl:attribute>
                    <xsl:value-of select="tei:title[@level='a']"/>
                </xsl:element>
                
            </xsl:if>
            
            
            
            
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
