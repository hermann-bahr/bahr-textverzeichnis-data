<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="works"
        select="document('bahr-in-pmb.xml')"/>
    <xsl:key name="datum-lookup" match="row" composite="yes" 
        use="start_date, substring(title, 1, 10)" />
    <xsl:key name="datum-written-lookup" match="row" composite="yes"
        use="start_date_written, substring(title, 1, 10)" />
    
    <xsl:template match="tei:biblStruct[(not(@ref) or @ref='') and tei:analytic and not(@dasch)]">
        <!-- Annahme: Wenn ein Tag nur einen Eintrag hat, stimmt das -->
        <xsl:variable name="datum" select="tei:monogr[1]/tei:imprint[1]/tei:date[1]/@when"/>
        <xsl:variable name="titel" select="substring(tei:analytic[1]/tei:title[1], 1, 10)"/>
        <xsl:variable name="ref-datum" select="key('datum-lookup', ($datum, $titel), $works)[1]/ID"/>
        <xsl:variable name="ref-datum-uneindeutig" select="key('datum-lookup', ($datum, $titel), $works)[2]/ID"/>
        <xsl:choose>
            <xsl:when test="string-length($ref-datum) &gt; 1 and not(string-length($ref-datum-uneindeutig) &gt; 1)">
                <xsl:copy>
                    <xsl:attribute name="dasch">
                        <xsl:value-of select="concat('#', $ref-datum)"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <xsl:template match="tei:biblStruct[(not(@ref) or @ref='') and tei:monogr[1]/tei:title[@level='m'] and not(tei:analytic) and not(@dasch)]">
        <!-- Annahme: Wenn ein Tag nur einen Eintrag hat, stimmt das -->
        <xsl:variable name="datum" select="tei:monogr[1]/tei:imprint[1]/tei:date[1]"/>
        <xsl:variable name="titel" select="substring(tei:monogr[1]/tei:title[@level='m'], 1, 10)"/>
        <xsl:variable name="ref-datum" select="key('datum-written-lookup', ($datum, $titel), $works)[1]/ID"/>
        <xsl:variable name="ref-datum-uneindeutig" select="key('datum-written-lookup', ($datum, $titel), $works)[2]/ID"/>
        <xsl:choose>
            <xsl:when test="string-length($ref-datum) &gt; 1 and not(string-length($ref-datum-uneindeutig) &gt; 1)">
                <xsl:copy>
                    <xsl:attribute name="dasch">
                        <xsl:value-of select="concat('#', $ref-datum)"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
