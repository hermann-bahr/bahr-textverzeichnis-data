<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:mam="nonTEI"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" method="xml" encoding="utf-8" omit-xml-declaration="false"/>
   
   <xsl:template match="tei:term[contains(., ' s. ')]"/>
   
    <xsl:template match="tei:term[not(contains(., ' s. '))]">
       <xsl:variable name="textteil1" select="normalize-space(tokenize(., ',')[1])"/>
       <xsl:variable name="textteil2" select="substring-after(., concat($textteil1, ', '))"/>
       <xsl:variable name="textteil3" as="xs:string">
           <xsl:choose>
               <xsl:when test="string-length(substring-before($textteil2, ' (')) &gt; 0">
                   <xsl:value-of select="substring-before($textteil2, ' (')"/>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:value-of select="$textteil2"/>
               </xsl:otherwise>
           </xsl:choose>
       </xsl:variable>
       <xsl:variable name="dasist" select="contains(., 'd.i')" as="xs:boolean"/>
       <xsl:variable name="lebensdaten" select="substring-before(substring-after(., '('), ')')" as="xs:string"/>
       <xsl:element name="tei:person">
           <xsl:element name="tei:persName">
           <xsl:element name="tei:surname">
               <xsl:choose>
                   <xsl:when test="contains($textteil1, 'd.i.')">
                       <xsl:value-of select="substring-before($textteil1, ' d.i.')"/>
                   </xsl:when>
                   <xsl:when test="contains($textteil1, ' (')">
                       <xsl:value-of select="substring-before($textteil1, ' (')"/>
                   </xsl:when>
                   <xsl:otherwise>
                       <xsl:value-of select="$textteil1"/>
                   </xsl:otherwise>
               </xsl:choose>
           </xsl:element>
                       <xsl:choose>
                           <xsl:when test="contains($textteil3, ' d.i.')">
                               <xsl:element name="tei:forename">
                               <xsl:value-of select="substring-before($textteil3, ' d.i.')"/>
                               </xsl:element>
                               <xsl:element name="mam:altname">
                                   <xsl:value-of select="normalize-space(substring-after($textteil3, ' d.i.'))"/>
                               </xsl:element>
                           </xsl:when>
                           <xsl:when test="contains($textteil3, ', ')">
                               <xsl:element name="tei:forename">
                               <xsl:value-of select="substring-before($textteil3, ', ')"/>
                               </xsl:element>
                               <xsl:element name="tei:profession">
                                   <xsl:value-of select="substring-after($textteil3, ', ')"/>
                               </xsl:element>
                           </xsl:when>
                           <xsl:when test="contains($textteil3, 'chauspieler') or contains($textteil3, 'ichter') or contains($textteil3, 'irektor') or contains($textteil3, 'erleger') or contains($textteil3, 'Papst')">
                               <xsl:element name="tei:profession">
                                   <xsl:value-of select="$textteil3"/>
                               </xsl:element>
                           </xsl:when>
                           <xsl:when test="contains($textteil3, ' geb.')">
                               <xsl:element name="tei:forename">
                                   <xsl:value-of select="substring-before($textteil3, ' geb.')"/>
                               </xsl:element>
                               <xsl:element name="tei:surname">
                                   <xsl:attribute name="type">
                                       <xsl:text>birthname</xsl:text>
                                   </xsl:attribute>
                                   <xsl:value-of select="substring-after($textteil3, ' geb.')"/>
                               </xsl:element>
                           </xsl:when>
                           <xsl:otherwise>
                               <xsl:if test="not($textteil3 ='')">
                               <xsl:element name="tei:forename">
                                  <xsl:value-of select="$textteil3"/>
                               </xsl:element>
                               </xsl:if>
                           </xsl:otherwise>
                       </xsl:choose>
           </xsl:element>
           <xsl:choose>
               <xsl:when test="string-length($lebensdaten)=0"/>
               <xsl:when test="contains($lebensdaten, '–')">
                   <xsl:choose>
                       <xsl:when test="string(number(substring-before(normalize-space($lebensdaten), '–'))) != 'NaN'">
                           <xsl:element name="tei:birth">
                               <xsl:element name="tei:date">
                                   <xsl:attribute name="when">
                                       <xsl:value-of select="substring-before(normalize-space($lebensdaten), '–')"/>
                                   </xsl:attribute>
                                   <xsl:value-of select="substring-before(normalize-space($lebensdaten), '–')"/>
                               </xsl:element>
                           </xsl:element>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:if test="not(normalize-space(substring-before(normalize-space($lebensdaten), '–')) = '?')">
                           <xsl:element name="mam:irregularBirthDate">
                               <xsl:value-of select="normalize-space(substring-before(normalize-space($lebensdaten), '–'))"/>
                           </xsl:element>
                           </xsl:if>
                       </xsl:otherwise>
                   </xsl:choose>
                   <xsl:choose>
                       <xsl:when test="string(number(substring-after(normalize-space($lebensdaten), '–'))) != 'NaN'">
                           <xsl:element name="tei:death">
                               <xsl:element name="tei:date">
                                   <xsl:attribute name="when">
                                       <xsl:value-of select="substring-after(normalize-space($lebensdaten), '–')"/>
                                   </xsl:attribute>
                                   <xsl:value-of select="substring-after(normalize-space($lebensdaten), '–')"/>
                               </xsl:element>
                           </xsl:element>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:element name="mam:irregularDeathDate">
                               <xsl:value-of select="normalize-space(substring-after(normalize-space($lebensdaten), '–'))"/>
                           </xsl:element>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:when>
               <xsl:when test="starts-with($lebensdaten, '†')">
                   <xsl:choose>
                       <xsl:when test="string(number(substring-after(normalize-space($lebensdaten), '†'))) != 'NaN'">
                           <xsl:element name="tei:death">
                               <xsl:element name="tei:date">
                                   <xsl:attribute name="when">
                                       <xsl:value-of select="substring-after(normalize-space($lebensdaten), '†')"/>
                                   </xsl:attribute>
                                   <xsl:value-of select="substring-after(normalize-space($lebensdaten), '†')"/>
                               </xsl:element>
                           </xsl:element>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:element name="mam:irregularDeathDate">
                               <xsl:value-of select="normalize-space(substring-after(normalize-space($lebensdaten), '–'))"/>
                           </xsl:element>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:when>
               <xsl:when test="starts-with($lebensdaten, 'geb.')">
                   <xsl:choose>
                       <xsl:when test="string(number(substring-after(normalize-space($lebensdaten), 'geb.'))) != 'NaN'">
                           <xsl:element name="tei:death">
                               <xsl:element name="tei:date">
                                   <xsl:attribute name="when">
                                       <xsl:value-of select="substring-after(normalize-space($lebensdaten), 'geb.')"/>
                                   </xsl:attribute>
                                   <xsl:value-of select="substring-after(normalize-space($lebensdaten), 'geb.')"/>
                               </xsl:element>
                           </xsl:element>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:element name="mam:irregularDeathDate">
                               <xsl:value-of select="normalize-space(substring-after(normalize-space($lebensdaten), '–'))"/>
                           </xsl:element>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:element name="lebensdaten">
                       <xsl:value-of select="$lebensdaten"/>
                   </xsl:element>
               </xsl:otherwise>
           </xsl:choose>
          
           
       </xsl:element>
   </xsl:template>
   
    
</xsl:stylesheet>
