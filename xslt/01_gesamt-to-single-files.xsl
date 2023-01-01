<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns:foo="whatever"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:template match="tei:TEI">
        <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
        <xsl:for-each
            select="tei:text/tei:body/tei:listBibl/tei:biblStruct">
            <xsl:variable name="correspondence-nummer"
                select="@xml:id"/>
            <xsl:variable name="dateiname" select="concat('toc_', $correspondence-nummer, '.xml')"/>
            <xsl:result-document indent="true" href="../../editions/{$dateiname}">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.tei-c.org/ns/1.0        http://diglib.hab.de/rules/schema/tei/P5/v2.3.0/tei-p5-transcr.xsd">
                    <teiHeader>
                        <fileDesc>
                            <titleStmt>
                                <title level="s">Hermann Bahr – Textverzeichnis</title>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="level">
                                        <xsl:text>a</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="descendant::tei:title[1]"/>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:attribute name="when-iso">
                                        <xsl:value-of select="descendant::tei:biblStruct[1]/tei:date/@when"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="descendant::tei:biblStruct[1]/tei:date"/>
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
                                <publisher>Austrian Centre for Digital Humanities and Cultural Heritage (ACDH-CH)</publisher>
                                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="current-date()"/>
                                </xsl:element>
                                <idno type="URI">
                                    <xsl:text>https://id.acdh.oeaw.ac.at/bahr-textverzeichnis/</xsl:text>
                                    <xsl:value-of select="$dateiname"/>
                                </idno>
                            </publicationStmt>
                            <sourceDesc>
                                <p>Bibliografische Angaben eines in Druck erschienen Texts von Bahr</p>
                            </sourceDesc>
                        </fileDesc>
                    </teiHeader>
                    <text>
                        <body>
                            <xsl:copy-of select="@*|*" copy-namespaces="false" />
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
   
</xsl:stylesheet>
