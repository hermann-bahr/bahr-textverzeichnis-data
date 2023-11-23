<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    <xsl:template match="tei:TEI">
        <xsl:variable name="folderURI" select="resolve-uri('.', base-uri())"/>
        <xsl:for-each select="tei:text/tei:body/tei:listBibl/tei:biblStruct">
            <xsl:variable name="correspondence-nummer" select="@xml:id"/>
            <xsl:variable name="dateiname" select="concat($correspondence-nummer, '.xml')"/>
            <xsl:result-document indent="true" href="./data/editions/{$dateiname}">
                <xsl:element name="TEI" namespace="http://www.tei-c.org/ns/1.0">
                    <xsl:namespace name="tei">
                        <xsl:text>http://www.tei-c.org/ns/1.0</xsl:text>
                    </xsl:namespace>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="$dateiname"/>
                    </xsl:attribute>
                    <xsl:if test="@prev">
                        <xsl:attribute name="prev">
                            <xsl:value-of select="@prev"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@next">
                        <xsl:attribute name="next">
                            <xsl:value-of select="@next"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="teiHeader"
                        inherit-namespaces="true">
                        <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="fileDesc"
                            inherit-namespaces="true">
                            <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="titleStmt"
                                inherit-namespaces="true">
                                <xsl:element namespace="http://www.tei-c.org/ns/1.0" name="title"
                                    inherit-namespaces="true">
                                    <xsl:attribute name="level">
                                        <xsl:text>s</xsl:text>
                                    </xsl:attribute>
                                    <xsl:text>Hermann Bahr – Textverzeichnis</xsl:text>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:attribute name="level">
                                        <xsl:text>a</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="descendant::tei:title[1]"/>
                                </xsl:element>
                                <xsl:element name="title" namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:attribute name="type">
                                        <xsl:text>iso-date</xsl:text>
                                    </xsl:attribute>
                                    <xsl:value-of select="descendant::tei:date[1]/@when"/>
                                </xsl:element>
                                <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0"
                                        inherit-namespaces="true">
                                        <xsl:text>providing the content</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0"
                                        inherit-namespaces="true">
                                        <xsl:text>Martin Anton Müller</xsl:text>
                                    </xsl:element>
                                </xsl:element>
                                <xsl:element name="respStmt" namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:element name="resp" namespace="http://www.tei-c.org/ns/1.0"
                                        inherit-namespaces="true">
                                        <xsl:text>converted to XML encoding</xsl:text>
                                    </xsl:element>
                                    <xsl:element name="name" namespace="http://www.tei-c.org/ns/1.0"
                                        inherit-namespaces="true">
                                        <xsl:text>Martin Anton Müller</xsl:text>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                            <xsl:element name="publicationStmt"
                                namespace="http://www.tei-c.org/ns/1.0" inherit-namespaces="true">
                                <xsl:element name="publisher"
                                    namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:text>Austrian Centre for Digital Humanities and Cultural
                                    Heritage (ACDH-CH)</xsl:text>
                                </xsl:element>
                                <xsl:element name="date" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:value-of select="current-date()"/>
                                </xsl:element>
                                <xsl:element name="idno" namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:attribute name="type">
                                        <xsl:text>URI</xsl:text>
                                       
                                    </xsl:attribute>
                                    <xsl:text>https://id.acdh.oeaw.ac.at/bahr-textverzeichnis/</xsl:text>
                                    <xsl:value-of select="$dateiname"/>
                                </xsl:element>
                                
                            </xsl:element>
                            <xsl:element name="sourceDesc"
                                namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:element name="p" namespace="http://www.tei-c.org/ns/1.0">
                                    <xsl:text>Bibliografische Angaben eines in Druck erschienen Texts von
                                    Bahr</xsl:text>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                        
                    </xsl:element>
                    <xsl:element name="text" namespace="http://www.tei-c.org/ns/1.0">
                        <xsl:element name="body" namespace="http://www.tei-c.org/ns/1.0">
                            <xsl:element name="div" namespace="http://www.tei-c.org/ns/1.0">
                                <xsl:attribute name="type">
                                    <xsl:text>bibliografische-angabe</xsl:text>
                                </xsl:attribute>
                                <xsl:element name="biblStruct"
                                    namespace="http://www.tei-c.org/ns/1.0"
                                    inherit-namespaces="true">
                                    <xsl:copy-of select="@* | *" copy-namespaces="false"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
