<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="text"/>
    
    <xsl:template match="*:TEI">
        <!-- Schreibe Header-Zeile -->
        <xsl:text>Element,idno</xsl:text>
        <xsl:text>&#10;</xsl:text>
        
        <!-- Verarbeite alle Elemente und Attribute -->
        <xsl:apply-templates select="descendant-or-self::*:bibl"/>
    </xsl:template>
    
    <xsl:template match="*:bibl">
        
        <xsl:variable name="xmlid" select="@xml:id"/>
        <xsl:for-each select="*:idno[starts-with(., 'https://bahr-textverzeichnis')]">
        <!-- Schreibe Elementname -->
            <xsl:value-of select="concat('&quot;', replace($xmlid, 'pmb', ''), '&quot;')"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&#10;</xsl:text>
            
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
