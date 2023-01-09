<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mam="nonTEI"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
   <xsl:template match="tei:keywords/tei:person[@ref]">
       <xsl:element name="ref" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="type">
               <xsl:text>pmb</xsl:text>
           </xsl:attribute>
           <xsl:value-of select="replace(@ref,'#', 'pmb')"/>           
       </xsl:element>
   </xsl:template>
   
    
</xsl:stylesheet>
