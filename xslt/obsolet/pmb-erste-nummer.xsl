<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
   <xsl:param name="listPerson" select="document('../../data/indices/listperson.xml')"/>
   <xsl:key name="person-id-match" match="tei:person" use="tei:idno[@subtype='pmb']"/>
   
   
   <xsl:template match="tei:ptr[@type='pmb']/@target">
       <xsl:variable name="pmb-uri" select="concat('https://pmb.acdh.oeaw.ac.at/entity/', replace(., 'pmb', ''), '/')"/>
       <xsl:attribute name="target">
           <xsl:variable name="match" select="key('person-id-match', $pmb-uri, $listPerson)/@xml:id"/>
           <xsl:choose>
               <xsl:when test="$match != ''">
                   <xsl:value-of select="$match"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:value-of select="concat('CHECK_', .)"/>
               </xsl:otherwise>
           </xsl:choose>
       </xsl:attribute>
       
       
   </xsl:template>
   
  
  
  
    

</xsl:stylesheet>
