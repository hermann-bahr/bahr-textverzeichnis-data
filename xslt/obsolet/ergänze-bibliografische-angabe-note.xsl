<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei"
    xmlns:foo="whatever">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="tei:biblStruct">
        <xsl:element name="biblStruct" namespace="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*|*"/>
            <xsl:element name="note" namespace="http://www.tei-c.org/ns/1.0">
                <xsl:attribute name="type">
                    <xsl:text>bibliographical-statement</xsl:text>
                </xsl:attribute>
                
                    <xsl:choose>
                        <!-- Zuerst Analytic -->
                        <xsl:when test="./tei:analytic">
                            <xsl:value-of select="foo:analytic-angabe(.)"/>
                            <xsl:text> </xsl:text>
                            <xsl:text>In: </xsl:text>
                            <xsl:value-of select="foo:monogr-angabe(./tei:monogr[last()])"/>
                        </xsl:when>
                        <!-- Jetzt abfragen ob mehrere monogr -->
                        <xsl:when test="count(./tei:monogr) = 2">
                            <xsl:value-of select="foo:monogr-angabe(./tei:monogr[last()])"/>
                            <xsl:text>. Band</xsl:text>
                            <xsl:text>: </xsl:text>
                            <xsl:value-of select="foo:monogr-angabe(./tei:monogr[1])"/>
                        </xsl:when>
                        <!-- Ansonsten ist es eine einzelne monogr -->
                        <xsl:otherwise>
                            <xsl:value-of select="foo:monogr-angabe(./tei:monogr[last()])"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="not(empty(./tei:monogr//tei:biblScope[@unit = 'sec']))">
                        <xsl:text>, Sec. </xsl:text>
                        <xsl:value-of select="./tei:monogr//tei:biblScope[@unit = 'sec']"/>
                    </xsl:if>
                <xsl:if test="not(empty(./tei:monogr//tei:biblScope[@unit = 'part']))">
                    <xsl:text>, Teil </xsl:text>
                    <xsl:value-of select="./tei:monogr//tei:biblScope[@unit = 'part']"/>
                </xsl:if>
                    <xsl:if test="not(empty(./tei:monogr//tei:biblScope[@unit = 'pp']))">
                        <xsl:text>, S. </xsl:text>
                        <xsl:value-of select="./tei:monogr//tei:biblScope[@unit = 'pp']"/>
                    </xsl:if>
                    <xsl:if test="not(empty(./tei:monogr//tei:biblScope[@unit = 'page']))">
                        <xsl:text>, S. </xsl:text>
                        <xsl:value-of select="./tei:monogr//tei:biblScope[@unit = 'page']"/>
                    </xsl:if>
                    <xsl:if test="not(empty(./tei:monogr//tei:biblScope[@unit = 'column']))">
                        <xsl:text>, Sp. </xsl:text>
                        <xsl:value-of select="./tei:monogr//tei:biblScope[@unit = 'column']"/>
                    </xsl:if>
                    <xsl:if test="not(empty(./tei:series))">
                        <xsl:text> (</xsl:text>
                            <xsl:value-of select="./tei:series/tei:title"/>
                        <xsl:if test="./tei:series/tei:biblScope">
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="./tei:series/tei:biblScope"/>
                        </xsl:if>
                        <xsl:text>)</xsl:text>
                    </xsl:if>
                    <xsl:text>.</xsl:text>
                
                
            </xsl:element>
            
            
            
            
        </xsl:element>
        
        
        
    </xsl:template>
    
    <xsl:function name="foo:monogr-angabe">
        <xsl:param name="monogr" as="node()"/>
        <xsl:choose>
            <xsl:when test="$monogr/tei:author[2]">
                <xsl:value-of select="foo:autor-rekursion($monogr, 1, count($monogr/tei:author))"/>
                <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:when test="$monogr/tei:author[1]">
                <xsl:value-of select="foo:vorname-vor-nachname($monogr/tei:author/text())"/>
                <xsl:text>: </xsl:text>
            </xsl:when>
        </xsl:choose><xsl:value-of select="normalize-space($monogr/tei:title)"/><xsl:if test="$monogr/tei:editor[1]">
            <xsl:text>. </xsl:text>
            <xsl:choose>
                <xsl:when test="$monogr/tei:editor[2]">
                    <!-- es gibt mehr als einen Herausgeber -->
                    <xsl:text>Hgg. </xsl:text>
                    <xsl:for-each select="$monogr/tei:editor">
                        <xsl:choose>
                            <xsl:when test="contains(., ', ')">
                                <xsl:value-of
                                    select="concat(substring-after(normalize-space(.), ', '), ' ', substring-before(normalize-space(.), ', '))"
                                />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="."/>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:choose>
                            <xsl:when test="position() = last()"/>
                            <xsl:when test="position() = last() - 1">
                                <xsl:text> und </xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>, </xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when
                    test="contains($monogr/tei:editor, 'Hg.') or contains($monogr/tei:editor, 'Hrsg.') or contains($monogr/tei:editor, 'erausge') or contains($monogr/tei:editor, 'Edited')">
                    <xsl:value-of select="$monogr/tei:editor"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Hg. </xsl:text>
                    <xsl:choose>
                        <xsl:when test="contains($monogr/tei:editor, ', ')">
                            <xsl:value-of
                                select="concat(substring-after(normalize-space($monogr/tei:editor), ', '), ' ', substring-before(normalize-space($monogr/tei:editor), ', '))"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$monogr/tei:editor"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if><xsl:if test="$monogr/tei:edition">
            <xsl:text>. </xsl:text>
            <xsl:value-of select="$monogr/tei:edition"/>
        </xsl:if><xsl:choose>
            <!-- Hier Abfrage, ob es ein Journal ist -->
            <xsl:when test="$monogr/tei:title[@level = 'j']">
                <xsl:value-of select="foo:jg-bd-nr($monogr)"/>
            </xsl:when>
            <!-- Im anderen Fall müsste es ein 'm' für monographic sein -->
            <xsl:otherwise>
                <xsl:if test="$monogr[child::tei:imprint]">
                    <xsl:text>. </xsl:text>
                    <xsl:value-of select="foo:imprint-in-index($monogr)"/>
                </xsl:if>
                <xsl:if test="$monogr/tei:biblScope/@unit = 'volume'">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$monogr/tei:biblScope[@unit = 'volume']"/>
                </xsl:if>
                <xsl:if test="$monogr/tei:biblScope/@unit = 'issue'">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="$monogr/tei:biblScope[@unit = 'issue']"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$monogr/tei:extent">
            <xsl:value-of select="concat(' (', normalize-space($monogr/tei:extent), ')')"/> 
        </xsl:if>
    </xsl:function>
    <xsl:function name="foo:imprint-in-index">
        <xsl:param name="monogr" as="node()"/>
        <xsl:variable name="imprint" as="node()" select="$monogr/tei:imprint"/>
        <xsl:choose>
            <xsl:when test="$imprint/tei:pubPlace != ''">
                <xsl:value-of select="$imprint/tei:pubPlace" separator=", "/>
                <xsl:choose>
                    <xsl:when test="$imprint/tei:publisher != ''">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="$imprint/tei:publisher"/>
                        <xsl:choose>
                            <xsl:when test="$imprint/tei:date != ''">
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$imprint/tei:date"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$imprint/tei:date != ''">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="$imprint/tei:date"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$imprint/tei:publisher != ''">
                        <xsl:value-of select="$imprint/tei:publisher"/>
                        <xsl:choose>
                            <xsl:when test="$imprint/tei:date != ''">
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$imprint/tei:date"/>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="$imprint/tei:date != ''">
                        <xsl:text>(</xsl:text>
                        <xsl:value-of select="$imprint/tei:date"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="foo:jg-bd-nr">
        <xsl:param name="monogr"/>
        <!-- Ist Jahrgang vorhanden, stehts als erstes -->
        <xsl:if test="$monogr//tei:biblScope[@unit = 'jg']">
            <xsl:text>, Jg. </xsl:text>
            <xsl:value-of select="$monogr//tei:biblScope[@unit = 'jg']"/>
        </xsl:if>
        <!-- Ist Band vorhanden, stets auch -->
        <xsl:if test="$monogr//tei:biblScope[@unit = 'volume']">
            <xsl:text>, Bd. </xsl:text>
            <xsl:value-of select="$monogr//tei:biblScope[@unit = 'volume']"/>
        </xsl:if>
        <!-- Jetzt abfragen, wie viel vom Datum vorhanden: vier Stellen=Jahr, sechs Stellen: Jahr und Monat, acht Stellen: komplettes Datum
              Damit entscheidet sich, wo das Datum platziert wird, vor der Nr. oder danach, oder mit Komma am Schluss -->
        <xsl:choose>
            <xsl:when test="string-length($monogr/tei:imprint/tei:date/@when) = 4">
                <xsl:text> (</xsl:text>
                <xsl:value-of select="$monogr/tei:imprint/tei:date"/>
                <xsl:text>)</xsl:text>
                <xsl:if test="$monogr//tei:biblScope[@unit = 'issue']">
                    <xsl:text> Nr. </xsl:text>
                    <xsl:value-of select="$monogr//tei:biblScope[@unit = 'issue']"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="string-length($monogr/tei:imprint/tei:date/@when) = 6">
                <xsl:if test="$monogr//tei:biblScope[@unit = 'issue']">
                    <xsl:text>, Nr. </xsl:text>
                    <xsl:value-of select="$monogr//tei:biblScope[@unit = 'issue']"/>
                </xsl:if>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="normalize-space(($monogr/tei:imprint/tei:date))"/>
                <xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="$monogr//tei:biblScope[@unit = 'issue']">
                    <xsl:text>, Nr. </xsl:text>
                    <xsl:value-of select="$monogr//tei:biblScope[@unit = 'issue']"/>
                </xsl:if>
                <xsl:if test="$monogr/tei:imprint/tei:date">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(($monogr/tei:imprint/tei:date))"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="foo:analytic-angabe">
        <xsl:param name="gedruckte-quellen" as="node()"/>
        <!--  <xsl:param name="vor-dem-at" as="xs:boolean"/><!-\- Der Parameter ist gesetzt, wenn auch der Sortierungsinhalt vor dem @ ausgegeben werden soll -\-><xsl:param name="quelle-oder-literaturliste" as="xs:boolean"/><!-\- Ists Quelle, kommt der Titel kursiv und der Autor Vorname Name -\->-->
        <xsl:variable name="analytic" as="node()" select="$gedruckte-quellen/tei:analytic"/>
        <xsl:choose>
            <xsl:when test="$analytic/tei:author[2]">
                <xsl:value-of
                    select="foo:autor-rekursion($analytic, 1, count($analytic/tei:author))"/>
                <xsl:text>: </xsl:text>
            </xsl:when>
            <xsl:when test="$analytic/tei:author[1]">
                <xsl:value-of select="foo:vorname-vor-nachname($analytic/tei:author)"/>
                <xsl:text>: </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="not($analytic/tei:title/@type = 'j')">
                <span style="textstyle: italic">
                    <xsl:value-of select="normalize-space($analytic/tei:title)"/>
                    <xsl:choose>
                        <xsl:when test="ends-with(normalize-space($analytic/tei:title), '!')"/>
                        <xsl:when test="ends-with(normalize-space($analytic/tei:title), '?')"/>
                        <xsl:otherwise>
                            <xsl:text>.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <i>
                    <xsl:value-of select="normalize-space($analytic/tei:title)"/>
                    <xsl:choose>
                        <xsl:when test="ends-with(normalize-space($analytic/tei:title), '!')"/>
                        <xsl:when test="ends-with(normalize-space($analytic/tei:title), '?')"/>
                        <xsl:otherwise>
                            <xsl:text>.</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </i>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$analytic/tei:editor[1]">
            <xsl:text>. </xsl:text>
            <xsl:choose>
                <xsl:when test="$analytic/tei:editor[2]">
                    <xsl:text>Hg. </xsl:text>
                    <xsl:value-of
                        select="foo:editor-rekursion($analytic, 1, count($analytic/tei:editor))"/>
                </xsl:when>
                <xsl:when
                    test="$analytic/tei:editor[1] and contains($analytic/tei:editor[1], ', ') and not(count(contains($analytic/tei:editor[1], ' ')) &gt; 2) and not(contains($analytic/tei:editor[1], 'Hg') or contains($analytic/tei:editor[1], 'Hrsg'))">
                    <xsl:text>Hg. </xsl:text>
                    <xsl:value-of select="foo:vorname-vor-nachname($analytic/tei:editor/text())"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$analytic/tei:editor/text()"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:function>
    <xsl:function name="foo:vorname-vor-nachname">
        <xsl:param name="autorname"/>
        <xsl:choose>
            <xsl:when test="contains($autorname, ', ')">
                <xsl:value-of select="substring-after($autorname, ', ')"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring-before($autorname, ', ')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$autorname"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:function name="foo:autor-rekursion">
        <xsl:param name="monogr" as="node()"/>
        <xsl:param name="autor-count"/>
        <xsl:param name="autor-count-gesamt"/>
        <!-- in den Fällen, wo ein Text unter einem Kürzel erschien, wird zum sortieren der key-Wert verwendet -->
        <xsl:value-of select="foo:vorname-vor-nachname($monogr/tei:author[$autor-count])"/>
        <xsl:if test="$autor-count &lt; $autor-count-gesamt">
            <xsl:text>, </xsl:text>
            <xsl:value-of
                select="foo:autor-rekursion($monogr, $autor-count + 1, $autor-count-gesamt)"/>
        </xsl:if>
    </xsl:function>
    <xsl:function name="foo:editor-rekursion">
        <xsl:param name="monogr" as="node()"/>
        <xsl:param name="autor-count"/>
        <xsl:param name="autor-count-gesamt"/>
        <!-- in den Fällen, wo ein Text unter einem Kürzel erschien, wird zum sortieren der key-Wert verwendet -->
        <xsl:value-of select="foo:vorname-vor-nachname($monogr/tei:editor[$autor-count])"/>
        <xsl:if test="$autor-count &lt; $autor-count-gesamt">
            <xsl:text>, </xsl:text>
            <xsl:value-of
                select="foo:autor-rekursion($monogr, $autor-count + 1, $autor-count-gesamt)"/>
        </xsl:if>
    </xsl:function>
    
    
    
    
    
</xsl:stylesheet>
