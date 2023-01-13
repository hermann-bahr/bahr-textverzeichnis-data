<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    
    <xsl:param name="uris" select="document('../../uris.xml')"/>
    <xsl:key name="uri-lookup" match="item" use="URL[@type]"
        ></xsl:key>
    
    
    
    <xsl:template match="tei:biblStruct[@sameAs and not(@sameAs='nach1939')]">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*[not(name()='xml:id' or name()='sameAs')]"/>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="@sameAs"/>
            </xsl:attribute>
            <xsl:attribute name="sameAs">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:copy-of select="*" copy-namespaces="false"/>
            
            
        </xsl:element>
        
        
    </xsl:template>
    
  
  
  
    

</xsl:stylesheet>
