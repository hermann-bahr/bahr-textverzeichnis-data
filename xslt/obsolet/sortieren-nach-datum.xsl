<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:template match="tei:listBibl">
        <xsl:copy>
            <xsl:for-each select="tei:biblStruct">
                <xsl:sort select="@sortKey" data-type="text"/>
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:biblStruct">
        <xsl:copy>
            <xsl:attribute name="sortKey" select="descendant::tei:date[@when][1]/@when"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>