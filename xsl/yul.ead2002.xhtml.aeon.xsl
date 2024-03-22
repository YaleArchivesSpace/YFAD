<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
  <!--
        ===========================================================================
        =          YUL Common XSLT for presenting EAD 2002 as XHTML ==  Aeon module            =
        ===========================================================================
        
        created:	2011-07-27
        updated:	2016-01-15
        contact:	michael.rush@yale.edu, mssa.systems@yale.edu, mark.custer@yale.edu
        
  -->

  <!-- potential fix (since we can't use encode-for-uri on DRS)
    to address request problems for finding aids like this one:
    http://hdl.handle.net/10079/fa/beinecke.mayer 
    (remove the translate functions when this is no longer necessary, either due to:
    - upgrade to xslt 2.0 on DRS
    - Aeon form fix (right now, the error on beinecke.mayer only occurs because of the itemcitation field,
      even though the diacritics also occur in the itemtitle field)
    - Switch to ASpace for YFAD
    (right now, the fix is simply to keep the diacritics in the URL strings passed to Aeon, without encoding them with URI character encodings.)

  <xsl:param name="diacritics" select="'áäçčèéëíîñóôöúüšž'"/>
  <xsl:param name="normalized" select="'aacceeeiinooouusz'"/>
    -->

  <xsl:variable name="aeonBaseURL">
    <xsl:choose>
      <xsl:when test="$repository_code = 'beinecke' and starts-with($saxon_path, 'http://shishen')">
        <!-- BRBL DEV -->
        <xsl:text>https://aeon-test.its.yale.edu/aeon.dll?Action=10&amp;Form=20</xsl:text>
      </xsl:when>
      <xsl:when test="$repository_code = 'beinecke' and starts-with($saxon_path, 'http://drs')">
        <!-- BRBL PROD -->
        <xsl:text>https://aeon.library.yale.edu/aeon.dll?Action=10&amp;Form=20</xsl:text>
      </xsl:when>
      <xsl:when
        test="not($repository_code = 'beinecke') and starts-with($saxon_path, 'http://shishen')">
        <!-- MSSA DEV -->
        <xsl:text>https://aeon-test.library.yale.edu/aeon.dll?Action=10&amp;Form=20</xsl:text>
      </xsl:when>
      <xsl:when test="not($repository_code = 'beinecke') and starts-with($saxon_path, 'http://drs')">
        <!-- MSSA PROD -->
        <xsl:text>https://aeon.library.yale.edu/aeon.dll?Action=10&amp;Form=20</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="aeonForm">
    <xsl:choose>
      <xsl:when test="$repository_code = 'beinecke'">
        <xsl:text>&amp;Value=GenericRequestMonograph</xsl:text>
      </xsl:when>
      <xsl:when test="$repository_code = 'mssa'">
        <xsl:choose>
          <xsl:when test="$officeOfOriginRequest = 'y'">
            <xsl:text>&amp;Value=GenericRequestOrigin</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="starts-with(normalize-space(ead:ead//ead:eadid), 'mssa.ms')">
                <xsl:text>&amp;Value=GenericRequestManuscript</xsl:text>
              </xsl:when>
              <xsl:when test="starts-with(normalize-space(ead:ead//ead:eadid), 'mssa.ru')">
                <xsl:text>&amp;Value=GenericRequestArchive</xsl:text>
              </xsl:when>
              <!--<xsl:when test="">
            <!-\-<xsl:text>&amp;Value=GenericRequestMicroform</xsl:text>-\->
            <xsl:text>&amp;Value=GenericRequestMicroform</xsl:text>
          </xsl:when>-->
              <!--<xsl:when test="">
            <!-\-<xsl:text>&amp;Value=GenericRequestMonograph</xsl:text>-\->
            <xsl:text>&amp;Value=GenericRequestMonograph</xsl:text>
          </xsl:when>-->
              <!--<xsl:when test="">
            <!-\-<xsl:text>&amp;Value=GenericRequestFortunoff</xsl:text>-\->
            <xsl:text>&amp;Value=GenericRequestFortunoff</xsl:text>
          </xsl:when>-->
              <xsl:otherwise>
                <xsl:text>&amp;Value=GenericRequestManuscript</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&amp;Value=GenericRequestManuscript</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template name="aeonResourceID">
    <xsl:param name="componentID"/>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;CallNumber=</xsl:text>
    </xsl:variable>
    <xsl:variable name="callNumString">
      <xsl:choose>
        <xsl:when
          test="$repository_code = 'beinecke' and contains(/ead:ead/ead:archdesc/ead:did/ead:unitid, 'Multiple')">
          <xsl:for-each
            select="/ead:ead//*[@id = $componentID]/ancestor-or-self::ead:c01/ead:did/ead:unitid">
            <xsl:apply-templates mode="noHighlight"/>
            <xsl:if test="position() != last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:for-each select="/ead:ead/ead:archdesc/ead:did/ead:unitid">
            <xsl:apply-templates mode="noHighlight"/>
            <xsl:if test="position() != last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($callNumString)"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <!-- new variable, now that we're including multiple repository in MSSA's form -->
  <xsl:variable name="aeonSite">
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;site=</xsl:text>
    </xsl:variable>
    <xsl:variable name="repo-to-site_code">
      <!-- 3-character codes, per request -->
      <xsl:choose>
        <xsl:when test="$repository_code = 'arts'">
          <xsl:text>ART</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'beinecke'">
          <xsl:text>BRBL</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'divinity'">
          <xsl:text>DIV</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'lwl'">
          <xsl:text>LWL</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'med'">
          <xsl:text>MHL</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'mssa'">
          <xsl:text>MSS</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'music'">
          <xsl:text>MUS</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'vrc'">
          <xsl:text>ART</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'ycba'">
          <xsl:text>BCA</xsl:text>
        </xsl:when>
        <xsl:when test="$repository_code = 'ypm'">
          <xsl:text>YPM</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>MSS</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $repo-to-site_code)"/>
  </xsl:variable>

  <xsl:variable name="aeonTitle">
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemTitle=</xsl:text>
    </xsl:variable>
    <xsl:variable name="unittitleString">
      <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did/ead:unittitle[1]"
        mode="noHighlight"/>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($unittitleString)"/>
          <!--
          <xsl:value-of
            select="translate(normalize-space($unittitleString), $diacritics, $normalized)"/>
            -->
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:variable>

  <xsl:variable name="aeonAuthor">
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemAuthor=</xsl:text>
    </xsl:variable>
    <xsl:variable name="originationString">
      <xsl:for-each select="/ead:ead/ead:archdesc/ead:did/ead:origination">
        <xsl:apply-templates mode="noHighlight"/>
        <xsl:if test="position() != last()">
          <xsl:text>; </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($originationString)"/>
          <!--
          <xsl:value-of
            select="translate(normalize-space($originationString), $diacritics, $normalized)"/>
            -->
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:variable>

  <xsl:variable name="aeonEADNumber">
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;EADNumber=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:variable name="EADhandle-or-EADid">
        <xsl:choose>
          <xsl:when test="$repository_code = 'beinecke'">
            <xsl:value-of select="normalize-space(/ead:ead/ead:eadheader/ead:eadid)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="/ead:ead/ead:eadheader/ead:eadid/@url"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString" select="$EADhandle-or-EADid"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:variable>

  <xsl:variable name="aeonCitation">
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemCitation=</xsl:text>
    </xsl:variable>
    <xsl:variable name="citationString">
      <xsl:apply-templates
        select="/ead:ead/ead:archdesc/ead:descgrp[@type = 'admininfo']/ead:prefercite/ead:p[1]"
        mode="noHighlight"/>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($citationString)"/>
          <!--
          <xsl:value-of
            select="translate(normalize-space($citationString), $diacritics, $normalized)"/>
            -->
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:variable>

  <xsl:template name="aeonSeriesID">
    <xsl:param name="componentID"/>
    <xsl:variable name="seriesIDString">
      <xsl:apply-templates
        select="/ead:ead//*[@id = $componentID]/ancestor-or-self::ead:c01/ead:did/ead:unitid[1]"
        mode="noHighlight"/>
    </xsl:variable>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemSeries=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($seriesIDString)"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonSeriesTitle">
    <xsl:param name="componentID"/>
    <xsl:variable name="seriesTitleString">
      <xsl:apply-templates
        select="/ead:ead//*[@id = $componentID]/ancestor-or-self::ead:c01/ead:did/ead:unittitle[1]"
        mode="noHighlight"/>
      <!--<xsl:value-of
        select="normalize-space(/ead:ead//*[@id=$componentID]/ancestor-or-self::ead:c01/ead:did/ead:unittitle[1])"
      />-->
    </xsl:variable>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemSubTitle=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($seriesTitleString)"/>
          <!--
          <xsl:value-of
            select="translate(normalize-space($seriesTitleString), $diacritics, $normalized)"/>
            -->
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonBox">
    <xsl:param name="componentID"/>
    <xsl:param name="containerLabelBox"/>
    <xsl:variable name="boxString">
      <xsl:apply-templates select="ead:did/ead:container[@type = 'Box']" mode="noHighlight"/>
    </xsl:variable>
    <xsl:variable name="boxStringOut">
      <xsl:value-of
        select="concat($containerLabelBox, ' ', normalize-space(translate($boxString, '–—', '-')))"
      />
    </xsl:variable>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemVolume=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="$boxStringOut"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <!--<xsl:choose>
      <xsl:when test="$repository_code='mssa' and (contains($boxString,'-')or contains($boxString,','))"/>
      <xsl:otherwise>
        <xsl:value-of select="concat($aeonVariableName,$valueString)"/>
      </xsl:otherwise>
    </xsl:choose>-->
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonFolder">
    <xsl:param name="componentID"/>
    <xsl:param name="containerLabelFolder"/>
    <xsl:variable name="folderString">
      <xsl:apply-templates select="ead:did/ead:container[@type = 'Folder']" mode="noHighlight"/>
      <xsl:if test="$officeOfOriginRequest = 'y'">
        <xsl:text> : </xsl:text>
        <xsl:value-of select="substring(ead:did/ead:unittitle[1], 1, 25)"/>
        <xsl:if test="string-length(ead:did/ead:unittitle[1]) &gt; 25">
          <xsl:text>...</xsl:text>
        </xsl:if>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="folderStringOut">
      <xsl:value-of select="concat($containerLabelFolder, ' ', normalize-space($folderString))"/>
    </xsl:variable>
    <xsl:variable name="folderStringOutOrDaoHref">
      <xsl:choose>
        <xsl:when
          test="/ead:ead//*[@id = $componentID]/ead:did/ead:dao[@xlink:role = 'application/vnd.aeon']">
          <xsl:value-of
            select="/ead:ead//*[@id = $componentID]/ead:did/ead:dao[@xlink:role = 'application/vnd.aeon']/@xlink:title"
          />
        </xsl:when>
        <xsl:when
          test="/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc[@xlink:role = 'application/vnd.aeon']">
          <xsl:value-of
            select="/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc[@xlink:role = 'application/vnd.aeon']/@xlink:title"
          />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$folderStringOut"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemFolder=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="$folderStringOutOrDaoHref"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonReel">
    <xsl:param name="componentID"/>
    <xsl:param name="containerLabelReel"/>
    <xsl:variable name="reelString">
      <xsl:apply-templates select="ead:did/ead:container[@type = 'Reel']" mode="noHighlight"/>
    </xsl:variable>
    <xsl:variable name="reelStringOut">
      <xsl:value-of select="concat($containerLabelReel, ' ', normalize-space($reelString))"/>
    </xsl:variable>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ItemVolume=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="$reelStringOut"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonBarcode">
    <xsl:param name="componentID"/>
    <xsl:param name="barcodeString">
      <xsl:choose>
        <xsl:when
          test="
            not(/ead:ead//*[@id = $componentID]/ead:did/ead:container)
            and /ead:ead//*[@id = $componentID]/ead:did/ead:dao[@xlink:role = 'request/aeon']">
          <xsl:value-of
            select="normalize-space(/ead:ead//*[@id = $componentID]/ead:did/ead:dao/@xlink:href)"/>
        </xsl:when>
        <xsl:when
          test="
            not(/ead:ead//*[@id = $componentID]/ead:did/ead:container)
            and and/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc[@xlink:role = 'request/aeon']">
          <xsl:value-of
            select="normalize-space(/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc/@xlink:href)"
          />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of
            select="normalize-space(/ead:ead//*[@id = $componentID]/ead:did/ead:container[@type = 'Box']/@label)"
          />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;ReferenceNumber=</xsl:text>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="$barcodeString"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="aeonLocation">
    <xsl:param name="componentID"/>
    <xsl:variable name="aeonVariableName">
      <xsl:text>&amp;Location=</xsl:text>
    </xsl:variable>
    <xsl:variable name="locationString">
      <xsl:choose>
        <xsl:when
          test="/ead:ead//*[@id = $componentID]/ead:did/ead:dao[@xlink:role = 'application/vnd.aeon']">
          <xsl:value-of
            select="/ead:ead//*[@id = $componentID]/ead:did/ead:dao[@xlink:role = 'application/vnd.aeon']/@xlink:href"
          />
        </xsl:when>
        <xsl:when
          test="/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc[@xlink:role = 'application/vnd.aeon']">
          <xsl:value-of
            select="/ead:ead//*[@id = $componentID]/ead:did/ead:daogrp/ead:daoloc[@xlink:role = 'application/vnd.aeon']/@xlink:href"
          />
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="valueString">
      <xsl:call-template name="url-encode">
        <xsl:with-param name="urlString">
          <xsl:value-of select="normalize-space($locationString)"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat($aeonVariableName, $valueString)"/>
  </xsl:template>

  <xsl:template name="url-encode">
    <!--
      ISO-8859-1 based URL-encoding demo Written by Mike J. Brown, mike@skew.org. Updated 2002-05-20. No license; use freely, but credit me if reproducing in print. Also see http://skew.org/xml/misc/URI-i18n/ for a discussion of non-ASCII characters in URIs.
    -->
    <xsl:param name="urlString"/>
    <!-- Characters we'll support.
      We could add control chars 0-31 and 127-159, but we won't. --> 
    <xsl:variable name="ascii"> !"#$%&amp;'()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~</xsl:variable> 
    <xsl:variable name="latin1">&#160;&#161;&#162;&#163;&#164;&#165;&#166;&#167;&#168;&#169;&#170;&#171;&#172;&#173;&#174;&#175;&#176;&#177;&#178;&#179;&#180;&#181;&#182;&#183;&#184;&#185;&#186;&#187;&#188;&#189;&#190;&#191;&#192;&#193;&#194;&#195;&#196;&#197;&#198;&#199;&#200;&#201;&#202;&#203;&#204;&#205;&#206;&#207;&#208;&#209;&#210;&#211;&#212;&#213;&#214;&#215;&#216;&#217;&#218;&#219;&#220;&#221;&#222;&#223;&#224;&#225;&#226;&#227;&#228;&#229;&#230;&#231;&#232;&#233;&#234;&#235;&#236;&#237;&#238;&#239;&#240;&#241;&#242;&#243;&#244;&#245;&#246;&#247;&#248;&#249;&#250;&#251;&#252;&#253;&#254;&#255;</xsl:variable> 
    
    <!-- Characters that usually don't need to be escaped --> 
    <!-- i've added additional characters to the safe list.  since we can't use xslt 2.0's encode-for-uri function,
      we can't get the proper URI encodes using this template.  i've tested Aeon requests using the characters as is, however, with success.
      (mdc, 2016-01-20)-->
    <xsl:variable name="safe">!'()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~áäçčèéëíîñóôöúüšž</xsl:variable>
    <xsl:variable name="hex" >0123456789ABCDEF</xsl:variable> 
    
    <xsl:if test="$urlString"> 
      <xsl:variable name="first-char" select="substring($urlString,1,1)"/> 
      <xsl:choose> 
        <xsl:when test="contains($safe,$first-char)"> 
          <xsl:value-of select="$first-char"/> 
        </xsl:when> 
        <xsl:otherwise> 
          <xsl:variable name="codepoint"> 
            <xsl:choose> 
              <xsl:when test="contains($ascii,$first-char)"> 
                <xsl:value-of select="string-length(substring-before($ascii,$first-char)) + 32"/> 
              </xsl:when> 
              <xsl:when test="contains($latin1,$first-char)"> 
                <xsl:value-of select="string-length(substring-before($latin1,$first-char)) + 160"/> 
              </xsl:when> 
              <xsl:otherwise> 
                <xsl:message terminate="no">Warning: string contains a character that is out of range! Substituting "?".</xsl:message> 
                <xsl:text>63</xsl:text> 
              </xsl:otherwise> 
            </xsl:choose> 
          </xsl:variable> 
          <xsl:variable name="hex-digit1" select="substring($hex,floor($codepoint div 16) + 1,1)"/> 
          <xsl:variable name="hex-digit2" select="substring($hex,$codepoint mod 16 + 1,1)"/> 
          <xsl:value-of select="concat('%',$hex-digit1,$hex-digit2)"/> 
        </xsl:otherwise> 
      </xsl:choose> 
      <xsl:if test="string-length($urlString) &gt; 1"> 
        <xsl:call-template name="url-encode"> 
          <xsl:with-param name="urlString" select="substring($urlString,2)"/> 
        </xsl:call-template> 
      </xsl:if> 
    </xsl:if> 
    
    
  </xsl:template>

</xsl:stylesheet>
