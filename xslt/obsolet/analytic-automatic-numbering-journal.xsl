<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="textverzeichnis-kopie" select="document('../../textverzeichnis-kopie.xml')"/>
    <xsl:key name="textverzeichnis-abdrucke" match="tei:biblStruct"
        use="tei:monogr/tei:title[@level = 'j']/@ref"/>
    <xsl:template
        match="tei:note[@type = 'periodica']/tei:bibl[tei:title[@level = 'j' and @ref] and tei:title[@level = 'a' and not(@ref)] and tei:biblScope[@unit = 'page'] and tei:biblScope[@unit='issue'] and tei:biblScope[@unit='volume']]">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@* | node()[not(self::tei:title[@level = 'a'])]"/>
            <xsl:variable name="reff" select="tei:title[@level = 'j']/@ref"/>
            <xsl:variable name="seitenbereich" select="tei:biblScope[@unit = 'page']"/>
            <!--<xsl:variable name="datum" select="tei:date/@when"/>-->
            <xsl:variable name="jg" select="tei:biblScope[@unit = 'volume']"/>
            <xsl:variable name="issue" select="tei:biblScope[@unit = 'issue']"/>
            <xsl:variable name="eintrag"
                select="key('textverzeichnis-abdrucke', $reff, $textverzeichnis-kopie)[tei:monogr/tei:imprint[tei:biblScope[@unit = 'page'] = $seitenbereich and tei:biblScope[@unit = 'issue'] = $issue and tei:biblScope[@unit = 'volume'] = $jg]]"/>
            <xsl:if test="$eintrag/tei:analytic">
                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="level">
                        <xsl:text>sex</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="ref">
                        <xsl:value-of select="$eintrag/tei:analytic/tei:title[@level='a']/@ref"/>
                    </xsl:attribute>
                    <xsl:value-of select="$eintrag/tei:analytic/tei:title[@level='a']"/>
                </xsl:element>
            </xsl:if>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
