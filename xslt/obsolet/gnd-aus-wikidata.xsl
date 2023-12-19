<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="tei:idno[@type='wikidata']">
        <xsl:copy-of select="."/>
            <xsl:variable name="wikidata-entity">
                <xsl:choose>
                    <xsl:when test="starts-with(., 'Q')">
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:when>
                    <xsl:when test="starts-with(., 'https://www.wikidata.org/entity/')">
                        <xsl:value-of
                            select="normalize-space(substring-after(., 'https://www.wikidata.org/entity/'))"
                        />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of
                            select="normalize-space(concat('Q', tokenize(., 'Q')[last()]))"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="get-string" as="xs:string">
                <xsl:value-of
                    select="concat('https://www.wikidata.org/w/api.php?action=wbgetentities&amp;format=xml&amp;ids=', $wikidata-entity,'')"
                />
            </xsl:variable>
            <xsl:choose>
                <xsl:when
                    test="document($get-string)/descendant::property[@id = 'P227']/claim/mainsnak/datavalue[1]">
                    <xsl:variable name="gender"
                        select="document($get-string)/descendant::property[@id = 'P227']/claim[1]/mainsnak[1]/datavalue[1]/@value/data()"/>
                    
                        
                        
                            <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type"><xsl:text>gnd</xsl:text></xsl:attribute>
                                <xsl:value-of select="concat('https://d-nb.info/gnd/', $gender)"/>
                            </xsl:element>
                        
                    
                </xsl:when>
            </xsl:choose>
            <xsl:text>
</xsl:text>
        
    </xsl:template>
</xsl:stylesheet>
