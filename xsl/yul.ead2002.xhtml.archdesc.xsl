<?xml version="1.0" encoding="UTF-8"?>
<!--
    ======================================================================
    =          YUL Common XSLT for presenting EAD 2002 as XHTML == <archdesc> module            =
    ======================================================================
    
    version:	0.0.1
    status:	development
    created:	2007-01-29
    updated:	2016-12-16
    contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
    
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:ead="urn:isbn:1-931666-22-9" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xsl ead xlink xsi">

    <!-- Hide elements with altrender nodisplay and internal audience attributes-->
    <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="archdesc"/>
    <xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="archdesc"/>-->

    <!--  archdesc/did Template  -->
    <xsl:template match="ead:did" mode="archdesc">
        <div class="did">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$did_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <table class="did">
                <xsl:apply-templates select="ead:repository" mode="archdesc"/>
                <xsl:apply-templates select="ead:unitid" mode="archdesc"/>
                <xsl:apply-templates select="ead:origination" mode="archdesc"/>
                <xsl:apply-templates select="ead:unittitle" mode="archdesc"/>
                <xsl:apply-templates select="ead:unitdate[@type='inclusive']" mode="archdesc"/>
                <xsl:apply-templates select="ead:unitdate[@type='bulk']" mode="archdesc"/>
                <xsl:apply-templates select="ead:physdesc" mode="archdesc"/>
                <xsl:apply-templates select="ead:langmaterial" mode="archdesc"/>
                <xsl:apply-templates select="../ead:bioghist[@encodinganalog='545']" mode="archdesc"/>
                <xsl:apply-templates select="ead:abstract" mode="archdesc"/>
                <xsl:apply-templates select="ead:physloc" mode="archdesc"/>
                <xsl:apply-templates select="ead:materialspec" mode="archdesc"/>
                <xsl:apply-templates select="ead:note" mode="archdesc"/>
                <xsl:call-template name="did.viewSearch.link"/>
                <xsl:call-template name="did.fa.handle.link"/>
                <xsl:call-template name="did.requestForm.link"/>
                <xsl:call-template name="did.dl.search"/>
                <xsl:if test="$repository_code != 'ypm'">
                    <xsl:call-template name="did.orbis.search"/>
                </xsl:if>
            </table>
        </div>
    </xsl:template>

    <!-- archdesc/did/*/@label colon test template -->
    <xsl:template name="did.label">
        <xsl:variable name="label" select="@label"/>
        <xsl:variable name="labelLength" select="string-length($label)"/>
        <xsl:variable name="labelLast" select="substring($label,$labelLength,$labelLength)"/>
        <xsl:choose>
            <xsl:when test="$labelLast=':'">
                <xsl:value-of select="@label"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="@label"/>
                <xsl:text>:</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- archdesc/did unitid Template  -->
    <xsl:template match="ead:unitid" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$unitid_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did origination Template  -->
    <xsl:template match="ead:origination" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$origination_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did unittitle Template  -->
    <xsl:template match="ead:unittitle" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$unittitle_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did unitdate Template  -->
    <xsl:template match="ead:unitdate[@type='inclusive']" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$unitdate_label_inclusive"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did unitdate Template  -->
    <xsl:template match="ead:unitdate[@type='bulk']" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$unitdate_label_bulk"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did physdesc Template  -->
    <xsl:template match="ead:physdesc" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$physdesc_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did langmaterial Template  -->
    <xsl:template match="ead:langmaterial" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$langmaterial_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did abstract Template  -->
    <xsl:template match="ead:abstract" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$abstract_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did physloc Template  -->
    <xsl:template match="ead:physloc" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$physloc_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did materialspec Template  -->
    <xsl:template match="ead:materialspec" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$materialspec_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did note Template  -->
    <xsl:template match="ead:note" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$note_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:for-each select="ead:p">
                    <xsl:apply-templates mode="inline"/>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>

    <!-- archdesc/did repository Template  -->
    <xsl:template match="ead:repository" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:call-template name="did.label"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$repository_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates mode="block"/>
            </td>
        </tr>
    </xsl:template>

    <!-- ead:archdesc/ead:bioghist[@encodinganalog='545'] -->
    <xsl:template match="ead:bioghist[@encodinganalog='545']" mode="archdesc">
        <tr class="did_child">
            <td class="did_label">
                <xsl:choose>
                    <xsl:when test="ead:head">
                        <xsl:variable name="headVal" select="normalize-space(ead:head)"/>
                        <xsl:variable name="headValLength" select="string-length($headVal)"/>
                        <xsl:variable name="headValLastChar"
                            select="substring($headVal,$headValLength,$headValLength)"/>
                        <xsl:value-of select="$headVal"/>
                        <xsl:if test="$headValLastChar!=':'">
                            <xsl:text>:</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$bioghist_545_label"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="did_entry">
                <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="inline"/>
            </td>
        </tr>
    </xsl:template>

    <!-- Orbis Search Template -->
    <xsl:template name="did.orbis.search">
        <tr class="did_child">
            <td class="did_label">
                <xsl:value-of select="$catalog_record_label"/>
            </td>
            <td class="did_entry">
                <a rel="external">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$orbisUrl"/>
                    </xsl:attribute>
                    <xsl:text>A record for this collection, including location information, may be available in Orbis, the Yale University Library catalog.</xsl:text>
                </a>
            </td>
        </tr>
    </xsl:template>

    <!-- DL Search Template -->
    <xsl:template name="did.dl.search">
        <xsl:if test="$include_dl_search='y'">
            <tr class="did_child">
                <td class="did_label">
                    <xsl:value-of select="$dl_search_label"/>
                </td>
                <td class="did_entry">
                    <xsl:choose>
                        <xsl:when test="$repository_code='mssa'">
                            <xsl:choose>
                                <xsl:when test="contains(/ead:ead/ead:eadheader/ead:eadid, '.ms.')">
                                    <a rel="external">
                                        <xsl:attribute name="href">
                                            <xsl:text>http://images.library.yale.edu/madid/showthumb.aspx?q1=</xsl:text>
                                            <xsl:value-of
                                                select="substring-after(normalize-space(/ead:ead/ead:eadheader/ead:eadid), '.ms.')"/>
                                            <xsl:text>&amp;qc1=contains&amp;qf1=subject1&amp;qx=1004.2</xsl:text>
                                        </xsl:attribute>
                                        <xsl:text>Search for digital images from this collection.</xsl:text>
                                    </a>
                                </xsl:when>
                                <xsl:when test="contains(/ead:ead/ead:eadheader/ead:eadid, '.ru.')">
                                    <a rel="external">
                                        <xsl:attribute name="href">
                                            <xsl:text>http://images.library.yale.edu/madid/showthumb.aspx?q1=</xsl:text>
                                            <xsl:value-of
                                                select="substring-after(normalize-space(/ead:ead/ead:eadheader/ead:eadid), '.ru.')"/>
                                            <xsl:text>&amp;qc1=contains&amp;qf1=subject1&amp;qx=1004.1</xsl:text>
                                        </xsl:attribute>
                                        <xsl:text>Search for digital images from this collection.</xsl:text>
                                    </a>
                                </xsl:when>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$repository_code='beinecke'">
                            <xsl:variable name="brblCallNumString">
                                <xsl:apply-templates
                                    select="/ead:ead/ead:archdesc/ead:did/ead:unitid[1]"
                                    mode="noHighlight"/>
                            </xsl:variable>
                            <xsl:variable name="brblCallNumStringNormal">
                                <xsl:choose>
                                    <xsl:when
                                        test="/ead:ead/ead:archdesc/ead:did/ead:unitid[1]/ead:em">
                                        <xsl:value-of
                                            select="translate(normalize-space($brblCallNumString),' ','_')"
                                        />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of
                                            select="translate(normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1]),' ','_')"
                                        />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <a rel="external">
                                <xsl:attribute name="href">
                                    <xsl:value-of
                                        select="concat('http://brbl-dl.library.yale.edu/vufind/Search/Results?lookfor=', $brblCallNumStringNormal, '&amp;type=CallNumber')"/>
                                    <!-- old string
                                <xsl:text>http://beinecke.library.yale.edu/dl_crosscollex/callnumSRCHXC.asp?callnum=</xsl:text><xsl:value-of select="$brblCallNumStringNormal"/>
                                -->
                                </xsl:attribute>
                                <xsl:text>Search for digital images from this collection.</xsl:text>
                            </a>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <!-- Request Form Link Template -->
    <xsl:template name="did.requestForm.link">
        <xsl:if test="$include_requestForm_link='y'">
            <tr class="did_child">
                <td class="did_label">
                    <xsl:value-of select="$requestForm_link_label"/>
                </td>
                <td class="did_entry">
                    <xsl:choose>
                        <xsl:when test="$repository_code='divinity'">
                            <xsl:text>To view manuscript and archival materials at the Yale Divinity Library, please submit the request form at </xsl:text>
                            <a rel="external">
                                <xsl:attribute name="href">
                                    <xsl:text>http://web.library.yale.edu/form/yale-divinity-library-mss-request-form</xsl:text>
                                </xsl:attribute>
                                <xsl:text>http://web.library.yale.edu/form/yale-divinity-library-mss-request-form</xsl:text>
                            </a>
                            <xsl:text>.</xsl:text>
                        </xsl:when>
                        <xsl:when test="$repository_code='arts'">
                            <xsl:text>To request manuscript and archival materials for viewing in the Arts Library Special Collections (ALSC) Reading Room, please submit the request form at </xsl:text>
                            <a rel="external">
                                <xsl:attribute name="href">
                                    <xsl:text>http://www.library.yale.edu/arts/specialcollections/alscrequest.html</xsl:text>
                                </xsl:attribute>
                                <xsl:text>http://www.library.yale.edu/arts/specialcollections/alscrequest.html</xsl:text>
                            </a>
                            <xsl:text>.</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <!-- Finding Aid Handle Link Template -->
    <xsl:template name="did.fa.handle.link">
        <tr class="did_child">
            <td class="did_label">
                <xsl:value-of select="$faHandle_link_label"/>
            </td>
            <td class="did_entry">
                <xsl:text>To cite or bookmark this finding aid, use the following address: </xsl:text>
                <br/>
                <xsl:element name="a">
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$handleURL"/>
                    </xsl:attribute>
                    <xsl:value-of select="$handleURL"/>
                </xsl:element>
            </td>
        </tr>
    </xsl:template>

    <!-- Finding Aid Handle Link Template -->
    <xsl:template name="did.viewSearch.link">
        <tr class="did_child">
            <td class="did_label">
                <xsl:value-of select="$faViewSearch_label"/>
            </td>
            <td class="did_entry">
                <span style="color: #d87a00;">
                    <xsl:text>To view and/or search the entire finding aid, see the </xsl:text>
                    <xsl:if test="not($big='y')">
                        <a class="bigtitle2">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat($htmlURL2,'&amp;view=all')"/>
                            </xsl:attribute>
                            <xsl:text>Full HTML</xsl:text>
                            <span>(NOTE: for large finding aids, the full HTML view may take up to
                                30 seconds to render)</span>

                        </a>
                        <xsl:text> or the </xsl:text>
                    </xsl:if>
                    <a>
                        <xsl:attribute name="rel">
                            <xsl:text>external</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$pdfURL"/>
                        </xsl:attribute>
                        <xsl:text>Printable PDF</xsl:text>
                    </a>
                    <xsl:text>.</xsl:text>
                </span>
            </td>
        </tr>
    </xsl:template>

    <!--  archdesc/descgrp Template -->
    <xsl:template match="ead:descgrp[@type='admininfo']" mode="archdesc">
        <div class="admininfo">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$admininfo_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:p" mode="block"/>
            <xsl:apply-templates select="ead:descgrp[@type='provenance']" mode="archdesc"/>
            <xsl:apply-templates select="ead:acqinfo" mode="archdesc"/>
            <xsl:apply-templates select="ead:custodhist" mode="archdesc"/>
            <!--<xsl:call-template name="archdesc.accessrestrict"/>-->
            <xsl:apply-templates select="ead:accessrestrict" mode="archdesc"/>
            <xsl:apply-templates select="ead:userestrict" mode="archdesc"/>
            <xsl:apply-templates select="ead:prefercite" mode="archdesc"/>
            <xsl:apply-templates select="ead:processinfo" mode="archdesc"/>
            <xsl:apply-templates select="ead:altformavail" mode="archdesc"/>
            <xsl:apply-templates select="ead:relatedmaterial" mode="archdesc"/>
            <xsl:apply-templates select="ead:separatedmaterial" mode="archdesc"/>
            <xsl:apply-templates select="ead:accruals" mode="archdesc"/>
            <xsl:apply-templates select="ead:appraisal" mode="archdesc"/>
            <xsl:apply-templates select="ead:originalsloc" mode="archdesc"/>
            <xsl:apply-templates select="ead:otherfindaid" mode="archdesc"/>
            <xsl:apply-templates select="ead:phystech" mode="archdesc"/>
            <xsl:apply-templates select="ead:fileplan" mode="archdesc"/>
            <xsl:apply-templates select="ead:bibliography" mode="archdesc"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/descgrp[@type='provenance'] Template -->
    <xsl:template match="ead:descgrp[@type='provenance']" mode="archdesc">
        <div class="provenance">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$provenance_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:acqinfo/ead:*" mode="block"/>
            <xsl:apply-templates select="ead:custodhist/ead:*" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/acqinfo Template -->
    <xsl:template match="ead:acqinfo" mode="archdesc">
        <div class="acqinfo">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$acqinfo_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/custodhist Template -->
    <xsl:template match="ead:custodhist" mode="archdesc">
        <div class="custodhist">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$custodhist_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!-- Template for archdesc.acessrestrict, adds paragraph to BRBL FAs. -->
    <!--<xsl:template name="archdesc.accessrestrict">
        <xsl:choose>
            <xsl:when test="$repository_code='beinecke'">
                <div class="accessrestrict">
                    <xsl:value-of select="$accessrestrict_id"/>
                    <!-\-<xsl:call-template name="id"/>-\->
                    <xsl:choose>
                        <xsl:when test="ead:accessrestrict/ead:head">
                            <xsl:apply-templates select="ead:accessrestrict/ead:head" mode="block"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <h3 class="head">
                                <xsl:value-of select="$accessrestrict_head"/>
                            </h3>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="ead:accessrestrict/ead:*[not(self::ead:head)]" mode="block"/>
                    <p>
                        <xsl:text>This collection may be housed off-site at Yale’s Library Shelving Facility (LSF).  
                        To determine if all or part of this collection is housed off-site please check the library’s online catalog, </xsl:text>
                        <a>
                            <xsl:attribute name="rel">
                                <xsl:text>external</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$orbisUrl"/>
                            </xsl:attribute>
                            <xsl:text>Orbis</xsl:text>
                        </a>
                        <xsl:text>; material for which the location is given as “LSF” must be requested 36 hours in advance.  
                            Please consult with Beinecke Access Services for more information.</xsl:text>
                    </p>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="ead:accessrestrict" mode="archdesc"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->

    <!--  archdesc/descgrp/accessrestrict Template -->
    <xsl:template match="ead:accessrestrict" mode="archdesc">
        <div class="accessrestrict">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$accessrestrict_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
            <xsl:if test="$repository_code='beinecke'">
                <xsl:call-template name="beinecke.accessrestrict"/>
            </xsl:if>
        </div>
    </xsl:template>

    <!-- Boilerplate text for all Beinecke <accessrestrict> notes. -->
    <xsl:template name="beinecke.accessrestrict">
        <xsl:element name="p">
            <xsl:text>This collection may be housed off-site at Yale’s Library Shelving Facility (LSF).  
                        To determine if all or part of this collection is housed off-site please check the library’s online catalog, </xsl:text>
            <xsl:element name="a">
                <xsl:attribute name="rel">
                    <xsl:text>external</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:value-of select="$orbisUrl"/>
                </xsl:attribute>
                <xsl:text>Orbis</xsl:text>
            </xsl:element>
            <xsl:text>; material for which the location is given as “LSF” must be requested 36 hours in advance.  
                            Please consult with Beinecke Access Services for more information.</xsl:text>
        </xsl:element>
        <!-- added by MDC on 4/25/2014
        <p class="well"> The Beinecke Library will be closed for renovations May 2015 to August
            2016. We will maintain a temporary reading room in Sterling Memorial Library during this
            time. However, access to collections will be limited. Please see <a
                href="http://beineckelibraryrenovation.yale.edu/" rel="external">
                http://beineckelibraryrenovation.yale.edu</a> for more information. </p>
                -->
    </xsl:template>

    <!--  archdesc/descgrp/userestrict Template -->
    <xsl:template match="ead:userestrict" mode="archdesc">
        <div class="userestrict">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$userestrict_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/prefercite Template -->
    <xsl:template match="ead:prefercite" mode="archdesc">
        <div class="prefercite">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$prefercite_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/processinfo Template -->
    <xsl:template match="ead:processinfo" mode="archdesc">
        <div class="processinfo">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$processinfo_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/relatedmaterial Template -->
    <xsl:template match="ead:relatedmaterial" mode="archdesc">
        <div class="relatedmaterial">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$relatedmaterial_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/separatedmaterial Template -->
    <xsl:template match="ead:separatedmaterial" mode="archdesc">
        <div class="separatedmaterial">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$separatedmaterial_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/altformavail Template -->
    <xsl:template match="ead:altformavail" mode="archdesc">
        <div class="altformavail">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$altformavail_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/accruals Template -->
    <xsl:template match="ead:accruals" mode="archdesc">
        <div class="accruals">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$accruals_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/appraisal Template -->
    <xsl:template match="ead:appraisal" mode="archdesc">
        <div class="appraisal">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$appraisal_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/originalsloc Template -->
    <xsl:template match="ead:originalsloc" mode="archdesc">
        <div class="originalsloc">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$originalsloc_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/otherfindaid Template -->
    <xsl:template match="ead:otherfindaid" mode="archdesc">
        <div class="otherfindaid">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$otherfindaid_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/phystech Template -->
    <xsl:template match="ead:phystech" mode="archdesc">
        <div class="phystech">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$phystech_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/fileplan Template -->
    <xsl:template match="ead:fileplan" mode="archdesc">
        <div class="fileplan">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$fileplan_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/descgrp/bibliography Template -->
    <xsl:template match="ead:bibliography" mode="archdesc">
        <div class="bibliography">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h3 class="head">
                        <xsl:value-of select="$bibliography_head"/>
                    </h3>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/bioghist Template -->
    <xsl:template match="ead:bioghist[not(@encodinganalog='545')]" mode="archdesc">
        <div class="bioghist">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$bioghist_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/scopecontent Template -->
    <xsl:template match="ead:scopecontent" mode="archdesc">
        <div class="scopecontent">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$scopecontent_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/arrangement Template -->
    <xsl:template match="ead:arrangement" mode="archdesc">
        <div class="arrangement">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$arrangement_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/controlaccess Template -->
    <xsl:template match="ead:controlaccess" mode="archdesc">
        <div class="controlaccess">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$controlaccess_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
        </div>
    </xsl:template>

    <!--  archdesc/dsc Template -->
    <xsl:template match="ead:dsc" mode="archdesc">
        <xsl:param name="view"/>
        <xsl:param name="c01Position"/>
        <div class="dsc">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$dsc_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
            <xsl:choose>
                <xsl:when test="$multiple-c01-tables='n'">
                    <xsl:call-template name="single-dsc-table"/>
                </xsl:when>
                <xsl:when test="$multiple-c01-tables='y' and ($view='all' or $view='dsc')">
                    <xsl:apply-templates select="ead:c01" mode="c0x"/>
                </xsl:when>
                <xsl:when test="$multiple-c01-tables='y' and not($view='all' or $view='dsc')">
                    <xsl:apply-templates select="ead:c01[position()=$c01Position]" mode="c0x"/>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>

    <!--  archdesc/odd Template -->
    <xsl:template match="ead:odd" mode="archdesc">
        <xsl:param name="oddPosition"/>
        <xsl:param name="view"/>
        <xsl:if test="position()=$oddPosition or $view='all'">
            <div class="odd">
                <xsl:call-template name="id"/>
                <xsl:choose>
                    <xsl:when test="ead:head">
                        <xsl:apply-templates select="ead:head" mode="block"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <h2 class="head">
                            <xsl:value-of select="$odd_head"/>
                        </h2>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="block"/>
            </div>
        </xsl:if>
    </xsl:template>

    <!--  archdesc/index Template -->
    <xsl:template match="ead:index" mode="archdesc">
        <div class="index">
            <xsl:call-template name="id"/>
            <xsl:choose>
                <xsl:when test="ead:head">
                    <xsl:apply-templates select="ead:head" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <h2 class="head">
                        <xsl:value-of select="$index_head"/>
                    </h2>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates
                select="ead:*[not(self::ead:head)][not(self::ead:indexentry)][not(self::ead:listhead)]"
                mode="block"/>
            <xsl:if test="ead:indexentry">
                <table class="index">
                    <xsl:if test="ead:listhead">
                        <tr>
                            <th class="namegrp">
                                <xsl:apply-templates select="ead:listhead/ead:head01" mode="inline"
                                />
                            </th>
                            <th class="ptrgrp">
                                <xsl:apply-templates select="ead:listhead/ead:head02" mode="inline"
                                />
                            </th>
                        </tr>
                    </xsl:if>
                    <xsl:for-each select="ead:indexentry">
                        <xsl:variable name="odd_or_even">
                            <xsl:choose>
                                <xsl:when test="position() mod 2 = 0">even</xsl:when>
                                <xsl:otherwise>odd</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <tr>
                            <xsl:if test="@id">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="@id"/>
                                </xsl:attribute>
                            </xsl:if>
                            <td>
                                <xsl:attribute name="class">
                                    <xsl:choose>
                                        <xsl:when test="$odd_or_even='odd'">
                                            <xsl:text>namegrp-1</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>namegrp-2</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:apply-templates select="ead:namegrp" mode="block"/>
                            </td>
                            <td>
                                <xsl:attribute name="class">
                                    <xsl:choose>
                                        <xsl:when test="$odd_or_even='odd'">
                                            <xsl:text>ptrgrp-1</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>ptrgrp-2</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:apply-templates select="ead:ptrgrp" mode="block"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </xsl:if>
        </div>
    </xsl:template>

</xsl:stylesheet>
