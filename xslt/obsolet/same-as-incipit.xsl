<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:template match="tei:biblStruct[(string-length(tei:note[@type='incipit']) &gt; 10) and ((tei:note[@type='incipit']/normalize-space(.)=preceding-sibling::tei:biblStruct/tei:note[@type='incipit']/normalize-space(.)) or (tei:note[@type='incipit']/normalize-space(.)=following-sibling::tei:biblStruct/tei:note[@type='incipit']/normalize-space(.)))]">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*"/>
            <xsl:variable name="incipit" select="tei:note[@type='incipit'][1]/normalize-space(.)" as="xs:string"/>
            <xsl:element name="ref" >
                <xsl:attribute name="type">
                    <xsl:text>abdrucke</xsl:text>
                </xsl:attribute>
                <xsl:element name="listRef" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each select="preceding-sibling::tei:biblStruct[tei:note[@type='incipit'][1]/normalize-space(.) = $incipit]">
                    <xsl:element name="ptr" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:attribute name="type">
                            <xsl:text>textref</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="target">
                            <xsl:value-of select="@xml:id"/>
                        </xsl:attribute>
                        <xsl:value-of select="tei:note[@type='biographical-statement']"/>
                    </xsl:element>
                    
                    
                </xsl:for-each>
                </xsl:element>
                <xsl:element name="listRef" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:for-each select="following-sibling::tei:biblStruct[tei:note[@type='incipit'][1]/normalize-space(.) = $incipit]">
                        <xsl:element name="ptr" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:attribute name="type">
                                <xsl:text>textref</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="target">
                                <xsl:value-of select="@xml:id"/>
                            </xsl:attribute>
                            <xsl:value-of select="tei:note[@type='biographical-statement']"/>
                        </xsl:element>
                        
                        
                    </xsl:for-each>
                </xsl:element>
                <xsl:text></xsl:text>
            </xsl:element>
            
            
        </xsl:element>
        
        
    </xsl:template>
    
    
</xsl:stylesheet>
