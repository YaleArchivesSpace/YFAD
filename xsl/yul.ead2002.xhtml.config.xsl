<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xalan"
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
    <!--
        ======================================================================
        =          YUL Common XSLT for presenting EAD 2002 as XHTML == CONFIG module          =
        ======================================================================

        created:	2006-06
        updated:	2018-10-29
        contact:	michael.rush@yale.edu, mssa.systems@yale.edu,
        requires:    http://www.library.yale.edu/facc/xsl/include/yale.ead2002.id_head_values.xsl

    -->

  <xsl:variable name="handleString">http://hdl.handle.net/10079/fa/</xsl:variable>
  <xsl:variable name="fedoraPID">
      <xsl:value-of select="concat(substring-before(normalize-space(/ead:ead//ead:eadid),'.'),':',substring-after(normalize-space(/ead:ead//ead:eadid),'.'))"/>
  </xsl:variable>
  <xsl:variable name="handleURL">
      <xsl:value-of select="concat($handleString,normalize-space(/ead:ead//ead:eadid))"/>
  </xsl:variable>
    <xsl:variable name="pdfURL">
        <xsl:value-of select="concat('http://shishen.library.yale.edu/fedora/get/',$fedoraPID,'/PDF')"/>
    </xsl:variable>
    <!--<xsl:variable name="htmlURL2">
        <xsl:value-of select="concat($saxon_path,'?style=',$xsl_style,'&amp;source=',$xml_source,'&amp;big=',$big,'&amp;adv=',$adv,'&amp;query=',$query,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"/>
    </xsl:variable>-->
    <!--New htmlURL2 - ERJ 4/4/11 -->
    <xsl:variable name="htmlURL2">
        <xsl:value-of select="concat($hl_path,'?stylename=',$xsl_file_name,'&amp;pid=',$fedoraPID,'&amp;query=',$query,'&amp;clear-stylesheet-cache=yes','&amp;hlon=',$hlon,'&amp;big=',$big,'&amp;adv=',$adv,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"/>
    </xsl:variable>


    <!-- This version of $htmlURL2 commented 2011-01-26 MR. Swith with previous to reactivate highlighting. -->
    <!--<xsl:variable name="htmlURL2">
        <xsl:value-of select="concat($saxon_path,'?style=',$xsl_style,'&amp;source=',$hl_source,'&amp;big=',$big,'&amp;adv=',$adv,'&amp;query=',$query,'&amp;filter=',$filter,'&amp;hitPageStart=',$hitPageStart,'&amp;sortFields=',$sortFields)"/>
        </xsl:variable>-->
    <!-- hl variables commented 2011-01-26 MR. -->
    <!--<xsl:variable name="hl_path">http://shishen.library.yale.edu/Highlighter/eadhl/</xsl:variable>-->
    <!--<xsl:variable name="hl_query">/baseball/yale</xsl:variable>-->
    <!--<xsl:variable name="hl_query">
        <xsl:value-of select="replace($query,'\s+','/')" />
    </xsl:variable>
    <xsl:variable name="hl_query2">
        <xsl:value-of select="replace($hl_query,'[(]','')" />
    </xsl:variable>
    <xsl:variable name="hl_query3">
        <xsl:value-of select="replace($hl_query2,'[)]','')" />
    </xsl:variable>
    <xsl:variable name="aquote">["]</xsl:variable>
    <xsl:variable name="hl_query4">
        <xsl:value-of select="replace($hl_query3,$aquote,'')" />
    </xsl:variable>
    <xsl:variable name="hl_source" select="concat($hl_path,$fedoraPID,'/',$hl_query4)"/>-->


  <xsl:variable name="saxon_path">http://drs.library.yale.edu/saxon/SaxonServlet</xsl:variable>
  <xsl:variable name="xsl_file_name">yul.ead2002.xhtml.xsl</xsl:variable>
  <xsl:variable name="xsl_style" select="concat($support_file_path,$xsl_file_name)"/>
  <xsl:variable name="xml_file_path_1">http://shishen.library.yale.edu/fedora/get/</xsl:variable>
  <xsl:variable name="xml_file_path_2">/EAD</xsl:variable>
  <xsl:variable name="xml_source" select="concat($xml_file_path_1,$fedoraPID,$xml_file_path_2)"/>
  <xsl:variable name="print_css_file_name">yul.ead2002.xhtml.print.css</xsl:variable>
  <xsl:variable name="menu_css_file_name">mktree.css</xsl:variable>
  <xsl:variable name="menu_tree_script">mktree.js</xsl:variable>

  <!--ERJ - new variables - 4/4/11-->
  <xsl:variable name="hl_path">http://shishen.library.yale.edu/HLTransformer/HLTransServlet</xsl:variable>
  <xsl:variable name="hlon">yes</xsl:variable>

  <xsl:variable name="local_unique_id">
      <xsl:value-of select="//ead:eadid/@countrycode"/><xsl:text>.</xsl:text><xsl:value-of select="//ead:eadid/@mainagencycode"/><xsl:text>.</xsl:text><xsl:value-of select="//ead:eadid"/>
  </xsl:variable>

  <xsl:variable name="icon_audio">icon_audio.gif</xsl:variable>
  <xsl:variable name="icon_video"></xsl:variable>
  <xsl:variable name="icon_image"></xsl:variable>
  <xsl:variable name="icon_pdf"></xsl:variable>
  <xsl:variable name="icon_msword"></xsl:variable>
  <xsl:variable name="icon_rtf"></xsl:variable>
  <xsl:variable name="icon_msexcel"></xsl:variable>
  <xsl:variable name="icon_powerpoint"></xsl:variable>
  <xsl:variable name="icon_msaccess"></xsl:variable>

    <!-- Finding Aid Title -->
    <xsl:variable name="finding_aid_title">
        <xsl:choose>
            <xsl:when test="//ead:titleproper[@type='formal']">
                <xsl:value-of select="normalize-space(//ead:titleproper[@type='formal'])"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(//ead:titleproper[1])"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="//ead:subtitle">
            <xsl:text>: </xsl:text><xsl:value-of select="normalize-space(//ead:subtitle)"/>
        </xsl:if>
    </xsl:variable>

    <!-- Repository Parameter -->
    <xsl:param name="repository_code">
        <xsl:value-of select="substring-before(normalize-space(/ead:ead/ead:eadheader/ead:eadid),'.')"/>
    </xsl:param>

    <!-- place of publication-->
    <xsl:param name="publishplace">New Haven, Connecticut</xsl:param>

    <!--create access terms from <controlaccess>, y or n?-->
    <xsl:param name="includeAccessTerms">y</xsl:param>

    <!-- Include titlepage image? -->
    <xsl:param name="include_titlepage_image">
        <xsl:choose>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke'">
                <xsl:choose>
                    <xsl:when test="/ead:ead/ead:eadheader//ead:note[@type='frontmatter']//ead:extptr">
                        <xsl:text>n</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>y</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Walpole choice -->
            <xsl:when test="$repository_code='lwl'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- Template for titlepage image link -->
    <xsl:template name="titlepage_image_link">
        <xsl:choose>
            <xsl:when test="$repository_code='mssa'">
                <img alt="Yale University Shield" title="Yale University Shield" width="95px" height="99px" src="http://www.library.yale.edu/facc/images/yalebw.jpg" />
            </xsl:when>
            <xsl:when test="$repository_code='divinity'">
                <img alt="Yale Divinity School Shield" title="Yale Divinity School Shield" width="75px" height="84px" src="http://www.library.yale.edu/facc/images/divshield.jpg" />
            </xsl:when>
            <xsl:when test="$repository_code='beinecke'">
                <img alt="Beinecke Rare Book and Manuscript Library" title="Beinecke Rare Book and Manuscript Library" width="186px" height="125px" src="http://www.library.yale.edu/facc/images/brbl_bldg.jpg" />
            </xsl:when>
            <xsl:when test="$repository_code='med'">
                <img alt="Historical Medical Library" title="Historical Medical Library" width="150px" height="136px" src="http://www.library.yale.edu/facc/images/medshield.jpg" />
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Orbis Key - used in link to catalog record -->
    <xsl:param name="orbiskey">
        <xsl:value-of select="concat('(YUL)ead.', normalize-space(/ead:ead/ead:eadheader/ead:eadid))"/>
    </xsl:param>

    <!-- Link to corresponding record in Orbis -->
    <xsl:param name="orbisUrl">
        <!--<xsl:value-of select="concat('http://orbis.library.yale.edu/cgi-bin/Pwebrecon.cgi?Search_Arg=%22',$orbiskey,'%22&amp;DB=local&amp;Search_Code=CMD&amp;CNT=50')"/>-->
        <!--<xsl:value-of select="concat('http://neworbis.library.yale.edu/vwebv/search?searchArg=%22',$orbiskey,'%22&amp;searchCode=CMD&amp;recCount=50&amp;searchType=1')"/>-->
        <xsl:value-of select="concat('http://orbis.library.yale.edu/vwebv/search?searchArg=%27',$orbiskey,'%27&amp;searchCode=GKEY&amp;recCount=50&amp;searchType=1')"/>
    </xsl:param>

    <!-- Include DL Search Link? -->
    <xsl:param name="include_dl_search">
        <xsl:choose>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke' and  not(normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1]) = 'Multiple Call Numbers')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Walpole choice -->
            <xsl:when test="$repository_code='lwl'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- Include Request Form Link? -->
    <xsl:param name="include_requestForm_link">
        <xsl:choose>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Walpole choice -->
            <xsl:when test="$repository_code='lwl'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>




    <!-- ********************* SECTION HEADS, LABELS, and IDs *********************** -->

    <xsl:include href="../include/yale.ead2002.id_head_values.xsl"/>

    <!-- MSSA repository address -->
    <xsl:template name="mssaRepositoryAddress">
        Manuscripts and Archives (Sterling Memorial Library)
        <address>
            <addressline>P.O. Box 208240</addressline>
            <addressline>New Haven, CT 06520-8240</addressline>
            <addressline>tel.:   +1 (203) 432-1744</addressline>
            <addressline>fax.:   +1 (203) 432-7441</addressline>
            <addressline>email: <a rel="external" href="http://www.library.yale.edu/mssa/refform.html">mssa.assist@yale.edu</a></addressline>
        </address>
    </xsl:template>

    <xsl:template name="brblRepositoryAddress-for-overview">
        <xsl:text>P.O. Box 208330</xsl:text>
        <br/>
        <xsl:text>New Haven, CT 06520-8330</xsl:text>
        <br/>
        <xsl:text>Email: </xsl:text>
        <a href="mailto:beinecke.library@yale.edu">beinecke.library@yale.edu</a>
        <br/>
        <xsl:text>Phone: (203) 432-2972</xsl:text>
        <br/>
        <xsl:text>Fax: (203) 432-4047</xsl:text>
    </xsl:template>


    <!-- ********************* Archdesc elements  *********************** -->
    <xsl:template name="bioghist_id">
        <xsl:value-of select="$bioghist_id"/><xsl:number format="1" value="count(preceding-sibling::ead:bioghist)+1"/>
    </xsl:template>
    <xsl:template name="block_bioghist_id">
        <xsl:value-of select="$block_bioghist_id"/><xsl:number format="1" value="count(preceding-sibling::ead:bioghist)+1"/>
    </xsl:template>
    <xsl:template name="arrangement_id">
        <xsl:value-of select="arrangement_id"/><xsl:number format="1" value="count(preceding-sibling::ead:arrangement)+1"/>
    </xsl:template>
    <xsl:template name="block_controlaccess_id">
        <xsl:value-of select="$block_controlaccess_id"/><xsl:number format="1" value="count(preceding-sibling::ead:controlaccess)+1"/>
    </xsl:template>
    <xsl:template name="odd_id">
        <xsl:value-of select="$odd_id"/><xsl:number format="1" value="count(preceding-sibling::ead:odd)+1"/>
    </xsl:template>
    <xsl:template name="index_id">
        <xsl:value-of select="$index_id"/><xsl:number format="1" value="count(preceding-sibling::ead:index)+1"/>
    </xsl:template>

    <!-- ********************* END SECTION HEADS, LABELS, and IDs *********************** -->


    <!-- ********************* BEGIN REPOSITORY LINK PARAM *********************** -->
    <xsl:param name="repository_link">
        <xsl:choose>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>http://hdl.handle.net/10079/bvq83jp</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke'">
                <xsl:text>http://beinecke.library.yale.edu/ </xsl:text>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>http://www.library.yale.edu/div/divhome.htm</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>http://web.library.yale.edu/music</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>http://historical.medicine.yale.edu/</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>http://www.library.yale.edu/arts/specialcollections/</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>http://www.library.yale.edu/arts/vrc.html</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>http://britishart.yale.edu/about-us/departments/rare-books-and-manuscripts</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>http://peabody.yale.edu/</xsl:text>
            </xsl:when>
            <!-- Walpoloe choice -->
            <xsl:when test="$repository_code='lwl'">
                <xsl:text>http://www.library.yale.edu/walpole/</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>http://www.library.yale.edu/</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    <!-- ********************* END REPOSITORY LINK PARAM *********************** -->


    <!-- ********************* BEGIN ID ANCHOR TEMPLATE *********************** -->
    <!--  @id anchor Template -->
    <xsl:template name="id">
        <xsl:variable name="id">
            <xsl:choose>
                <xsl:when test="@id">
                    <xsl:value-of select="@id"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::ead:did[parent::ead:archdesc]">
                            <xsl:value-of select="$did_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:descgrp[@type='admininfo'][parent::ead:archdesc]">
                            <xsl:value-of select="$admininfo_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:descgrp[@type='provenance'][parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$provenance_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:acqinfo[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$acqinfo_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:custodhist[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$custodhist_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:accessrestrict[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$accessrestrict_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:userestrict[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$userestrict_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:prefercite[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$prefercite_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:processinfo[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$processinfo_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:relatedmaterial[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$relatedmaterial_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:separatedmaterial[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$separatedmaterial_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:altformavail[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$altformavail_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:accruals[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$accruals_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:appraisal[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$appraisal_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:originalsloc[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$originalsloc_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:otherfindaid[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$otherfindaid_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:phystech[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$phystech_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:fileplan[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$fileplan_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:bibliography[parent::ead:descgrp[@type='admininfo']]">
                            <xsl:value-of select="$bibliography_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:bioghist[parent::ead:archdesc][not(@id='biogFull')][not(@id='orgFull')]">
                            <xsl:call-template name="bioghist_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:bioghist[parent::ead:archdesc][@id='biogFull']">
                            <xsl:value-of select="$biogFull_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:bioghist[parent::ead:archdesc][@id='orgFull']">
                            <xsl:value-of select="$orgFull_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:bioghist[parent::ead:bioghist]">
                            <xsl:call-template name="block_bioghist_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:scopecontent[parent::ead:archdesc]">
                            <xsl:value-of select="$scopecontent_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:arrangement[parent::ead:archdesc]">
                            <xsl:call-template name="arrangement_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:controlaccess[parent::ead:archdesc]">
                            <xsl:value-of select="$controlaccess_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:controlaccess[parent::ead:controlaccess]">
                            <xsl:call-template name="block_controlaccess_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:dsc">
                            <xsl:value-of select="$dsc_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:odd[parent::ead:archdesc]">
                            <xsl:call-template name="odd_id"/>
                        </xsl:when>
                        <xsl:when test="self::ead:index[parent::ead:archdesc]">
                            <xsl:call-template name="index_id"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="generate-id()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:attribute name="id">
            <xsl:value-of select="$id"/>
        </xsl:attribute>
    </xsl:template>

    <!-- ********************* END ID ANCHOR TEMPLATE *********************** -->


    <!-- ********************* BEGIN <dsc> SETTINGS ************************* -->

    <!-- containers on right? -->
    <xsl:param name="containersonright">
        <xsl:choose>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- Include Aeon requests? -->
    <xsl:param name="includeAeonRequests">
        <xsl:choose>
            <!-- the next three lines have been added to remove all request functionality from the two Kissinger finding aids.
                To reverse this decision, simply delete the following "when" condition. -->
            <xsl:when test="$repository_code='mssa' and (normalize-space(/ead:ead//ead:eadid)='mssa.ms.1981' or normalize-space(/ead:ead//ead:eadid)='mssa.ms.2004')">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- MSSA choice -->
            <xsl:when test="$repository_code='mssa'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- removing links for beinecke.wesley per temporary request  -->
            <xsl:when test="$repository_code='beinecke'
                and (normalize-space(/ead:ead//ead:eadid)='beinecke.wesley'
                or normalize-space(/ead:ead//ead:eadid)='beinecke.steinberg'
                or normalize-space(/ead:ead//ead:eadid)='beinecke.livingtheatre')">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- BRBL choice -->
            <xsl:when test="$repository_code='beinecke'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Divinity choice -->
            <xsl:when test="$repository_code='divinity'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- no requesting for The Music of Charles Ives, since it doesn't have any containers, etc. -->
            <xsl:when test="$repository_code='music' and normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Music choice -->
            <xsl:when test="$repository_code='music'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Medical choice -->
            <xsl:when test="$repository_code='med'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Arts choice -->
            <xsl:when test="$repository_code='arts'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- VRC choice -->
            <xsl:when test="$repository_code='vrc'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- YCBA choice -->
            <xsl:when test="$repository_code='ycba'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- Peabody choice -->
            <xsl:when test="$repository_code='ypm'">
                <xsl:text>n</xsl:text>
            </xsl:when>
            <!-- Walpole choice -->
            <xsl:when test="$repository_code='lwl'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- One table per <c01> or one table for all <c01>? -->
    <xsl:param name="multiple-c01-tables">
        <xsl:choose>
            <!-- 1 table per c01 (subgrp, series, subseries, otherlevel) -->
            <xsl:when test="/ead:ead//ead:c01[@level='subgrp' or @level='series' or @level='subseries' or @level='otherlevel']">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <!-- else <c01> files, items, or those without @level, 1 table per <dsc> -->
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- set indent levels for compnent <did> elements-->
    <xsl:template name="c0x.did.indent">
        <xsl:choose>
            <xsl:when test="self::ead:c02">
                <xsl:text>padding-left: 30px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c03">
                <xsl:text>padding-left: 60px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c04">
                <xsl:text>padding-left: 90px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c05">
                <xsl:text>padding-left: 120px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c06">
                <xsl:text>padding-left: 150px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c07">
                <xsl:text>padding-left: 180px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c08">
                <xsl:text>padding-left: 210px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c09">
                <xsl:text>padding-left: 240px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c10">
                <xsl:text>padding-left: 270px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c11">
                <xsl:text>padding-left: 300px;</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:c12">
                <xsl:text>padding-left: 330px;</xsl:text>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:if
            test="normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1'
                and not(ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12)
                and position()!=1">
            <xsl:choose>
                <xsl:when test="self::ead:c01">
                    <xsl:text>padding-top: 25px;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> padding-top: 25px;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <!-- set indent levels for compnent <did> sibling elements-->
    <xsl:template name="c0x.did.sib.indent">
        <xsl:choose>
            <xsl:when test="self::ead:c01">
                <xsl:attribute name="style">padding-left: 5px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c02">
                <xsl:attribute name="style">padding-left: 35px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c03">
                <xsl:attribute name="style">padding-left: 65px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c04">
                <xsl:attribute name="style">padding-left: 95px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c05">
                <xsl:attribute name="style">padding-left: 125px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c06">
                <xsl:attribute name="style">padding-left: 155px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c07">
                <xsl:attribute name="style">padding-left: 185px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c08">
                <xsl:attribute name="style">padding-left: 215px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c09">
                <xsl:attribute name="style">padding-left: 245px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c10">
                <xsl:attribute name="style">padding-left: 275px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c11">
                <xsl:attribute name="style">padding-left: 305px;</xsl:attribute>
            </xsl:when>
            <xsl:when test="self::ead:c12">
                <xsl:attribute name="style">padding-left: 335px;</xsl:attribute>
            </xsl:when>
            <xsl:otherwise />
        </xsl:choose>
    </xsl:template>

    <!-- ********************* END <dsc> SETTINGS ************************* -->

    <!-- ********************* Begin <daogrp> Icon Templates ************************* -->

    <xsl:template name="icon.audio">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>audio icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>audio icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_audio"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.video">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>video icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>video icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_video"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.image">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>image icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>image icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_image"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.pdf">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>PDF icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>PDF icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_pdf"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.msword">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>Ms Word icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>Ms Word icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_msword"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.rtf">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>RTF icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>RTF icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_rtf"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.msexcel">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>MS Excel icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>MS Excel icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_msexcel"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.powerpoint">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>MS Powerpoint icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>MS Powerpoint icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_powerpoint"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <xsl:template name="icon.msaccess">
        <xsl:element name="img">
            <xsl:attribute name="class">
                <xsl:text>icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:text>MS Access icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:text>MS Access icon</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="src">
                <xsl:value-of select="$support_file_path"/><xsl:value-of select="$icon_msaccess"/>
            </xsl:attribute>
        </xsl:element>
        <xsl:text> </xsl:text>
    </xsl:template>

    <!-- ********************* End <daogrp> Icon Templates ************************* -->

</xsl:stylesheet>
