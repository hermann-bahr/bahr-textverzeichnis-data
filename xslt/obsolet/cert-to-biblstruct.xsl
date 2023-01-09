<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:mam="whatever"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:person">
        <xsl:variable name="surname1" select="tei:persName[1]/tei:surname[1]"/>
        <xsl:variable name="forename1" select="tei:persName[1]/tei:forename[1]"/>
        <xsl:variable name="birth" select="tei:birth[1]/tei:date[1]"/>
        <xsl:variable name="death" select="tei:death[1]/tei:date[1]"/>
        <xsl:choose>
            <xsl:when test="preceding-sibling::tei:person[$surname1= tei:persName[1]/tei:surname[1] and
                $forename1 = tei:persName[1]/tei:forename[1] and tei:birth[1]/tei:date = $birth and
                tei:death/tei:date[1] = $death]"/>
            <xsl:otherwise>
                <xsl:element name="person" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:copy-of select="*"/>
                    <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>HB-tv</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="@xml:id"/>
                    </xsl:element>
                    <xsl:for-each select="following-sibling::tei:person[$surname1= tei:persName[1]/tei:surname[1] and
                        $forename1 = tei:persName[1]/tei:forename[1] and tei:birth[1]/tei:date = $birth and
                        tei:death/tei:date[1] = $death]">
                        <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>HB-tv</xsl:text>
                            </xsl:attribute>
                            <xsl:value-of select="@xml:id"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
                
                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>
