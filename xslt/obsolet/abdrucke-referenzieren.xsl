<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:note[@type='monographies']/tei:bibl[not(child::*[3]) and child::tei:title[@level='m']/@ref and tei:biblScope[@unit='page']]">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:attribute name="mmid">
                <xsl:value-of select="tei:title[@level='m']/@ref"/>
                <xsl:value-of select="concat('_p', tei:biblScope[@unit='page'])"/>
            </xsl:attribute>
            <xsl:copy-of select="*"></xsl:copy-of>
        </xsl:element>
        
    </xsl:template>
    
  <!--  <xsl:template match="tei:note[@type='periodica']/tei:bibl[tei:title[@level='j']]">
       <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
           <xsl:attribute name="mid">
               <xsl:value-of select="tei:title[@level='j']/@ref"/>
               <xsl:value-of select="concat('_d', tei:date)"/>
               <xsl:value-of select="concat('_j', tei:biblScope[@unit='jg'])"/>
               <xsl:value-of select="concat('_v', tei:biblScope[@unit='vol'])"/>
               <xsl:value-of select="concat('_n', tei:biblScope[@unit='nr'])"/>
               <xsl:value-of select="concat('_i', tei:biblScope[@unit='issue'])"/>
               <xsl:value-of select="concat('_p', tei:biblScope[@unit='page'])"/>
           </xsl:attribute>
           <xsl:copy-of select="*"></xsl:copy-of>
       </xsl:element>
   </xsl:template>
    
    <xsl:template match="tei:biblStruct[tei:monogr/tei:title/@level='j']">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="mid">
                <xsl:value-of select="tei:monogr/tei:title[@level='j']/@ref"/>
                <xsl:value-of select="concat('_d', tei:monogr/tei:imprint/tei:date)"/>
                <xsl:value-of select="concat('_j', tei:monogr/tei:imprint/tei:biblScope[@unit='jg'])"/>
                <xsl:value-of select="concat('_v', tei:monogr/tei:imprint/tei:biblScope[@unit='vol'])"/>
                <xsl:value-of select="concat('_n', tei:monogr/tei:imprint/tei:biblScope[@unit='nr'])"/>
                <xsl:value-of select="concat('_i', tei:monogr/tei:imprint/tei:biblScope[@unit='issue'])"/>
                <xsl:value-of select="concat('_p', tei:monogr/tei:imprint/tei:biblScope[@unit='page'])"/>
            </xsl:attribute>
            <xsl:copy-of select="*"/>
            
            
        </xsl:element>
        
        
    </xsl:template>-->
    
</xsl:stylesheet>
