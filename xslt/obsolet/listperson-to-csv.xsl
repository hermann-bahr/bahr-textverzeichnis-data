<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:output method="text"/>
    
    <xsl:template match="/*">
        <!-- Schreibe Header-Zeile -->
        <xsl:text>Element,Attribute,Text</xsl:text>
        <xsl:text>&#10;</xsl:text>
        
        <!-- Verarbeite alle Elemente und Attribute -->
        <xsl:apply-templates select="descendant-or-self::*"/>
    </xsl:template>
    
    <xsl:template match="*">
        <!-- Schreibe Elementname -->
        <xsl:value-of select="name()"/>
        <xsl:text>,</xsl:text>
        
        <!-- Schreibe Attributnamen und Werte -->
        <xsl:for-each select="@*">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="name()"/>
            <xsl:text>,"</xsl:text>
      <xsl:value-of select="."/>
    </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
        
        <!-- Schreibe Textinhalt, falls vorhanden -->
        <xsl:if test="normalize-space(.)">
            <xsl:text>,</xsl:text>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:text>&#10;</xsl:text>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
