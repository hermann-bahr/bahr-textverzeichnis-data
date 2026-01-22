<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0">

    <xsl:output method="xml" indent="yes"/>

    <!-- Identity template: copy everything -->
    <xsl:template match="@* | node()">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Fix elements with empty xmlns="" by putting them in TEI namespace -->
    <xsl:template match="*[namespace-uri() = '']">
        <xsl:element name="{local-name()}" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:apply-templates select="@* | node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
