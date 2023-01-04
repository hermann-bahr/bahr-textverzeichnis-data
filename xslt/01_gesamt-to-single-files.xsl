<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:template match="tei:TEI">
        <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
        <xsl:for-each
            select="tei:text/tei:body/tei:listBibl/tei:biblStruct">
            <xsl:variable name="correspondence-nummer"
                select="@xml:id"/>
            <xsl:variable name="dateiname" select="concat($correspondence-nummer, '.xml')"/>
            <xsl:result-document indent="true" href="./data/editions/{$dateiname}">
                <TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
                    >
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
                                    <xsl:attribute name="type">
                                        <xsl:text>iso-date</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="descendant::tei:date[1]/@when"/>
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
                            <div type="bibliografische-angabe">
                            <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:copy-of select="@*|*" copy-namespaces="false" />
                            </xsl:element>
                            </div>
                        </body>
                    </text>
                </TEI>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
   
</xsl:stylesheet>
