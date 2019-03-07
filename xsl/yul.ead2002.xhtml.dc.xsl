<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
 <!--
  =========================================================================
  =          YUL Common XSLT for presenting EAD 2002 as XHTML == DC METADATA module      =
  =========================================================================
  
  version:	0.0.1
  status:		development
  created:	2006-06-05
  updated:	2007-07-12
  contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
  -->

  <xsl:template name="dc_metadata">
    <meta name="GENERATOR" content="Transformed from EAD(XML) v 2002." />
    <meta name="DC.Type" content="text" />
    <meta name="DC.Type" content="finding aid" />
    <meta name="DC.Format" content="text/html" />
    
    <xsl:for-each select="ead:eadheader//ead:langusage/ead:language">
      <meta name="DC.Language" content="{normalize-space(.)}"/>
      <xsl:if test="@langcode">
        <meta name="DC.Language" content="{@langcode}"/>
      </xsl:if>
    </xsl:for-each>
    
    <meta name="DC.Identifier" content="{$local_unique_id}"/>
    
    <xsl:for-each select="//ead:publisher">
      <meta name="DC.Publisher" content="{normalize-space(.)}" /> 
    </xsl:for-each>
    
    <meta name="DC.Rights" content="{normalize-space(//ead:publicationstmt/ead:p)}" />
    
    <meta name="DC.Title" content="{$finding_aid_title}" />
    
    <xsl:choose>
      <xsl:when test="//ead:publicationstmt//ead:date[@type='revised']">
        <meta name="DC.Date" content="{normalize-space(//ead:publicationstmt//ead:date[@type='revised'])}" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="//ead:publicationstmt//ead:date[@type='original']">
            <meta name="DC.Date" content="{normalize-space(//ead:publicationstmt//ead:date[@type='revised'])}" />
          </xsl:when>
          <xsl:otherwise>
            <meta name="DC.Date" content="{normalize-space(//ead:publicationstmt//ead:date[1])}" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="//ead:author">
      <meta name="DC.Creator" content="{normalize-space(//ead:author[1])}" />
    </xsl:if>
    
    <meta name="DC.Creator">
      <xsl:attribute name="content">File format: <xsl:value-of select="$find_aid_technical_contact"/></xsl:attribute>
    </meta>
    
    <meta name="DC.Description">
      <xsl:attribute name="content">
        <xsl:choose>
          <xsl:when test="//ead:abstract">
            <xsl:value-of select="normalize-space(substring(//ead:abstract,1,200))"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="normalize-space(substring(//ead:archdesc/ead:scopecontent[1]/ead:p,1,200))"/><xsl:text>...</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </meta>
    
    <xsl:if test="//ead:archdesc/ead:did/ead:origination">
      <meta name="DC.Subject" content="{normalize-space(//ead:archdesc/ead:did/ead:origination)}"/>
    </xsl:if>
  </xsl:template>


</xsl:stylesheet>