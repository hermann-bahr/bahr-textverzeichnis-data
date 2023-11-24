<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:foo="whatever" version="3.0"
    exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:param name="listperiodica" select="document('../../data/indices/listperiodica.xml')"/>
    <xsl:template match="root">
        <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
        <xsl:for-each
            select="$listperiodica/descendant::tei:text[1]/tei:body[1]/tei:listBibl[1]/tei:bibl/tei:title[1]">
            <xsl:variable name="periodica-nummer" select="@ref"/>
            <xsl:variable name="dateiname" select="concat('toc_', $periodica-nummer, '.xml')"/>
            <xsl:variable name="Periodikaname" select="."/>
            <xsl:result-document indent="true" href="../../tocs/{$dateiname}">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.tei-c.org/ns/1.0        http://diglib.hab.de/rules/schema/tei/P5/v2.3.0/tei-p5-transcr.xsd">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title level="s">Hermann Bahr - Textverzeichnis</title>
                                <xsl:element name="title">
                                    <xsl:attribute name="level">
                                        <xsl:text>a</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="$Periodikaname"/>
                                </xsl:element>
                                <respStmt>
                                    <resp>providing the content</resp>
                                    <name>Martin Anton Müller</name>
                                </respStmt>
                                <respStmt>
                                    <resp>converted to XML encoding</resp>
                                    <name>Martin Anton Müller</name>
                                </respStmt>
                            </titleStmt>
                            <publicationStmt>
                                <publisher>Austrian Centre for Digital Humanities and Cultural
                                    Heritage (ACDH-CH)</publisher>
                                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="current-date()"/>
                                </xsl:element>
                                <idno type="URI">
                                    <xsl:text>https://id.acdh.oeaw.ac.at/bahr-textverzeichnis-data/tocs/</xsl:text>
                                    <xsl:value-of select="$dateiname"/>
                                </idno>
                            </publicationStmt>
                            <sourceDesc>
                                <p>Verzeichnis von Texten nach Periodikum</p>
                            </sourceDesc>
                        </fileDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <xsl:element name="list" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:for-each
                                    select="collection(concat($folderURI, '../../data/editions/?select=pmb*.xml;recurse=yes'))[descendant::tei:biblStruct/tei:monogr/tei:title[@level = 'j']/@ref = $periodica-nummer]/node()">
                                    <xsl:element name="item" namespace="http://www.tei-c.org/ns/1.0">
                                        <xsl:attribute name="corresp">
                                            <xsl:value-of select="replace(@xml:id, '.xml', '')"
                                            />
                                        </xsl:attribute>
                                        <xsl:copy-of
                                            select="descendant::tei:biblStruct/tei:analytic/tei:title"
                                            copy-namespaces="false"/>
                                        <xsl:copy-of
                                            select="descendant::tei:biblStruct/tei:monogr/descendant::tei:date[1]"
                                            copy-namespaces="false"/>
                                    </xsl:element>
                                </xsl:for-each>
                            </xsl:element>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
