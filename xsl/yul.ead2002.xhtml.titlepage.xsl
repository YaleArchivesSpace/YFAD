<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
    <!--
            ==========================================================================
            =          YUL Common XSLT for presenting EAD 2002 as XHTML ==  TITLEPAGE module            =
            ==========================================================================
            
            version:	0.0.1
            status:	development
            created:	2006-06-12
            updated:	2010-03-15
            contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
            
    -->
    
    <!-- titlepage template -->
    <xsl:template name="titlepage">
        <xsl:param name="view"/>
        
            <div class="titlepage" id="titlepage">
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:publisher"
                    mode="titlepage"/>
                <xsl:apply-templates
                    select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:titleproper[@type='formal']"
                    mode="titlepage"/>
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:subtitle"
                    mode="titlepage"/>
                <xsl:call-template name="titlepage_callnumber"/>
                <xsl:call-template name="titlepage_image"/>
                <xsl:if
                    test="/ead:ead/ead:eadheader/ead:filedesc/ead:notestmt/ead:note[@type='frontmatter'][descendant::ead:extptr]">
                    <xsl:apply-templates
                        select="/ead:ead/ead:eadheader/ead:filedesc/ead:notestmt/ead:note[@type='frontmatter']"
                        mode="titlepage"/>
                </xsl:if>
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:author"
                    mode="titlepage"/>
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:titlestmt/ead:sponsor"
                    mode="titlepage"/>
                <xsl:call-template name="publication_dates"/>
                <xsl:call-template name="publicationAddress"/>
                <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:filedesc/ead:publicationstmt/ead:p"
                    mode="titlepage"/>
                <!--<xsl:apply-templates select="/ead:ead/ead:eadheader/ead:profiledesc/ead:creation" mode="titlepage"/>
                    <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:profiledesc/ead:langusage" mode="titlepage"/>
                    <xsl:apply-templates select="/ead:ead/ead:eadheader/ead:profiledesc/ead:descrules" mode="titlepage"/>-->
                <xsl:if
                    test="/ead:ead/ead:eadheader/ead:filedesc/ead:notestmt/ead:note[@type='frontmatter'][not(descendant::ead:extptr)]">
                    <xsl:apply-templates
                        select="/ead:ead/ead:eadheader/ead:filedesc/ead:notestmt/ead:note[@type='frontmatter']"
                        mode="titlepage"/>
                </xsl:if>
            </div>
            <xsl:if test="not($view='tp')">
                <hr/>
            </xsl:if>
        
    </xsl:template>
    
    <!-- eadheader publisher template -->
    <xsl:template match="ead:publisher" mode="titlepage">
        <div class="publisher">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!-- eadheader titleproper template -->
    <xsl:template match="ead:titleproper[not(@type='filing')]" mode="titlepage">
        <h1 class="titleproper">
            <xsl:apply-templates mode="inline"/>
        </h1>
    </xsl:template>
    
    <!-- eadheader subtitle template -->
    <xsl:template match="ead:subtitle" mode="titlepage">
        <h2 class="subtitle">
            <xsl:apply-templates mode="inline"/>
        </h2>
    </xsl:template>
    
    <!-- eadhedaer call number template -->
    <xsl:template name="titlepage_callnumber">
        <h2 class="callNum">
            <xsl:choose>
                <xsl:when test="/ead:ead//ead:titleproper[not(@type='filing')]/ead:num">
                    <xsl:apply-templates select="/ead:ead//ead:titleproper[not(@type='filing')]/ead:num"
                        mode="inline">
                        <xsl:with-param name="titleproperInclude">
                            <xsl:text>yes</xsl:text>
                        </xsl:with-param>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="/ead:ead/ead:archdesc/ead:did/ead:unitid[1]"
                        mode="inline"/>
                </xsl:otherwise>
            </xsl:choose>
        </h2>
    </xsl:template>
    
    <!-- eadheader titlepage image template -->
    <xsl:template name="titlepage_image">
        <xsl:if test="$include_titlepage_image='y'">
            <div class="titlepage_image">
                <xsl:call-template name="titlepage_image_link"/>
            </div>
        </xsl:if>
    </xsl:template>
    
    <!-- eadheader author template -->
    <xsl:template match="ead:author" mode="titlepage">
        <div class="author">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!-- eadheader sponsor template -->
    <xsl:template match="ead:sponsor" mode="titlepage">
        <div class="sponsor">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <xsl:template name="publication_dates">
        <div class="publication_dates">
            <xsl:if test="/ead:ead//ead:publicationstmt/ead:date[@type='original']">
                <!--<span class="titlepage_date_label">
                        <xsl:value-of select="$original_date_label"/>
                    </span>
                    <xsl:text> </xsl:text>-->
                <xsl:apply-templates
                    select="/ead:ead//ead:publicationstmt/ead:date[@type='original'][1]"
                    mode="inline">
                    <xsl:sort select="@normal" order="descending"/>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if
                test="not(/ead:ead//ead:publicationstmt/ead:date[@type='original']) and /ead:ead//ead:publicationstmt/ead:date[@type='ead']">
                <span class="titlepage_date_label">
                    <xsl:value-of select="$ead_date_label"/>
                </span>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="/ead:ead//ead:publicationstmt/ead:date[@type='ead'][1]"
                    mode="inline">
                    <xsl:sort select="@normal" order="descending"/>
                </xsl:apply-templates>
            </xsl:if>
            <xsl:if test="/ead:ead//ead:publicationstmt/ead:date[@type='copyright']">
                <br/>
                <span class="titlepage_date_label">
                    <xsl:value-of select="$copyright_date_label"/>
                </span>
                <xsl:text> </xsl:text>
                <xsl:apply-templates
                    select="/ead:ead//ead:publicationstmt/ead:date[@type='copyright'][1]"
                    mode="inline">
                    <xsl:sort select="@normal" order="descending"/>
                </xsl:apply-templates>
                <br/>
            </xsl:if>
            <xsl:choose>
                <xsl:when
                    test="/ead:ead//ead:publicationstmt/ead:date[@type='revised'] and not(/ead:ead//ead:revisiondesc/ead:change/ead:date)">
                    <br/>
                    <span class="titlepage_date_label">
                        <xsl:value-of select="$revised_date_label"/>
                    </span>
                    <xsl:text> </xsl:text>
                    <xsl:for-each
                        select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
                        <xsl:sort select="@normal" order="descending"/>
                        <xsl:if test="position()=1">
                            <xsl:apply-templates mode="inline"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when
                    test="not(/ead:ead//ead:publicationstmt/ead:date[@type='revised']) and /ead:ead//ead:revisiondesc/ead:change/ead:date">
                    <br/>
                    <span class="titlepage_date_label">
                        <xsl:value-of select="$revised_date_label"/>
                    </span>
                    <xsl:text> </xsl:text>
                    <xsl:for-each
                        select="/ead:ead//ead:revisiondesc/ead:change">
                        <xsl:sort select="ead:date/@normal" order="descending"/>
                        <xsl:if test="position()=1">
                            <xsl:apply-templates select="ead:date" mode="inline"/>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:when
                    test="/ead:ead//ead:publicationstmt/ead:date[@type='revised'] and /ead:ead//ead:revisiondesc/ead:change/ead:date">
                    <xsl:variable name="revisedDateLastNormal">
                        <xsl:for-each
                            select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
                            <xsl:sort select="@normal" order="descending"/>
                            <xsl:if test="position()=1">
                                <xsl:value-of select="@normal"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="revisedDateLast">
                        <xsl:choose>
                            <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=4">
                                <xsl:value-of select="concat(translate($revisedDateLastNormal,'-',''),'0000')"/>
                            </xsl:when>
                            <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=6">
                                <xsl:value-of select="concat(translate($revisedDateLastNormal,'-',''),'00')"/>
                            </xsl:when>
                            <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=8">
                                <xsl:value-of select="translate($revisedDateLastNormal,'-','')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="translate($revisedDateLastNormal,'-','')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="changeDateLastNormal">
                        <xsl:for-each
                            select="/ead:ead//ead:revisiondesc/ead:change">
                            <xsl:sort select="ead:date/@normal" order="descending"/>
                            <xsl:if test="position()=1">
                                <xsl:value-of select="ead:date/@normal"/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:variable name="changeDateLast">
                        <xsl:choose>
                            <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=4">
                                <xsl:value-of select="concat(translate($changeDateLastNormal,'-',''),'0000')"/>
                            </xsl:when>
                            <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=6">
                                <xsl:value-of select="concat(translate($changeDateLastNormal,'-',''),'00')"/>
                            </xsl:when>
                            <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=8">
                                <xsl:value-of select="translate($changeDateLastNormal,'-','')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="translate($changeDateLastNormal,'-','')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <br/>
                    <span class="titlepage_date_label">
                        <xsl:value-of select="$revised_date_label"/>
                    </span>
                    <xsl:text> </xsl:text>
                    <xsl:choose>
                        <xsl:when test="$changeDateLast &gt; $revisedDateLast">
                            <xsl:for-each
                                select="/ead:ead//ead:revisiondesc/ead:change">
                                <xsl:sort select="ead:date/@normal" order="descending"/>
                                <xsl:if test="position()=1">
                                    <xsl:apply-templates select="ead:date"/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:when test="$revisedDateLast &gt; $changeDateLast">
                            <xsl:for-each
                                select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
                                <xsl:sort select="@normal" order="descending"/>
                                <xsl:if test="position()=1">
                                    <xsl:apply-templates/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each
                                select="/ead:ead//ead:revisiondesc/ead:change">
                                <xsl:sort select="ead:date/@normal" order="descending"/>
                                <xsl:if test="position()=1">
                                    <xsl:apply-templates select="ead:date"/>
                                </xsl:if>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <!-- eadheader publication paragraph template -->
    <xsl:template match="ead:publicationstmt/ead:p" mode="titlepage">
        <div class="publicationstmt_p">
            <p><xsl:apply-templates mode="inline"/></p>
        </div>
    </xsl:template>
    
    <!-- eadheader frontmatter publication address template -->
    <xsl:template name="publicationAddress">
        <div class="publicationstmt_address">
            <xsl:choose>
                <xsl:when test="ead:filedesc/ead:publicationstmt/ead:address">
                    <xsl:apply-templates select="ead:filedesc/ead:publicationstmt/ead:address" mode="block"/>
                </xsl:when>
                <xsl:otherwise>
                    <address>
                        <xsl:value-of select="$publishplace" />
                    </address>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    
    <!-- eadheader frontmatter note template -->
    <xsl:template match="ead:notestmt/ead:note[@type='frontmatter']" mode="titlepage">
            <div class="frontmatter_note">
                <xsl:apply-templates mode="block"/>
            </div>
    </xsl:template>
    
    <!-- eadheader creation template -->
    <xsl:template match="ead:creation" mode="titlepage">
        <div class="creation">
            <p><xsl:apply-templates mode="inline"/></p>
        </div>
    </xsl:template>
    
    <!-- eadheader langusage template -->
    <xsl:template match="ead:langusage" mode="titlepage">
        <div class="langusage">
            <p><xsl:apply-templates mode="inline"/></p>
        </div>
    </xsl:template>
    
    <!-- eadheader descrules template -->
    <xsl:template match="ead:descrules" mode="titlepage">
        <div class="descrules">
            <p><xsl:apply-templates mode="inline"/></p>
        </div>
    </xsl:template>
    
    <!-- Finding aid handle citation template -->
    <xsl:template name="findingAidHandleCitation">
        <div class="faCitation">
            <p><xsl:text>To cite or bookmark this finding aid, use the following address: </xsl:text>
            <xsl:element name="a">
                <xsl:attribute name="rel">
                    <xsl:text>external</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:value-of select="$handleURL"/>
                </xsl:attribute>
                <xsl:value-of select="$handleURL"/>
            </xsl:element></p>
        </div>
    </xsl:template>

    </xsl:stylesheet>
