<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions" version="3.0">
    
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <!-- Entry template -->
    <xsl:template match="/">
        <!-- Collect distinct 'ref' and 'target' attribute values starting with 'pmb' -->
        <xsl:variable name="distinctValues" as="xs:string*">
            <xsl:sequence select="distinct-values(//*/@*[name()='ref' or name()='target'][starts-with(., 'pmb')]/tokenize(., ' '))"/>
        </xsl:variable>
        
        <!-- Iterate over distinct values and output them -->
        <xsl:for-each select="$distinctValues">
            <xsl:value-of select="replace(., 'pmb', '')"/>
            <xsl:text>&#x9;</xsl:text>
            <xsl:value-of select="concat('https://bahr-textverzeichnis.acdh.oeaw.ac.at/', ., '.html')"/>
            <!-- Add a newline after each value except the last -->
            <xsl:if test="position() != last()">
                <xsl:text>&#xa;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
