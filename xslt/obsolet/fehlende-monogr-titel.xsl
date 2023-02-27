<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei"
    xmlns:foo="whatever">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:param name="works"
        select="document('../../listbibl.xml')/tei:TEI/tei:text/tei:body/tei:listBibl"/>
    <xsl:key name="work-lookup" match="tei:bibl"
        use="@xml:id"/>
    
 <xsl:template match="tei:monogr/tei:title[.='']">
     <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
         <xsl:copy-of select="@*"/>
         <xsl:choose>
             <xsl:when test="key('work-lookup', @ref, $works)">
                 <xsl:value-of select="key('work-lookup', @ref, $works)/tei:title[@type='main'][1]"/>
             </xsl:when>
             <xsl:otherwise>
                 <xs:text>ARSCHBACKE</xs:text>
             </xsl:otherwise>
         </xsl:choose>
         
         
         
     </xsl:element>
     
     
     
 </xsl:template>
    
    
    
    
</xsl:stylesheet>
