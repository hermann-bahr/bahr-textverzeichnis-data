<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="tei">
    <xsl:output method="xml" indent="true"/>
    <xsl:mode on-no-match="shallow-skip"/>
    
    <xsl:param name="listpersonPMB" select="document('../../pmblistperson.xml')"/>
    <xsl:key name="person-match" use="*:idno[@subtype='pmb']" match="*:listPerson/*:person" />
   
   <xsl:template match="*:list">
       <list>
           <xsl:apply-templates/>
           
       </list>
   </xsl:template>
   
   
   <xsl:template match="*:item">
       <xsl:variable name="matching" as="node()?" select="key('person-match', concat(replace(., 'pmb', 'https://pmb.acdh.oeaw.ac.at/entity/'), '/'), $listpersonPMB)"/>
       <xsl:choose>
           <xsl:when test="$matching/child::*[1]">
               <xsl:copy-of select="$matching"/>
               
           </xsl:when>
           <xsl:otherwise>
               <item>
                   <xsl:value-of select="."/>
               </item>
           </xsl:otherwise>
       </xsl:choose>
       
       
   </xsl:template>
   
</xsl:stylesheet>
