<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
   
    <xsl:template match="tei:note/tei:bibl/text()">
        <xsl:analyze-string select="." regex=",\s(\d+)\s\((\d{{4}})\)">
            <xsl:matching-substring>
                <xsl:element name="biblScope" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="unit">
                        <xsl:text>jg</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="regex-group(1)"/>
                </xsl:element>
                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:attribute name="type">
                        <xsl:text>year</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="regex-group(2)"/>
                </xsl:element>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
        
    </xsl:template>
   
   
   <!--<xsl:template match="tei:note[@type='periodica']/tei:bibl/text()">
       <xsl:analyze-string select="." regex=",\s(\d+)\s\((\d{{4}})\)\s#(\d+),\s(\d+–\d+)">
           <xsl:matching-substring>
               <xsl:element name="biblScope" namespace="http://www.tei-c.org/ns/1.0">
                   <xsl:attribute name="unit">
                       <xsl:text>jg</xsl:text>
                   </xsl:attribute>
                   <xsl:value-of select="regex-group(1)"/>
               </xsl:element>
               <xsl:element name="year">
                   <xsl:value-of select="regex-group(2)"/>
               </xsl:element>
               <xsl:element name="biblScope" namespace="http://www.tei-c.org/ns/1.0">
                   <xsl:attribute name="unit">
                       <xsl:text>issue</xsl:text>
                   </xsl:attribute>
                   <xsl:value-of select="regex-group(3)"/>
               </xsl:element>
               <xsl:element name="biblScope" namespace="http://www.tei-c.org/ns/1.0">
                   <xsl:attribute name="unit">
                       <xsl:text>page</xsl:text>
                   </xsl:attribute>
                   <xsl:value-of select="regex-group(4)"/>
               </xsl:element>
           </xsl:matching-substring>
           <xsl:non-matching-substring>
               <xsl:value-of select="."/>
           </xsl:non-matching-substring>
       </xsl:analyze-string>
       
       
   </xsl:template>-->
    
   
</xsl:stylesheet>
