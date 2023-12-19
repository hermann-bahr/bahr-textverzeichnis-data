<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
  
    <xsl:template match="tei:bibl">
        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:copy-of select="*[not(name()='idno')]"></xsl:copy-of>
            <xsl:if test="descendant::tei:idno">
                <xsl:element name="listBibl" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each select="descendant::tei:idno[starts-with(@subtype, 'vol')]">
                        <xsl:element name="bibl" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="biblScope">
                                <xsl:attribute name="unit">
                                    <xsl:text>volume</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="replace(@subtype, 'vol', '')"/>
                            </xsl:element>
                            <xsl:element name="biblScope">
                                <xsl:attribute name="unit">
                                    <xsl:text>page</xsl:text>
                                </xsl:attribute>
                                <xsl:value-of select="."/>
                            </xsl:element>
                            
                        </xsl:element>
                        
                        
                    </xsl:for-each>
                    
                    
                </xsl:element>
                
                
                
            </xsl:if>
            
        </xsl:element>
        
        
    </xsl:template>
  
</xsl:stylesheet>
