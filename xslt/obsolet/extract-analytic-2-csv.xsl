<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:output indent="no" method="text" encoding="utf-8" omit-xml-declaration="true"/>
    
    <xsl:template match="tei:listBibl">
        <xsl:text>ID;date_iso;date_written;title;autor-nr;werkbeziehung;label_1146;label_1235;metainfo-notes;label_1214;label_1214&#xA;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct">
        <xsl:value-of select="@xml:id"/><xsl:text>;</xsl:text>
        <xsl:value-of select="tei:date/@when"/><xsl:text>;</xsl:text>
        <xsl:text>"</xsl:text><xsl:value-of select="tei:date"/><xsl:text>";"</xsl:text>
        <xsl:value-of select="tei:analytic/tei:title"/><xsl:text>";</xsl:text>
        <xsl:choose>
            <xsl:when test="tei:analytic/tei:author[2]">
                <xsl:text>10815;</xsl:text>
                <xsl:text>1224;;</xsl:text><!-- Bahr hat einen Beitrag geschaffen -->
            </xsl:when>
            <xsl:when test="tei:analytic[not(child::tei:author) and not(contains(@subtype, 'Zweifelhafte'))]">
                <xsl:text>10815;</xsl:text>
                <xsl:text>1050;;</xsl:text><!-- hat anonym veröffentlicht -->
            </xsl:when>
            <xsl:when test="tei:analytic/tei:author[@ref='pmb10815' and . ='Bahr, Hermann']"><!-- normaler Name Bahr -->
                <xsl:text>10815;</xsl:text>
                <xsl:text>1049;;</xsl:text><!-- hat geschaffen -->
            </xsl:when>
            <xsl:when test="tei:analytic/tei:author[@ref='pmb10815' and contains(., '. ') and string-length(.) &lt; 5]"><!-- Kürzel -->
                <xsl:text>10815;</xsl:text>
                <xsl:text>1587;</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="tei:analytic/tei:author"/><xsl:text>";</xsl:text>
            </xsl:when>
            <xsl:when test="tei:analytic/tei:author[@ref='pmb10815']"><!-- Pseudonym -->
                <xsl:text>10815;</xsl:text>
                <xsl:text>1051;</xsl:text>
                <xsl:text>"</xsl:text><xsl:value-of select="tei:analytic/tei:author"/><xsl:text>";</xsl:text>
            </xsl:when>
            <xsl:when test="tei:analytic/tei:author">
                <xsl:value-of select="replace(tei:analytic/tei:author/@ref, 'pmb', '')"/><xsl:text>;</xsl:text>
                <xsl:text>1049;;</xsl:text><!-- hat geschaffen -->
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>;;;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>"</xsl:text><xsl:copy-of select="normalize-space(tei:note[@type][1])"/><xsl:text>";</xsl:text>
        <xsl:text>"</xsl:text><xsl:copy-of select="normalize-space(tei:note[not(@type)][1])"/><xsl:text>";</xsl:text>
        <xsl:value-of select="normalize-space(tei:ref[@type='URL'][1])"/><xsl:text>;</xsl:text>
        <xsl:value-of select="normalize-space(tei:ref[@type='URL'][2])"/><xsl:text></xsl:text>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
    
    
    
    <xsl:template match="tei:TEI">
        <xsl:apply-templates select="descendant::tei:body/descendant::tei:listBibl"></xsl:apply-templates>
    </xsl:template>
    
    
</xsl:stylesheet>
