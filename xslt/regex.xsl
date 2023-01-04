<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
   
   <xsl:template match="tei:note[@type='periodica']/tei:bibl/tei:title[contains(., '«')]/text()">
       
       <xsl:analyze-string select="." regex="«">
           <xsl:matching-substring>
               <xsl:text>YXZZU</xsl:text>
           </xsl:matching-substring>
           <xsl:non-matching-substring>
               <xsl:value-of select="."/>
           </xsl:non-matching-substring>
       </xsl:analyze-string>
       
       
   </xsl:template>
    
   
</xsl:stylesheet>
