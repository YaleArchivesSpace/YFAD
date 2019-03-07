<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
  <!--
        ===========================================================================
        =          YUL Common XSLT for presenting EAD 2002 as XHTML ==  NAVIGATION module            =
        ===========================================================================
        
        version:	0.0.1
        status:	development
        created:	2006-06-12
        updated:	2011-12-01
        contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
        
    -->

  <!-- Called by yul.ead2002.xhtml.xslt, creates navigation pane -->
  <xsl:template name="navigator">
    <xsl:param name="view"/>
    <xsl:param name="c01Position"/>
    
    <div class="navigator">
      <div class="navigator_head">
        <xsl:apply-templates select="/ead:ead//ead:titleproper[not(@type='filing')]"
          mode="inline"/>
        <xsl:choose>
          <xsl:when test="/ead:ead//ead:titleproper[not(@type='filing')]/ead:num">
            <br/>
            <xsl:apply-templates select="/ead:ead//ead:titleproper[not(@type='filing')]/ead:num"
              mode="inline">
              <xsl:with-param name="titleproperInclude">
                <xsl:text>yes</xsl:text>
              </xsl:with-param>
            </xsl:apply-templates>
          </xsl:when>
          <xsl:otherwise>
            <br/>
            <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did/ead:unitid[1]" mode="inline"
            />
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <div class="navigator_body">
	<span class="menu_title">Table of Contents</span>
        <xsl:for-each select="/ead:ead/ead:archdesc">

          <ul class="mktree" id="tree1">
            
            <!-- Aeon Paging Request Entry-->
            <!--<xsl:if test="$includeAeonRequests='y'">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:text>aeonRequest</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:text>aeonRequest</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>aeon</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='aeon'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:if>-->
            
            <!-- Title Page Entry-->
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:text>TitlePage</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:text>titlepage</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>tp</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='tp'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            
            <!-- ead:archdesc/ead:did Contents Entry-->
            <xsl:for-each select="ead:did">
              <li>
                <xsl:element name="span">
                  <xsl:attribute name="style">
                    <xsl:text>font-weight: bold;</xsl:text>
                  </xsl:attribute>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$did_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>over</xsl:text>
                    <!--<xsl:text>did</xsl:text>-->
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='did' or $view='over'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
                </xsl:element>
                
                <xsl:if test="../ead:descgrp|../ead:bioghist[not(@encodinganalog='545')]|../ead:scopecontent|../ead:arrangement">
                  <ul>
                    
            <!-- ead:archdesc/ead:descgrp[@type='admininfo'] Contents Entry-->
                    <xsl:for-each select="../ead:descgrp[@type='admininfo']">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:text>admininfo</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$admininfo_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>over</xsl:text>
                    <!--<xsl:text>ai</xsl:text>-->
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='ai' or $view='over'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
                
                <xsl:if test="child::ead:*[not(self::ead:head)]">
                  <ul>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:descgrp[@type='provenance'] Contents Entry-->
                    <xsl:for-each select="ead:descgrp[@type='provenance']">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:text>provenance</xsl:text>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$provenance_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:acqinfo Contents Entry-->
                    <xsl:for-each select="ead:acqinfo">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$acqinfo_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:custodhist Contents Entry-->
                    <xsl:for-each select="ead:custodhist">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$custodhist_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:accessrestrict Contents Entry-->
                    <xsl:for-each select="ead:accessrestrict">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$accessrestrict_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:userestrict Contents Entry-->
                    <xsl:for-each select="ead:userestrict">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$userestrict_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:prefercite Contents Entry-->
                    <xsl:for-each select="ead:prefercite">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$prefercite_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:processinfo Contents Entry-->
                    <xsl:for-each select="ead:processinfo">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$processinfo_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:altformavail Contents Entry-->
                    <xsl:for-each select="ead:altformavail">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$altformavail_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:relatedmaterial Contents Entry-->
                    <xsl:for-each select="ead:relatedmaterial">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$relatedmaterial_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:separatedmaterial Contents Entry-->
                    <xsl:for-each select="ead:separatedmaterial">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$separatedmaterial_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:accruals Contents Entry-->
                    <xsl:for-each select="ead:accruals">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$accruals_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:appraisal Contents Entry-->
                    <xsl:for-each select="ead:appraisal">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$appraisal_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:originalsloc Contents Entry-->
                    <xsl:for-each select="ead:originalsloc">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$originalsloc_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:otherfindaid Contents Entry-->
                    <xsl:for-each select="ead:otherfindaid">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$otherfindaid_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:phystech Contents Entry-->
                    <xsl:for-each select="ead:phystech">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$phystech_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:fileplan Contents Entry-->
                    <xsl:for-each select="ead:fileplan">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$fileplan_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>

                    <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:bibliography Contents Entry-->
                    <xsl:for-each select="ead:bibliography">
                      <li>
                        <xsl:call-template name="nav.link">
                          <xsl:with-param name="local-name">
                            <xsl:value-of select="local-name()"/>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:choose>
                              <xsl:when test="@id">
                                <xsl:value-of select="@id"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="$bibliography_id"/>
                              </xsl:otherwise>
                            </xsl:choose>
                          </xsl:with-param>
                          <xsl:with-param name="targetView">
                            <xsl:text>over</xsl:text>
                            <!--<xsl:text>ai</xsl:text>-->
                          </xsl:with-param>
                          <xsl:with-param name="internal">
                            <xsl:choose>
                              <xsl:when test="$view='all' or $view='ai' or $view='over'">
                                <xsl:text>y</xsl:text>
                              </xsl:when>
                            </xsl:choose>
                          </xsl:with-param>
                        </xsl:call-template>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:if>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:bioghist (Non-545) Contents Entry-->
            <xsl:for-each
              select="../ead:bioghist[not(@encodinganalog='545')]">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="bioghist_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>over</xsl:text>
                    <!--<xsl:text>bh</xsl:text>-->
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='bh' or $view='over'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:scopecontent Contents Entry-->
                    <xsl:for-each select="../ead:scopecontent">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$scopecontent_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>over</xsl:text>
                    <!--<xsl:text>sc</xsl:text>-->
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='sc' or $view='over'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:arrangement Contents Entry-->
            <xsl:for-each select="../ead:arrangement">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="arrangement_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>over</xsl:text>
                    <!--<xsl:text>sc</xsl:text>-->
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='sc' or $view='over'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            
                    
                  </ul>
                </xsl:if>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:dsc Contents Entry-->
            <xsl:for-each select="ead:dsc">
              <li class="liOpen">
                <xsl:element name="span">
                  <xsl:attribute name="style">
                    <xsl:text>font-weight: bold;</xsl:text>
                  </xsl:attribute>
                <xsl:choose>
                  <xsl:when test="$multiple-c01-tables='n' or $view='dsc' or $view='all'">
                    <xsl:call-template name="nav.link">
                      <xsl:with-param name="local-name">
                        <xsl:value-of select="local-name()"/>
                      </xsl:with-param>
                      <xsl:with-param name="id">
                        <xsl:choose>
                          <xsl:when test="@id">
                            <xsl:value-of select="@id"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select="$dsc_id"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:with-param>
                      <xsl:with-param name="targetView">
                        <xsl:text>dsc</xsl:text>
                      </xsl:with-param>
                      <xsl:with-param name="internal">
                        <xsl:choose>
                          <xsl:when test="$view='all' or $view='dsc'">
                            <xsl:text>y</xsl:text>
                          </xsl:when>
                        </xsl:choose>
                      </xsl:with-param>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="$multiple-c01-tables='y'">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:apply-templates mode="navInline" select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$dsc_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                </xsl:choose>
                </xsl:element>
                
                
                <!-- ead:archdesc/ead:dsc/ead:c01 Contents Entry -->
                <xsl:if test="$multiple-c01-tables='y'">
                  <ul>
                  <xsl:for-each select="ead:c01">
                    <xsl:variable name="targetC01Position">
                      <xsl:value-of select="position()"/>
                    </xsl:variable>
                    <li>
                      <xsl:if test="ead:c02[@level='series']">
                        <xsl:attribute name="class">
                        <xsl:text>open</xsl:text>
                        </xsl:attribute>
                      </xsl:if>
                    <xsl:call-template name="nav.link">
                      <xsl:with-param name="local-name">
                        <xsl:value-of select="local-name()"/>
                      </xsl:with-param>
                      <xsl:with-param name="id">
                        <xsl:value-of select="@id" />
                      </xsl:with-param>
                      <xsl:with-param name="targetView">
                        <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                      </xsl:with-param>
                      <xsl:with-param name="internal">
                        <xsl:choose>
                          <xsl:when test="$targetC01Position=$c01Position or $view='all' or $view='dsc'">
                            <xsl:text>y</xsl:text>
                          </xsl:when>
                        </xsl:choose>
                      </xsl:with-param>
                    </xsl:call-template>
                      
                      <!-- ead:archdesc/ead:dsc/ead:c01/ead:c02 Contents Entry -->
                      <xsl:if test="ead:c02[@level='series' or @level='subseries']">
                        <ul>
                          <xsl:for-each select="ead:c02">
                            <li>
                              <xsl:call-template name="nav.link">
                                <xsl:with-param name="local-name">
                                  <xsl:value-of select="local-name()"/>
                                </xsl:with-param>
                                <xsl:with-param name="id">
                                  <xsl:value-of select="@id" />
                                </xsl:with-param>
                                <xsl:with-param name="targetView">
                                  <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                                </xsl:with-param>
                                <xsl:with-param name="internal">
                                  <xsl:choose>
                                    <xsl:when test="$targetC01Position=$c01Position or $view='all' or $view='dsc'">
                                      <xsl:text>y</xsl:text>
                                    </xsl:when>
                                  </xsl:choose>
                                </xsl:with-param>
                              </xsl:call-template>
                              
                              <!-- ead:archdesc/ead:dsc/ead:c01/ead:c02/ead:c03 Contents Entry -->
                              <xsl:if test="ead:c03[@level='subseries']">
                                <ul>
                                  <xsl:for-each select="ead:c03">
                                    <li>
                                      <xsl:call-template name="nav.link">
                                        <xsl:with-param name="local-name">
                                          <xsl:value-of select="local-name()"/>
                                        </xsl:with-param>
                                        <xsl:with-param name="id">
                                          <xsl:value-of select="@id" />
                                        </xsl:with-param>
                                        <xsl:with-param name="targetView">
                                          <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                                        </xsl:with-param>
                                        <xsl:with-param name="internal">
                                          <xsl:choose>
                                            <xsl:when test="$targetC01Position=$c01Position or $view='all' or $view='dsc'">
                                              <xsl:text>y</xsl:text>
                                            </xsl:when>
                                          </xsl:choose>
                                        </xsl:with-param>
                                      </xsl:call-template>
                                      
                                      <!-- ead:archdesc/ead:dsc/ead:c01/ead:c02/ead:c03/ead:c04 Contents Entry -->
                                      <xsl:if test="ead:c04[@level='subseries']">
                                        <ul>
                                          <xsl:for-each select="ead:c04">
                                            <li>
                                              <xsl:call-template name="nav.link">
                                                <xsl:with-param name="local-name">
                                                  <xsl:value-of select="local-name()"/>
                                                </xsl:with-param>
                                                <xsl:with-param name="id">
                                                  <xsl:value-of select="@id" />
                                                </xsl:with-param>
                                                <xsl:with-param name="targetView">
                                                  <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                                                </xsl:with-param>
                                                <xsl:with-param name="internal">
                                                  <xsl:choose>
                                                    <xsl:when test="$targetC01Position=$c01Position or $view='all' or $view='dsc'">
                                                      <xsl:text>y</xsl:text>
                                                    </xsl:when>
                                                  </xsl:choose>
                                                </xsl:with-param>
                                              </xsl:call-template>
                                              
                                              <!-- ead:archdesc/ead:dsc/ead:c01/ead:c02/ead:c03/ead:c04/ead:c05 Contents Entry -->
                                              <xsl:if test="ead:c05[@level='subseries']">
                                                <ul>
                                                  <xsl:for-each select="ead:c05">
                                                    <li>
                                                      <xsl:call-template name="nav.link">
                                                        <xsl:with-param name="local-name">
                                                          <xsl:value-of select="local-name()"/>
                                                        </xsl:with-param>
                                                        <xsl:with-param name="id">
                                                          <xsl:value-of select="@id" />
                                                        </xsl:with-param>
                                                        <xsl:with-param name="targetView">
                                                          <xsl:value-of select="concat('c01_',$targetC01Position)"/>
                                                        </xsl:with-param>
                                                        <xsl:with-param name="internal">
                                                          <xsl:choose>
                                                            <xsl:when test="$targetC01Position=$c01Position or $view='all' or $view='dsc'">
                                                              <xsl:text>y</xsl:text>
                                                            </xsl:when>
                                                          </xsl:choose>
                                                        </xsl:with-param>
                                                      </xsl:call-template>
                                                    </li>
                                                  </xsl:for-each>
                                                </ul>
                                              </xsl:if>
                                              
                                            </li>
                                          </xsl:for-each>
                                        </ul>
                                      </xsl:if>
                                      
                                    </li>
                                  </xsl:for-each>
                                </ul>
                              </xsl:if>
                              
                            </li>
                          </xsl:for-each>
                        </ul>
                      </xsl:if>
                      
                    </li>
                  </xsl:for-each>
                  </ul>
                </xsl:if>
                
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:odd Contents Entry-->
            <xsl:for-each select="ead:odd">
              <xsl:variable name="targetOddPosition">
                <xsl:value-of select="position()"/>
              </xsl:variable>
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="odd_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <!--<xsl:text>odd</xsl:text>-->
                    <xsl:value-of select="concat('odd_',$targetOddPosition)"/>
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $targetOddPosition=$oddPosition">
                      <!--<xsl:when test="$view='all' or $view='odd'">-->
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:index Contents Entry-->
            <xsl:for-each select="ead:index">
              <li>
                <xsl:call-template name="nav.link">
                  <xsl:with-param name="local-name">
                    <xsl:value-of select="local-name()"/>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="index_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="targetView">
                    <xsl:text>index</xsl:text>
                  </xsl:with-param>
                  <xsl:with-param name="internal">
                    <xsl:choose>
                      <xsl:when test="$view='all' or $view='index'">
                        <xsl:text>y</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:controlaccess Contents Entry-->
            <xsl:if test="$includeAccessTerms='y'">
              <xsl:for-each select="ead:controlaccess">
                <li>
                  <xsl:call-template name="nav.link">
                    <xsl:with-param name="local-name">
                      <xsl:value-of select="local-name()"/>
                    </xsl:with-param>
                    <xsl:with-param name="id">
                      <xsl:choose>
                        <xsl:when test="@id">
                          <xsl:value-of select="@id"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$controlaccess_id"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:with-param>
                    <xsl:with-param name="targetView">
                      <xsl:text>ca</xsl:text>
                    </xsl:with-param>
                    <xsl:with-param name="internal">
                      <xsl:choose>
                        <xsl:when test="$view='all' or $view='ca'">
                          <xsl:text>y</xsl:text>
                        </xsl:when>
                      </xsl:choose>
                    </xsl:with-param>
                  </xsl:call-template>
                </li>
              </xsl:for-each>
            </xsl:if>
          </ul>

        </xsl:for-each>
        
        <xsl:call-template name="nav.menu.options"/>
        
      </div>
    </div>
  </xsl:template>

  <xsl:template name="nav.link">
    <xsl:param name="label"/>
    <xsl:param name="local-name"/>
    <xsl:param name="id"/>
    <xsl:param name="targetView"/>
    <xsl:param name="internal"/>
    <a>
      <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="$internal='y'">
            <xsl:value-of select="concat('#',$id)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat($htmlURL2,'&amp;view=',$targetView,'#',$id)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="ead:head">
          <xsl:apply-templates mode="navInline" select="ead:head"/>
        </xsl:when>
        <xsl:when test="not(ead:head) and not($local-name='c01') and not($local-name='c02') 
          and not($local-name='c03') and not($local-name='c04') and not($local-name='c05')">
          <xsl:choose>
            <xsl:when test="$local-name='aeonRequest'">
              <xsl:text>Paging Request</xsl:text>
            </xsl:when>
            <xsl:when test="$local-name='TitlePage'">
              <xsl:text>Title Page</xsl:text>
            </xsl:when>
            <xsl:when test="$local-name='did'">
              <xsl:value-of select="$did_head"/>
            </xsl:when>
            <xsl:when test="$local-name='admininfo'">
              <xsl:value-of select="$admininfo_head"/>
            </xsl:when>
            <xsl:when test="$local-name='provenance'">
              <xsl:value-of select="$provenance_head"/>
            </xsl:when>
            <xsl:when test="$local-name='acqinfo'">
              <xsl:value-of select="$acqinfo_head"/>
            </xsl:when>
            <xsl:when test="$local-name='custodhist'">
              <xsl:value-of select="$custodhist_head"/>
            </xsl:when>
            <xsl:when test="$local-name='accessrestrict'">
              <xsl:value-of select="$accessrestrict_head"/>
            </xsl:when>
            <xsl:when test="$local-name='userestrict'">
              <xsl:value-of select="$userestrict_head"/>
            </xsl:when>
            <xsl:when test="$local-name='prefercite'">
              <xsl:value-of select="$prefercite_head"/>
            </xsl:when>
            <xsl:when test="$local-name='processinfo'">
              <xsl:value-of select="$processinfo_head"/>
            </xsl:when>
            <xsl:when test="$local-name='altformavail'">
              <xsl:value-of select="$altformavail_head"/>
            </xsl:when>
            <xsl:when test="$local-name='relatedmaterial'">
              <xsl:value-of select="$relatedmaterial_head"/>
            </xsl:when>
            <xsl:when test="$local-name='separatedmaterial'">
              <xsl:value-of select="$separatedmaterial_head"/>
            </xsl:when>
            <xsl:when test="$local-name='accruals'">
              <xsl:value-of select="$accruals_head"/>
            </xsl:when>
            <xsl:when test="$local-name='appraisal'">
              <xsl:value-of select="$appraisal_head"/>
            </xsl:when>
            <xsl:when test="$local-name='originalsloc'">
              <xsl:value-of select="$originalsloc_head"/>
            </xsl:when>
            <xsl:when test="$local-name='otherfindaid'">
              <xsl:value-of select="$otherfindaid_head"/>
            </xsl:when>
            <xsl:when test="$local-name='phystech'">
              <xsl:value-of select="$phystech_head"/>
            </xsl:when>
            <xsl:when test="$local-name='fileplan'">
              <xsl:value-of select="$fileplan_head"/>
            </xsl:when>
            <xsl:when test="$local-name='bibliography'">
              <xsl:value-of select="$bibliography_head"/>
            </xsl:when>
            <xsl:when test="$local-name='bioghist'">
              <xsl:value-of select="$bioghist_head"/>
            </xsl:when>
            <xsl:when test="$local-name='scopecontent'">
              <xsl:value-of select="$scopecontent_head"/>
            </xsl:when>
            <xsl:when test="$local-name='arrangement'">
              <xsl:value-of select="$arrangement_head"/>
            </xsl:when>
            <xsl:when test="$local-name='dsc'">
              <xsl:value-of select="$dsc_head"/>
            </xsl:when>
            <xsl:when test="$local-name='odd'">
              <xsl:value-of select="$odd_head"/>
            </xsl:when>
            <xsl:when test="$local-name='index'">
              <xsl:value-of select="$index_head"/>
            </xsl:when>
            <xsl:when test="$local-name='controlaccess'">
              <xsl:value-of select="$controlaccess_head"/>
            </xsl:when>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="not(ead:head) and ($local-name='c01' or $local-name='c02' or
          $local-name='c03' or $local-name='c04' or $local-name='c05')">
          <xsl:if test="ead:did//ead:unitid">
            <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="navInline"/>
          <!--<xsl:choose>
            <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
              <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
            </xsl:otherwise>
          </xsl:choose>-->
          <xsl:if test="ead:did//ead:unitdate[not(parent::ead:unittitle)]">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="ead:did//ead:unitdate[not(parent::ead:unittitle)][1]" mode="inline"/>
          </xsl:if>
        </xsl:when>
      </xsl:choose>
    </a>
    <xsl:choose>
      <xsl:when test="$local-name='aeonRequest'"/>
      <xsl:when test="$local-name='TitlePage'"/>
      <xsl:when test="$local-name='did'">
        <xsl:call-template name="nav.link.HitCount">
          <xsl:with-param name="descendentHitCount">
            <xsl:value-of select="number(count(descendant::ead:em) + count(parent::ead:archdesc/ead:descgrp//ead:em) +
              count(parent::ead:archdesc/ead:bioghist//ead:em) + count(parent::ead:archdesc/ead:scopecontent//ead:em) +
              count(parent::ead:archdesc/ead:arrangement//ead:em))"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$local-name='dsc'">
        <xsl:if test="$multiple-c01-tables='n'">
          <xsl:call-template name="nav.link.HitCount">
            <xsl:with-param name="descendentHitCount">
              <xsl:value-of select="count(descendant::ead:em)"/>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="nav.link.HitCount">
          <xsl:with-param name="descendentHitCount">
            <xsl:value-of select="count(descendant::ead:em)"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="nav.link.HitCount">
    <xsl:param name="descendentHitCount"/>
    <xsl:if test="not($descendentHitCount=0)">
      <strong>
        <xsl:text> [</xsl:text>
        <xsl:value-of select="$descendentHitCount"/>
        <xsl:choose>
          <xsl:when test="$descendentHitCount=1">
            <xsl:text> hit]</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> hits]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </strong>
    </xsl:if>
  </xsl:template>

  <xsl:template name="nav.link.Section">
    <xsl:if test="$view='all'">
      <div class="nav_link_generic">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat($htmlURL2,'&amp;view=over')"/>
          </xsl:attribute>
          <xsl:text>View finding aid by section</xsl:text>
        </a>
      </div>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="nav.link.Entire">
    <xsl:param name="big"/>
    
    <div class="nav_link_generic">
      <span style="color: red;"><xsl:text>View entire finding aid to search it. </xsl:text></span>
      <br/>
      <xsl:if test="not($big='y')">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="concat($htmlURL2,'&amp;view=all')"/>
          </xsl:attribute>
          <xsl:text>HTML</xsl:text>
        </a>
        <xsl:text> / </xsl:text>
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
    </div>
  </xsl:template>
  
  <xsl:template name="nav.link.topbott">
    <div class="nav_link_generic">
      <a>
        <xsl:attribute name="href">
          <xsl:text>#main</xsl:text>
        </xsl:attribute>
        <xsl:text>Top</xsl:text>
      </a>
    </div>
  </xsl:template>
  
  <xsl:template name="nav.menu.options">
    <div class="nav_link_generic">
      <span style="color: #d87a00;"><xsl:text>Navigation options: </xsl:text></span>
      <br/>
      <a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="onclick">
          <xsl:text>expandTree('tree1'); return false;</xsl:text>
        </xsl:attribute>
        <xsl:text>Expand Menu</xsl:text>
      </a>
      <xsl:text> / </xsl:text>
      <a>
        <xsl:attribute name="href">
          <xsl:text>#</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="onclick">
          <xsl:text>collapseTree('tree1'); return false;</xsl:text>
        </xsl:attribute>
        <xsl:text>Collapse Menu</xsl:text>
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
