<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
  ========================================================
  =          YUL Common XSLT for presenting EAD 2002 as XHTML             =
  ========================================================
  
  created:	2006-06-05
  updated:	2019-03-17
  dependecies:	
  yul.ead2002.xhtml.config.xsl
  yul.ead2002.xhtml.dc.xsl
  yul.ead2002.xhtml.navigator.xsl
  yul.ead2002.xhtml.titlepage.xsl
  yul.ead2002.xhtml.archdesc.xsl
  yul.ead2002.xhtml.c0x.xsl
  yul.ead2002.xhtml.block.xsl
  yul.ead2002.xhtml.inline.xsl
  yul.ead2002.xhtml.aeon.xsl
  
  contact:	michael.rush@yale.edu, mssa.systems@yale.edu
  
  TO CREATE A FACT-COMPATIBLE VERSION OF yul.ead2002.xhtml.xsl, DO THE FOLLOWING: 
  -Copy all yul.ead2002.xhtml files and rename them with ".fact" before ".xml"
  -Change xmlns:ead="urn:isbn:1-931666-22-9" to xmlns:ead="http://www.library.yale.edu/facc/schemas/yale.ead2002" in all files.
  -In yul.ead2002.xhtml.fact.xsl, update the <xsl:include> @hrefs to start with "support'", e.g. href="support/yul.ead2002.xhtml.config.xsl"
  -In yul.ead2002.xhtml.fact.xsl, update the <xsl:include> filenames in yul.ead2002.xhtml.fact.xsl.
  -In yul.ead2002.xhtml.fact.xsl, update <xsl:param name="view"> so that it has the value <xsl:text>all</xsl:text>
  -In yul.ead2002.xhtml.config.fact.xsl, update <xsl:param name="includeAeonRequests"> so that all params have value 'n'.
  -In yul.ead2002.xhtml.common.fact.xml, update $support_file_path as necessary (should be http://drs.library.yale.edu:8083/saxon/EAD/)
  -In all files, search all files for ead:c01 and replace with ead:c[parent::ead:dsc]
  -In yul.ead2002.xhtml.c0x.fact.xsl, in <xsl:template name="single-dsc-table"> and <xsl:template match="ead:c[parent::ead:dsc]" mode="c0x">, 
  replace ead:c02 with ead:c[parent::ead:c[parent::ead:dsc]]
  -In yul.ead2002.xhtml.c0x.fact.xsl in <xsl:template match="ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12" mode="c0x">, 
  replace @match and @select values with ead:c[not(parent::ead:dsc)]
  -In yul.ead2002.xhtml.navigator.fact.xsl, replace each instance of ead:c02, ead:c03, ead:c04, and ead:c05 with ead:c
  -In yul.ead2002.xhtml.navigator.fact.xsl, replace <xsl:when test="not(ead:head) and ($local-name='c01' or $local-name='c02' or
          $local-name='c03' or $local-name='c04' or $local-name='c05')"> with <xsl:when test="not(ead:head) and ($local-name='c')">.
  -In yul.ead2002.xhtml.navigator.fact.xsl, replace <xsl:when test="not(ead:head) and not($local-name='c01') and not($local-name='c02') 
          and not($local-name='c03') and not($local-name='c04') and not($local-name='c05')"> with <xsl:when test="not(ead:head) and not($local-name='c')">.
  -In yul.ead2002.xhtml.config.fact.xsl, update <xsl:template name="c0x.did.indent"> and <xsl:template name="c0x.did.sib.indent">
  @test values.  Replace: 
  self::ead:c01 with self::ead:c[parent::ead:dsc]
  self::ead:c02 with self::ead:c[parent::ead:c[parent::ead:dsc]]
  self::ead:c03 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]
  self::ead:c04 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]
  self::ead:c05 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]
  self::ead:c06 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]
  self::ead:c07 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]
  self::ead:c08 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]]
  self::ead:c09 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]]]
  self::ead:c10 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]]]]
  self::ead:c11 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]]]]]
  self::ead:c12 with self::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:c[parent::ead:dsc]]]]]]]]]]]]
  
  - replaced port ":8083" (MDC)
  - added Google Tag Manager code (MDC)
  - removed Google Tag Mananger code now that we're deprecating these files (MDC)
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
    
  <xsl:output method="xml" omit-xml-declaration="yes" encoding="UTF-8" indent="yes"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
  
  <xsl:strip-space elements="*"/>
  
  <xsl:include href="yul.ead2002.xhtml.config.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.dc.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.navigator.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.titlepage.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.archdesc.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.c0x.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.block.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.inline.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.common.xsl"/>
  <xsl:include href="yul.ead2002.xhtml.aeon.xsl"/>
  
  <xsl:param name="big"/>
  <xsl:param name="view"/>
  <xsl:param name="officeOfOriginRequest"/>

  <xsl:param name="query"/>
  <xsl:param name="hitPageStart"/>
  <xsl:param name="filter"/>
  <xsl:param name="adv"/>
  <xsl:param name="sortFields"/>
  <xsl:param name="altquery"/>
    
  <xsl:param name="c01Position">
    <xsl:value-of select="substring-after($view,'_')"/>
  </xsl:param>
  <xsl:param name="oddPosition">
    <xsl:value-of select="substring-after($view,'_')"/>
  </xsl:param>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="ead:ead">
    <xsl:call-template name="xhtml_base"/>
  </xsl:template>
  
  
  <xsl:template name="xhtml_base">
    <html>
      <xsl:comment>WARNING!! THIS FILE MACHINE GENERATED: DO NOT EDIT!!</xsl:comment>
      <head>
        
        <xsl:call-template name="commonHeadElements">
          <xsl:with-param name="finding_aid_title">
            <xsl:value-of select="$finding_aid_title"/>
          </xsl:with-param>
        </xsl:call-template>
        
        <link rel="stylesheet" type="text/css">
          <xsl:attribute name="href">
            <xsl:value-of select="concat($support_file_path,$menu_css_file_name)"/>
          </xsl:attribute>
        </link>
        <link rel="stylesheet" type="text/css" media="print">
          <xsl:attribute name="href">
            <xsl:value-of select="concat($support_file_path,$print_css_file_name)"/>
          </xsl:attribute>
        </link>
        <script type="text/javascript">
          <xsl:attribute name="src">
            <xsl:value-of select="concat($support_file_path,$menu_tree_script)"/>
          </xsl:attribute>
          <xsl:text> </xsl:text>
        </script>


        
        
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
        <xsl:call-template name="dc_metadata"/>
      </head>
      
      <body>
        <!-- added 2017/10/12 for GTM -->
        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KVRNCC"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <xsl:call-template name="commonHeader"/>
        <div id="breadcrumbs">
          <xsl:choose>
            <xsl:when test="$query=''">
              <xsl:choose>
                <xsl:when test="$adv='y'">
                  <a href="http://shishen.library.yale.edu/fedoragsearch/restAdv">Advanced
                  Search</a>
                  <xsl:choose>
                    <xsl:when test="$altquery">
                      <xsl:text>&#160; &gt; &#160;</xsl:text>
                      <a>
                    <xsl:attribute name="class">
                      <xsl:text>breadcrumbs</xsl:text>
                    </xsl:attribute>
                         <xsl:attribute name="href">
                          <xsl:value-of
                            select="concat('http://shishen.library.yale.edu/fedoragsearch/restAdv?query=','&amp;altquery=',$altquery,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"
                          />
                        </xsl:attribute>
                    <xsl:text>Search Results</xsl:text>
                  </a>
                  </xsl:when>
                  </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                  <a class="breadcrumbs"
                    href="http://shishen.library.yale.edu/fedoragsearch/rest">Home</a>
                  <xsl:choose>
                    <xsl:when test="$altquery">
                      <xsl:text>&#160; &gt; &#160;</xsl:text>
                      <a>
                        <xsl:attribute name="class">
                          <xsl:text>breadcrumbs</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                          <xsl:value-of
                            select="concat('http://shishen.library.yale.edu/fedoragsearch/rest?query=','&amp;altquery=',$altquery,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"
                          />
                        </xsl:attribute>
                        <xsl:text>Search Results</xsl:text>
                      </a>
                    </xsl:when>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text>&#160; &gt; &#160; Finding Aid</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="$adv='y'">
                  <a href="http://shishen.library.yale.edu/fedoragsearch/restAdv">Advanced
                    Search</a>
                </xsl:when>
                <xsl:otherwise>
                  <a class="breadcrumbs"
                    href="http://shishen.library.yale.edu/fedoragsearch/rest">Home</a>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:text>&#160; &gt; &#160;</xsl:text>
              <a>
                <xsl:attribute name="class">
                  <xsl:text>breadcrumbs</xsl:text>
                </xsl:attribute>
                <xsl:choose>
                  <xsl:when test="$adv='y'">
                    <xsl:attribute name="href">
                      <xsl:value-of
                        select="concat('http://shishen.library.yale.edu/fedoragsearch/restAdv?query=',$query,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"
                      />
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:attribute name="href">
                      <xsl:value-of
                        select="concat('http://shishen.library.yale.edu/fedoragsearch/rest?query=',$query,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"
                      />
                    </xsl:attribute>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text>Search Results</xsl:text>
              </a>
              <xsl:text>&#160; &gt; &#160; Finding Aid</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </div>
        <p/>
        <div id="FindingAid">
          <div id="left_menu">
            <xsl:call-template name="navigator">
              <xsl:with-param name="view">
                <xsl:choose>
                  <xsl:when test="not(normalize-space($view))">
                    <xsl:text>over</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$view"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
              <xsl:with-param name="c01Position">
                <xsl:value-of select="$c01Position"/>
              </xsl:with-param>
              <xsl:with-param name="oddPosition">
                <xsl:value-of select="$oddPosition"/>
              </xsl:with-param>
            </xsl:call-template>
          </div>
          <div id="center_container">
          <div id="center_box">
            <div class="main" id="main">
              <xsl:choose>
                <!--<xsl:when test="$view='aeon'">
                  <xsl:call-template name="aeonRequestForm">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>-->
                <xsl:when test="$view='tp'">
                  <xsl:call-template name="titlepage">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:call-template>
                </xsl:when>
                <xsl:when test="$view='over'">
                  <xsl:apply-templates select="ead:archdesc/ead:did" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:descgrp[@type='admininfo']" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:bioghist[not(@encodinganalog='545')]"
                    mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:scopecontent" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:arrangement" mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='did'">
                  <xsl:apply-templates select="ead:archdesc/ead:did" mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='ai'">
                  <xsl:apply-templates select="ead:archdesc/ead:descgrp[@type='admininfo']" mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='bh'">
                  <xsl:apply-templates select="ead:archdesc/ead:bioghist[not(@encodinganalog='545')]"
                    mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='sc'">
                  <xsl:apply-templates select="ead:archdesc/ead:scopecontent" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:arrangement" mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='dsc'">
                  <xsl:apply-templates select="ead:archdesc/ead:dsc" mode="archdesc">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="starts-with($view,'c01')">
                  <xsl:apply-templates select="ead:archdesc/ead:dsc" mode="archdesc">
                    <xsl:with-param name="c01Position">
                      <xsl:value-of select="$c01Position"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="starts-with($view,'odd')">
                  <xsl:apply-templates select="ead:archdesc/ead:odd" mode="archdesc">
                    <xsl:with-param name="oddPosition">
                      <xsl:value-of select="$oddPosition"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <!--<xsl:when test="$view='odd'">
                  <xsl:apply-templates select="ead:archdesc/ead:odd" mode="archdesc"/>
                </xsl:when>-->
                <xsl:when test="$view='index'">
                  <xsl:apply-templates select="ead:archdesc/ead:index" mode="archdesc"/>
                </xsl:when>
                <xsl:when test="$view='ca'">
                  <xsl:if test="$includeAccessTerms='y'">
                    <xsl:apply-templates select="ead:archdesc/ead:controlaccess" mode="archdesc"/>
                  </xsl:if>
                </xsl:when>
                <xsl:when test="$view='all'">
                  <!--<xsl:call-template name="aeonRequestForm">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:call-template>-->
                  <xsl:call-template name="titlepage">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:apply-templates select="ead:archdesc/ead:did" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:descgrp[@type='admininfo']" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:bioghist[not(@encodinganalog='545')]"
                    mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:scopecontent" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:arrangement" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:dsc" mode="archdesc">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="ead:archdesc/ead:odd" mode="archdesc">
                    <xsl:with-param name="view">
                      <xsl:value-of select="$view"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="ead:archdesc/ead:index" mode="archdesc"/>
                  <xsl:if test="$includeAccessTerms='y'">
                    <xsl:apply-templates select="ead:archdesc/ead:controlaccess" mode="archdesc"/>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="ead:archdesc/ead:did" mode="archdesc">
                    <xsl:with-param name="view">
                      <xsl:text>over</xsl:text>
                    </xsl:with-param>
                  </xsl:apply-templates>
                  <xsl:apply-templates select="ead:archdesc/ead:descgrp[@type='admininfo']" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:bioghist[not(@encodinganalog='545')]"
                    mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:scopecontent" mode="archdesc"/>
                  <xsl:apply-templates select="ead:archdesc/ead:arrangement" mode="archdesc"/>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  
  <!-- Hide elements with altrender nodisplay and internal audience attributes-->
  <xsl:template match="ead:*[@audience='internal']" priority="1"/>
  <xsl:template match="ead:*[@altrender='nodisplay']" priority="2"/>
  
</xsl:stylesheet>
