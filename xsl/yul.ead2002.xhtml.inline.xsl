<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
    <!--
            =================================================================================
            =          YUL Common XSLT for presenting EAD 2002 as XHTML == Inline Elements Module            =
            =================================================================================
            
            version:	0.0.1
            status:	development
            created:	2007-01-26
            updated:	2011-02-04
            contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
            
    -->
    
    <!-- Hide elements with altrender nodisplay and internal audience attributes-->
    <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="inline"/>-->
    <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="inline"/>-->
    

    <!-- Inline <emph> template  -->
    <xsl:template match="ead:emph" mode="inline">
        <xsl:choose>
            <xsl:when test="@render='bold'">
                <strong><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='italic'">
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:when>
            <xsl:when test="@render='bolditalic'">
                <strong><em><xsl:apply-templates mode="inline"/></em></strong>
            </xsl:when>
            <xsl:when test="@render='singlequote'">
                <xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text>
            </xsl:when>
            <xsl:when test="@render='boldsinglequote'">
                <strong><xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='doublequote'">
                <xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@render='bolddoublequote'">
                <strong><xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='smcaps'">
                <span class="smcaps"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldsmcaps'">
                <strong class="smcaps"><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='underline'">
                <span class="uline"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldunderline'">
                <strong><span class="uline"><xsl:apply-templates mode="inline"/></span></strong>
            </xsl:when>
            <xsl:when test="@render='sub'">
                <sub><xsl:apply-templates mode="inline"/></sub>
            </xsl:when>
            <xsl:when test="@render='super'">
                <sup><xsl:apply-templates mode="inline"/></sup>
            </xsl:when>
            <xsl:when test="@render='nonproport'">
                <tt class="nonproport"><xsl:apply-templates mode="inline"/></tt>
            </xsl:when>
            <xsl:when test="@render='altrender'">
                <xsl:apply-templates mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                <strong><xsl:apply-templates  mode="inline"/></strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Inline <lb/> template  -->
    <xsl:template match="ead:lb" mode="inline">
        <br />
    </xsl:template>

    <!-- Inline <abbr> and <expan> template  -->
    <!-- <abbr> and <expan> are not supported by the Yale EAD BPGs, but may appear in legacy files -->
    <xsl:template match="ead:abbr | ead:expan"  mode="inline">
        <abbr title="{./@expan}{./@abbr}"><xsl:apply-templates mode="inline"/></abbr>
    </xsl:template>
    
    <!-- Inline <ref> Template -->
    <xsl:template match="ead:ref" mode="inline">
        <xsl:param name="targetView">
            <xsl:call-template name="linkParamTargetView"/>
        </xsl:param>
        <xsl:param name="internal">
            <xsl:call-template name="linkParamInternal">
                <xsl:with-param name="targetView">
                    <xsl:value-of select="$targetView"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:param>
        <a>
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="$internal='y' or $view='all'">
                        <xsl:value-of select="concat('#',@target)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($htmlURL2,'&amp;view=',$targetView,'#',@target)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates mode="inline"/>
        </a>
    </xsl:template>
    
    <!-- Inline <ptr> Template -->
    <xsl:template match="ead:ptr" mode="inline">
        <xsl:param name="targetView">
            <xsl:call-template name="linkParamTargetView"/>
        </xsl:param>
        <xsl:param name="internal">
            <xsl:call-template name="linkParamInternal">
                <xsl:with-param name="targetView">
                    <xsl:value-of select="$targetView"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:param>
        <xsl:variable name="ptrtarget" select="@target"/>
        <a>
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when test="$internal='y' or $view='all'">
                        <xsl:value-of select="concat('#',@target)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($htmlURL2,'&amp;view=',$targetView,'#',@target)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ancestor::ead:physloc">
                    <xsl:for-each select="/ead:ead//ead:*[@id=$ptrtarget]">
                        <xsl:choose>
                            <xsl:when test="not(ancestor::ead:dsc)">
                                <xsl:call-template name="ptr.target.head.text"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="ead:did">
                                    <xsl:variable name="box_label">
                                        <xsl:call-template name="ptr.box.label"/>
                                    </xsl:variable>
                                    <xsl:variable name="folder_label">
                                        <xsl:call-template name="ptr.folder.label"/>
                                    </xsl:variable>
                                    <xsl:variable name="reel_label">
                                        <xsl:call-template name="ptr.reel.label"/>
                                    </xsl:variable>
                                    <xsl:if test="ancestor::*[@level='subgrp']/ead:did//ead:unitid">
                                        <xsl:apply-templates select="ancestor::*[@level='subgrp']/ead:did//ead:unitid" mode="inline"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="ancestor::*[@level='subgrp']/ead:did//ead:unittitle[1]">
                                        <xsl:apply-templates select="ancestor::*[@level='subgrp']/ead:did//ead:unittitle[1]" mode="inline"/>
                                        <xsl:choose>
                                            <xsl:when test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                                                <xsl:text>, </xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                    <xsl:if test="ancestor::*[@otherlevel='accession']/ead:did//ead:unitid">
                                        <xsl:apply-templates select="ancestor::*[@otherlevel='accession']/ead:did//ead:unitid" mode="inline"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="ancestor::*[@otherlevel='accession']/ead:did//ead:unittitle[1]">
                                        <xsl:apply-templates select="ancestor::*[@otherlevel='accession']/ead:did//ead:unittitle[1]" mode="inline"/>
                                        <xsl:choose>
                                            <xsl:when test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                                                <xsl:text>, </xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text> </xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                    <xsl:if test="ancestor::*[@level='series']/ead:did//ead:unitid">
                                        <xsl:apply-templates select="ancestor::*[@level='series']/ead:did//ead:unitid" mode="inline"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:if test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                                        <xsl:apply-templates select="ancestor::*[@level='series']/ead:did//ead:unittitle[1]" mode="inline"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Box'] or .//ead:container[@type='Folder'] or .//ead:container[@type='Reel']">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Box']">
                                        <xsl:value-of select="$box_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Box']" mode="inline"/>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Box'] and (.//ead:container[@type='Folder'] or .//ead:container[@type='Reel'])">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Folder']">
                                        <xsl:value-of select="$folder_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Folder']" mode="inline"/>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Reel'] and .//ead:container[@type='Folder']">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Reel']">
                                        <xsl:value-of select="$reel_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Reel']" mode="inline"/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="/ead:ead//ead:*[@id=$ptrtarget]">
                        <xsl:choose>
                            <xsl:when test="not(ancestor::ead:dsc)">
                                <xsl:call-template name="ptr.target.head.text"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:for-each select="ead:did">
                                    <xsl:variable name="box_label">
                                        <xsl:call-template name="ptr.box.label"/>
                                    </xsl:variable>
                                    <xsl:variable name="folder_label">
                                        <xsl:call-template name="ptr.folder.label"/>
                                    </xsl:variable>
                                    <xsl:variable name="reel_label">
                                        <xsl:call-template name="ptr.reel.label"/>
                                    </xsl:variable>
                                    <xsl:if test=".//ead:unitid">
                                        <xsl:apply-templates select=".//ead:unitid" mode="inline"/>
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:choose>
                                        <xsl:when test=".//ead:unittitle/ead:ptr">
                                            <xsl:value-of select=".//ead:unittitle"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:apply-templates select=".//ead:unittitle" mode="inline"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test=".//ead:container[@type='Box'] or .//ead:container[@type='Folder'] or .//ead:container[@type='Reel']">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Box']">
                                        <xsl:value-of select="$box_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Box']" mode="inline"/>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Box'] and (.//ead:container[@type='Folder'] or .//ead:container[@type='Reel'])">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Folder']">
                                        <xsl:value-of select="$folder_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Folder']" mode="inline"/>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Reel'] and .//ead:container[@type='Folder']">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:if test=".//ead:container[@type='Reel']">
                                        <xsl:value-of select="$reel_label"/><xsl:text> </xsl:text>
                                        <xsl:apply-templates select=".//ead:container[@type='Reel']" mode="inline"/>
                                    </xsl:if>
                                </xsl:for-each>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </a>
    </xsl:template>
    
    <!-- targetView Link Parameter Template -->
    <xsl:template name="linkParamTargetView">
        <xsl:variable name="ptrtarget" select="@target"/>
        <xsl:for-each select="/ead:ead//ead:*[@id=$ptrtarget]">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::ead:did[parent::ead:archdesc]">
                    <xsl:text>over</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:descgrp[@type='admininfo']">
                    <xsl:text>over</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:bioghist[not(@encodinganalog='545')]">
                    <xsl:text>over</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:scopecontent">
                    <xsl:text>over</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:arrangement">
                    <xsl:text>over</xsl:text>
                </xsl:when>
                <xsl:when test="self::ead:dsc">
                    <xsl:text>dsc</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:c01">
                    <xsl:choose>
                        <xsl:when test="$multiple-c01-tables='n'">
                            <xsl:text>dsc</xsl:text>
                        </xsl:when>
                        <xsl:when test="$multiple-c01-tables='y'">
                            <xsl:variable name="targetC01Position">
                                <xsl:for-each select="ancestor-or-self::ead:c01">
                                    <xsl:value-of select="number(count(preceding-sibling::ead:c01) + 1)"/>
                                </xsl:for-each>
                            </xsl:variable>
                            <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="self::ead:odd">
                    <!--<xsl:text>odd</xsl:text>-->
                    <xsl:value-of select="concat('odd_',position())"/>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:index">
                    <xsl:text>index</xsl:text>
                </xsl:when>
                <xsl:when test="ancestor-or-self::ead:controlaccess">
                    <xsl:text>ca</xsl:text>
                </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <!-- internal Link Parameter Template -->
    <xsl:template name="linkParamInternal">
        <xsl:param name="targetView"/>
        <xsl:choose>
            <xsl:when test="ancestor-or-self::ead:did and ($targetView='did' or $targetView='over')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:descgrp[@type='admininfo'] and ($targetView='ai' or $targetView='over')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:bioghist[not(@encodinganalog='545')] and ($targetView='bh' or $targetView='over')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:scopecontent and ($targetView='sc' or $targetView='over')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:arrangement and ($targetView='sc' or $targetView='over')">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="self::ead:dsc and $targetView='dsc'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:c01 and starts-with($targetView,'c01')">
                <xsl:variable name="c01Position">
                    <xsl:for-each select="ancestor-or-self::ead:c01">
                        <xsl:value-of select="number(count(preceding-sibling::ead:c01) + 1)"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="substring-after($targetView,'_')=$c01Position">
                    <xsl:text>y</xsl:text>
                </xsl:if>
            </xsl:when>
            <!--<xsl:when test="ancestor-or-self::ead:odd and $targetView='odd'">
                <xsl:text>y</xsl:text>
            </xsl:when>-->
            <xsl:when test="ancestor-or-self::ead:odd and starts-with($targetView,'odd')">
                <xsl:variable name="oddPosition">
                    <xsl:for-each select="ancestor-or-self::ead:odd">
                        <xsl:value-of select="position()"/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:if test="substring-after($targetView,'_')=$oddPosition">
                    <xsl:text>y</xsl:text>
                </xsl:if>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:index and $targetView='index'">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor-or-self::ead:controlaccess and $targetView='ca'">
                <xsl:text>y</xsl:text>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="ptr.target.head.text">
        <xsl:choose>
            <xsl:when test="ead:head">
                <xsl:apply-templates select="ead:head" mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="self::ead:did[parent::ead:archdesc]">
                        <xsl:value-of select="$did_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:descgrp[@type='admininfo'][parent::ead:archdesc]">
                        <xsl:value-of select="$admininfo_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:descgrp[@type='provenance'][parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$provenance_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:acqinfo[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$acqinfo_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:custodhist[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$custodhist_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:accessrestrict[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$accessrestrict_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:userestrict[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$userestrict_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:prefercite[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$prefercite_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:processinfo[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$processinfo_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:relatedmaterial[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$relatedmaterial_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:separatedmaterial[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$separatedmaterial_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:altformavail[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$altformavail_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:accruals[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$accruals_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:appraisal[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$appraisal_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:originalsloc[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$originalsloc_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:otherfindaid[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$otherfindaid_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:phystech[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$phystech_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:fileplan[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$fileplan_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:bibliography[parent::ead:descgrp[@type='admininfo']]">
                        <xsl:value-of select="$bibliography_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:bioghist[parent::ead:archdesc]">
                        <xsl:value-of select="$bioghist_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:scopecontent[parent::ead:archdesc]">
                        <xsl:value-of select="$scopecontent_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:arrangement[parent::ead:archdesc]">
                        <xsl:value-of select="$arrangement_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:controlaccess[parent::ead:archdesc]">
                        <xsl:value-of select="$controlaccess_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:dsc[parent::ead:archdesc]">
                        <xsl:value-of select="$dsc_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:index[parent::ead:archdesc]">
                        <xsl:value-of select="$index_head"/>
                    </xsl:when>
                    <xsl:when test="self::ead:odd[parent::ead:archdesc]">
                        <xsl:value-of select="$odd_head"/>
                    </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="ptr.box.label">
        <xsl:choose>
            <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='box']">
                <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='box']"/>
            </xsl:when>
            <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='box']">
                <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='box']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(ead:container[@type='Box'],'-') or contains(ead:container[@type='Box'],'–') or contains(ead:container[@type='Box'],'—')">
                        <xsl:text>Boxes</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Box</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="ptr.folder.label">
        <xsl:choose>
            <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='folder']">
                <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='folder']"/>
            </xsl:when>
            <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder']">
                <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(ead:container[@type='Folder'],'-') or contains(ead:container[@type='Folder'],'–') or contains(ead:container[@type='Folder'],'—')">
                        <xsl:text>Folders</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Folder</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="ptr.reel.label">
        <xsl:choose>
            <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='reel']">
                <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='reel']"/>
            </xsl:when>
            <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel']">
                <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="contains(ead:container[@type='Reel'],'-') or contains(ead:container[@type='Reel'],'–') or contains(ead:container[@type='Reel'],'—')">
                        <xsl:text>Reels</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Reel</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Inline <extref> Template -->
    <xsl:template match="ead:extref" mode="inline">
        <a>
            <xsl:if test="@xlink:show='new'">
                <xsl:attribute name="rel">
                    <xsl:text>external</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="href">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates mode="inline"/>
        </a>
    </xsl:template>
    
    <!-- Inline <extptr> Template -->
    <xsl:template match="ead:extptr" mode="inline">
        <xsl:choose>
            <xsl:when test="ancestor::ead:dsc and normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1'">
                <xsl:element name="a">
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@xlink:href"/>
                    </xsl:attribute>
                    <xsl:call-template name="extptr.img"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="extptr.img"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Inline <extptr> <img> call template -->
    <xsl:template name="extptr.img">
        <img class="extptr">
            <xsl:attribute name="src">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="ancestor::ead:eadheader"/>
                <xsl:otherwise>
                    <xsl:attribute name="style">
                        <xsl:text>float: right;</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@xlink:title">
                    <xsl:attribute name="title">
                        <xsl:value-of select="@xlink:title"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select="@xlink:title"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="title">
                        <xsl:text>linked image</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:text>linked image</xsl:text>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1' or 
                normalize-space(/ead:ead//ead:eadid)='music.mss.0014.2' or 
                normalize-space(/ead:ead//ead:eadid)='music.mss.0014.3' and ancestor::ead:dsc">
                <xsl:attribute name="style">
                    <xsl:text>width:550px;</xsl:text>
                </xsl:attribute>
            </xsl:if>
        </img>
    </xsl:template>
    
    <!-- Inline <title> template  -->
    <xsl:template match="ead:title" mode="inline">
        <xsl:choose>
            <xsl:when test="@render='bold'">
                <strong><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='italic'">
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:when>
            <xsl:when test="@render='bolditalic'">
                <strong><em><xsl:apply-templates mode="inline"/></em></strong>
            </xsl:when>
            <xsl:when test="@render='singlequote'">
                <xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text>
            </xsl:when>
            <xsl:when test="@render='boldsinglequote'">
                <strong><xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='doublequote'">
                <xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@render='bolddoublequote'">
                <strong><xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='smcaps'">
                <span class="smcaps"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldsmcaps'">
                <strong class="smcaps"><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='underline'">
                <span class="uline"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldunderline'">
                <strong><span class="uline"><xsl:apply-templates mode="inline"/></span></strong>
            </xsl:when>
            <xsl:when test="@render='sub'">
                <sub><xsl:apply-templates mode="inline"/></sub>
            </xsl:when>
            <xsl:when test="@render='super'">
                <super><xsl:apply-templates mode="inline"/></super>
            </xsl:when>
            <xsl:when test="@render='nonproport'">
                <tt class="nonproport"><xsl:apply-templates mode="inline"/></tt>
            </xsl:when>
            <xsl:when test="@render='altrender'">
                <xsl:apply-templates mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Inline <persname> template  -->
    <xsl:template match="ead:persname" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <corpname> template  -->
    <xsl:template match="ead:corpname" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <subarea> template  -->
    <!-- Not supported by Yale Best Practices, but possibly present from legacy files. -->
    <xsl:template match="ead:subarea" mode="inline">
        <xsl:choose>
            <xsl:when test="ancestor::ead:repository and (preceding-sibling::text() | preceding-sibling::*)">
                <br/>
                    <xsl:apply-templates mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                    <xsl:apply-templates mode="inline"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Inline <famname> template  -->
    <xsl:template match="ead:famname" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <name> template  -->
    <xsl:template match="ead:name" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <subject> template  -->
    <xsl:template match="ead:subject" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <geogname> template  -->
    <xsl:template match="ead:geogname" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <genreform> template  -->
    <xsl:template match="ead:genreform" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <occupation> template  -->
    <xsl:template match="ead:occupation" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <function> template  -->
    <xsl:template match="ead:function" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <num> template  -->
    <xsl:template match="ead:num" mode="inline">
        <xsl:param name="titleproperInclude"/>
        <xsl:choose>
            <xsl:when test="parent::ead:titleproper">
                <xsl:if test="$titleproperInclude='yes'">
                    <xsl:apply-templates mode="inline"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="inline"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Inline <date> template  -->
    <xsl:template match="ead:date" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <unitdate> template  -->
    <xsl:template match="ead:unitdate" mode="inline">
        <xsl:text> </xsl:text><xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <unitid> template -->
    <xsl:template match="ead:unitid[not(parent::ead:did[parent::ead:archdesc])]" mode="inline">
        <xsl:variable name="unitid_string">
            <xsl:value-of select="normalize-space(.)"/>
        </xsl:variable>
        <xsl:variable name="unitid_string_length">
            <xsl:value-of select="string-length($unitid_string)"/>
        </xsl:variable>
        <xsl:variable name="unitid_last">
            <xsl:value-of select="substring($unitid_string,$unitid_string_length,$unitid_string_length)"/>
        </xsl:variable>
        <xsl:apply-templates mode="inline"/>
        <xsl:if test="not($unitid_last='.')">
            <xsl:text>.</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <!-- Inline <extent> template  -->
    <xsl:template match="ead:extent" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <dimensions> template  -->
    <xsl:template match="ead:dimensions" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- Inline <physfacet> template  -->
    <xsl:template match="ead:physfacet" mode="inline">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>

     <!-- Highlighting terms template ERJ 11/17/10-->
    <!-- Commented 2011-01-26 MR -->
    <!-- Uncommented 2011-04-01 ERJ-->
    <xsl:template match="ead:em" mode="inline">
        <span class="hitHighlight">
            <xsl:apply-templates mode="inline"/>
        </span> 
    </xsl:template> 
    
    <!-- Highlighting template for Table of Contents MR 2011-01-11 -->
    <!-- Commented 2011-01-26 MR -->
    <!--Uncommented 2011-04-01 ERJ-->
    <xsl:template match="ead:em" mode="navInline">
        <span class="hitHighlight">
            <xsl:apply-templates mode="inline"/>
        </span>
    </xsl:template>
    
    <!-- noHightlight mode template for ead:em. -->
    <!-- Used to avoid loss of spaces when generating strings for Aeon, BRBL DL call number search. -->
    <xsl:template match="ead:em" mode="noHighlight">
        <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:template>
    
    <!--  navInline Title template  -->
    <xsl:template match="ead:title" mode="navInline">
        <xsl:choose>
            <xsl:when test="@render='bold'">
                <strong><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='italic'">
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:when>
            <xsl:when test="@render='bolditalic'">
                <strong><em><xsl:apply-templates mode="inline"/></em></strong>
            </xsl:when>
            <xsl:when test="@render='singlequote'">
                <xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text>
            </xsl:when>
            <xsl:when test="@render='boldsinglequote'">
                <strong><xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='doublequote'">
                <xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@render='bolddoublequote'">
                <strong><xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='smcaps'">
                <span class="smcaps"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldsmcaps'">
                <strong class="smcaps"><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='underline'">
                <span class="uline"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldunderline'">
                <strong><span class="uline"><xsl:apply-templates mode="inline"/></span></strong>
            </xsl:when>
            <xsl:when test="@render='sub'">
                <sub><xsl:apply-templates mode="inline"/></sub>
            </xsl:when>
            <xsl:when test="@render='super'">
                <super><xsl:apply-templates mode="inline"/></super>
            </xsl:when>
            <xsl:when test="@render='nonproport'">
                <tt class="nonproport"><xsl:apply-templates mode="inline"/></tt>
            </xsl:when>
            <xsl:when test="@render='altrender'">
                <xsl:apply-templates mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- navInline <emph> template  -->
    <xsl:template match="ead:emph" mode="navInline">
        <xsl:choose>
            <xsl:when test="@render='bold'">
                <strong><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='italic'">
                <em><xsl:apply-templates mode="inline"/></em>
            </xsl:when>
            <xsl:when test="@render='bolditalic'">
                <strong><em><xsl:apply-templates mode="inline"/></em></strong>
            </xsl:when>
            <xsl:when test="@render='singlequote'">
                <xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text>
            </xsl:when>
            <xsl:when test="@render='boldsinglequote'">
                <strong><xsl:text>'</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>'</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='doublequote'">
                <xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="@render='bolddoublequote'">
                <strong><xsl:text>"</xsl:text><xsl:apply-templates mode="inline"/><xsl:text>"</xsl:text></strong>
            </xsl:when>
            <xsl:when test="@render='smcaps'">
                <span class="smcaps"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldsmcaps'">
                <strong class="smcaps"><xsl:apply-templates mode="inline"/></strong>
            </xsl:when>
            <xsl:when test="@render='underline'">
                <span class="uline"><xsl:apply-templates mode="inline"/></span>
            </xsl:when>
            <xsl:when test="@render='boldunderline'">
                <strong><span class="uline"><xsl:apply-templates mode="inline"/></span></strong>
            </xsl:when>
            <xsl:when test="@render='sub'">
                <sub><xsl:apply-templates mode="inline"/></sub>
            </xsl:when>
            <xsl:when test="@render='super'">
                <sup><xsl:apply-templates mode="inline"/></sup>
            </xsl:when>
            <xsl:when test="@render='nonproport'">
                <tt class="nonproport"><xsl:apply-templates mode="inline"/></tt>
            </xsl:when>
            <xsl:when test="@render='altrender'">
                <xsl:apply-templates mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
                <strong><xsl:apply-templates  mode="inline"/></strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
