<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
  <xsl:param name="konkordanz" select="document('../../data/indices/konkordanz.xml')"/>
    <xsl:key name="konki" match="row" use="identifier"/>
    
    <xsl:template match="tei:listBibl">
        <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="tei:bibl">
                <xsl:sort lang="de" select="replace(replace(replace(tei:title, '^Die', ''), '^Der', ''), '^Das', '')"/>
            </xsl:apply-templates>
        </xsl:element>
        
        
    </xsl:template>
    
  
</xsl:stylesheet>
