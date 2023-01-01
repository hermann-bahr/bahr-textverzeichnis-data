<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="persons"
        select="document('../listperson.xml')/tei:TEI/tei:text/tei:body/tei:p/tei:listPerson"/>
    <xsl:key name="idno-lookup" match="tei:person"
        use="tei:idno[@type='HB-tv']"/>
  
  
    <xsl:template match="tei:ptr[@type='HB-tv']/@target">
        <xsl:attribute name="target">
            <xsl:choose>
                <xsl:when test="key('idno-lookup', replace(., '#',''), $persons)">
                    <xsl:value-of select="key('idno-lookup', replace(., '#',''), $persons)/tei:idno[@type='HB-tv'][1]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
