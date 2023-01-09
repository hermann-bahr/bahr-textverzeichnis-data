<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
    <xsl:param name="persons"
        select="document('listperson.xml')/tei:TEI/tei:text/tei:body/tei:div/tei:listPerson"/>
    <xsl:key name="person-lookup" match="tei:person"
        use="concat(normalize-space(tei:persName[1]/tei:surname[1]), normalize-space(tokenize(tei:persName[1]/tei:forename[1], ' ')[1]))"/>
    <xsl:key name="author-lookup" match="tei:person"
        use="concat(normalize-space(tei:persName[1]/tei:surname[1]), ', ', normalize-space(tokenize(tei:persName[1]/tei:forename[1], ' ')[1]))"/>
    <!-- <xsl:key name="person-lookup" match="tei:person" use="concat(normalize-space(tei:persName[1]/tei:surname[1]),normalize-space(tokenize(tei:persName[1]/tei:forename[1], ' ')[1]), tokenize(tei:death/tei:date, '-')[1])"/>
   -->
    <!-- Genaueste:
        <xsl:key name="person-lookup" match="tei:person" use="concat(normalize-space(tei:persName[1]/tei:surname[1]),normalize-space(tokenize(tei:persName[1]/tei:forename[1], ' ')[1]), tokenize(tei:birth/tei:date, '-')[1], tokenize(tei:death/tei:date, '-')[1])"/>-->
    <xsl:template match="tei:person[not(@ref) or @ref='']">
        <xsl:variable name="personenname"
            select="concat(tei:persName[1]/tei:surname[1], tokenize(tei:persName[1]/tei:forename[1], ' ')[1])"
            as="xs:string"/>
        <xsl:element name="tei:person">
            <xsl:if test="key('person-lookup', $personenname, $persons)/@xml:id">
                <xsl:attribute name="ref">
                    <xsl:value-of
                        select="concat('#', key('person-lookup', $personenname, $persons)[1]/@xml:id)"
                    />
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    
    <xsl:template match="tei:author[not(@ref) or @ref='']">
        <xsl:variable name="personenname"
            select="."
            as="xs:string"/>
        <xsl:element name="tei:author">
            <xsl:if test="key('author-lookup', $personenname, $persons)/@xml:id">
                <xsl:attribute name="ref">
                    <xsl:value-of
                        select="concat('#', key('author-lookup', $personenname, $persons)[1]/@xml:id)"
                    />
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
