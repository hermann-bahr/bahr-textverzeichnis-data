<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    
    
    <xsl:template match="tei:biblStruct[tei:ref[@type='abdrucke'] and (count(tei:note[@type='periodica']/tei:bibl) = count(tei:ref[@type='abdrucke']//tei:ptr))]/tei:note[@type='monographies']">
        <xsl:text disable-output-escaping="yes">&lt;!--</xsl:text>
         <xsl:copy-of select="."></xsl:copy-of>
        <xsl:text disable-output-escaping="yes">--&gt;</xsl:text>
        
        

    </xsl:template>
    
    
</xsl:stylesheet>
