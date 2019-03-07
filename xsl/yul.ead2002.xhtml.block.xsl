<?xml version="1.0" encoding="UTF-8"?>
<!--
    =============================================================================
    =          YUL Common XSLT for presenting EAD 2002 as XHTML == Block Elements Module            =
    =============================================================================
    
    version:	0.0.1
    status:	development
    created:	2007-01-26
    updated:	2011-11-18
    contact:	michael.rush@yale.edu, mssa.systems@yale.edu, 
    
-->
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="xsl ead xlink xsi">
    
    <!-- Hide elements with altrender nodisplay and internal audience attributes-->
    <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="block"/>-->
    <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="block"/>-->

    <!--  Block <head> Templates -->
    <xsl:template match="ead:head" mode="block">
        <xsl:choose>
            <xsl:when test="parent::ead:*/parent::ead:descgrp[@type='admininfo']">
                <h3>
                    <xsl:apply-templates mode="inline"/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::ead:bioghist/parent::ead:bioghist">
                <h3>
                    <xsl:apply-templates mode="inline"/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::ead:controlaccess/parent::ead:controlaccess">
                <h3>
                    <xsl:apply-templates mode="inline"/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::ead:chronlist">
                <h3>
                    <xsl:apply-templates mode="inline"/>
                </h3>
            </xsl:when>
            <xsl:when test="parent::ead:*/parent::ead:descgrp[@type='provenance']"/>
            <xsl:otherwise>
                <h2>
                    <xsl:apply-templates mode="inline"/>
                </h2>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--  Block <p> Template  -->
    <xsl:template match="ead:p" mode="block">
        <xsl:choose>
            <xsl:when test="ancestor::ead:c01">
                <p class="c0x">
                    <xsl:apply-templates mode="inline"/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates mode="inline"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--  Block <bibref> Template  -->
    <xsl:template match="ead:bibref" mode="block">
        <xsl:choose>
            <xsl:when test="ancestor::ead:c01">
                <p class="bibref-c0x">
                    <xsl:apply-templates mode="inline"/>
                </p>
            </xsl:when>
            <xsl:otherwise>
                <p class="bibref">
                    <xsl:apply-templates mode="inline"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--  Block <blockquote> Template  -->
    <xsl:template match="ead:blockquote" mode="block">
        <blockquote>
            <xsl:apply-templates mode="block"/>
        </blockquote>
    </xsl:template>

    <!--  Block <address> Template -->
    <xsl:template match="ead:address" mode="block">
        <address> 
            <xsl:choose>
                <xsl:when test="$repository_code = 'beinecke'">
                    <xsl:call-template name="brblRepositoryAddress-for-overview"/>
                </xsl:when>
                <xsl:otherwise>
                       <xsl:apply-templates mode="block"/>
                </xsl:otherwise>
            </xsl:choose>
        </address>
    </xsl:template>
    
    <!-- Block <addressline> Template -->
    <xsl:template match="ead:addressline" mode="block">
        <xsl:choose>
            <xsl:when test="starts-with(normalize-space(.),'Email') or starts-with(normalize-space(.),'email')">
                <xsl:variable name="addressline_string" select="normalize-space(.)"/>
                <xsl:variable name="addressline_string_before_space" select="substring-before($addressline_string,' ')"/>
                <xsl:variable name="addressline_string_after_space_normal" select="normalize-space(substring-after($addressline_string,' '))"/>
                <xsl:value-of select="$addressline_string_before_space"/><xsl:text> </xsl:text>
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>mailto:</xsl:text>
                        <xsl:value-of select="$addressline_string_after_space_normal"/>
                    </xsl:attribute>
                    <xsl:value-of select="$addressline_string_after_space_normal"/>
                </a>
            </xsl:when>
            <xsl:when test="starts-with(normalize-space(.),'Web') or starts-with(normalize-space(.),'web')">
                <xsl:variable name="addressline_string" select="normalize-space(.)"/>
                <xsl:variable name="addressline_string_before_space" select="substring-before($addressline_string,' ')"/>
                <xsl:variable name="addressline_string_after_space_normal" select="normalize-space(substring-after($addressline_string,' '))"/>
                <xsl:value-of select="$addressline_string_before_space"/><xsl:text> </xsl:text>
                <a>
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$addressline_string_after_space_normal"/>
                    </xsl:attribute>
                    <xsl:value-of select="$addressline_string_after_space_normal"/>
                </a>
            </xsl:when>
            <xsl:when test="starts-with(normalize-space(.),'http') and not(contains(normalize-space(.),' '))">
                <xsl:variable name="addressline_string" select="normalize-space(.)"/>
                <a>
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="href">
                        <xsl:value-of select="$addressline_string"/>
                    </xsl:attribute>
                    <xsl:value-of select="$addressline_string"/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="inline"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="position()!=last()">
            <br/>
        </xsl:if>
    </xsl:template>

    <!--  Block <list> Template -->
    <xsl:template match="ead:list" mode="block">
        <xsl:choose>
            <xsl:when test="@type='ordered'">
                <ol>
                    <xsl:attribute name="style">
                        <xsl:choose>
                            <xsl:when test="@numeration='arabic'">
                                <xsl:text>list-style-type: decimal;</xsl:text>
                            </xsl:when>
                            <xsl:when test="@numeration='upperalpha'">
                                <xsl:text>list-style-type: upper-alpha;</xsl:text>
                            </xsl:when>
                            <xsl:when test="@numeration='loweralpha'">
                                <xsl:text>list-style-type: lower-alpha;</xsl:text>
                            </xsl:when>
                            <xsl:when test="@numeration='upperroman'">
                                <xsl:text>list-style-type: upper-roman;</xsl:text>
                            </xsl:when>
                            <xsl:when test="@numeration='lowerroman'">
                                <xsl:text>list-style-type: lower-roman;</xsl:text>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:for-each select="ead:item">
                        <li>
                            <xsl:if test="@id">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="@id"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:apply-templates mode="inline"/>
                        </li>
                    </xsl:for-each>
                </ol>
            </xsl:when>
            <xsl:when test="@type='marked'">
                <ul>
                    <xsl:for-each select="ead:item">
                        <li>
                            <xsl:apply-templates mode="inline"/>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:when>
            <xsl:when test="@type='deflist'">
                <dl>
                    <xsl:if test="ead:listhead">
                        <xsl:for-each select="ead:listhead">
                            <xsl:for-each select="ead:head01">
                                <dt>
                                    <strong>
                                        <xsl:apply-templates mode="inline"/>
                                    </strong>
                                </dt>
                            </xsl:for-each>
                            <xsl:for-each select="ead:head02">
                                <dd>
                                    <strong>
                                        <xsl:apply-templates mode="inline"/>
                                    </strong>
                                </dd>
                            </xsl:for-each>
                        </xsl:for-each>
                    </xsl:if>
                    <xsl:for-each select="ead:defitem">
                        <xsl:for-each select="ead:label">
                            <dt>
                                <xsl:apply-templates mode="inline"/>
                            </dt>
                        </xsl:for-each>
                        <xsl:for-each select="ead:item">
                            <dd>
                                <xsl:apply-templates mode="inline"/>
                            </dd>
                        </xsl:for-each>
                    </xsl:for-each>
                </dl>
            </xsl:when>
            <xsl:when test="@type='simple'">
                <p>
                    <xsl:for-each select="ead:item">
                        <xsl:apply-templates mode="inline"/>
                        <xsl:if test="position()!=last()">
                            <br/>
                        </xsl:if>
                    </xsl:for-each>
                </p>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!--  Block <chronlist> Templates -->
    <xsl:template match="ead:chronlist" mode="block">
        <xsl:apply-templates select="ead:head" mode="block"/>
        <table class="chronlist">
            <xsl:for-each select="ead:listhead">
                <tr>
                    <th class="chrondate">
                        <xsl:apply-templates select="ead:head01" mode="inline"/>
                    </th>
                    <th class="chronevent">
                        <xsl:apply-templates select="ead:head02" mode="inline"/>
                    </th>
                </tr>
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="not(ead:chronitem/ead:date[not(@normal)])">
                    <xsl:apply-templates select="ead:chronitem" mode="block">
                        <xsl:sort select="ead:date/@normal"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="ead:chronitem" mode="block"/>
                </xsl:otherwise>
            </xsl:choose>
        </table>
    </xsl:template>
    
    <!-- Block <chronitem> Template. -->
    <!-- Creates table rows for each <chronitem> -->
    <xsl:template match="ead:chronitem" mode="block">
        <xsl:variable name="odd_or_even">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">even</xsl:when>
                <xsl:otherwise>odd</xsl:otherwise>
            </xsl:choose> 
        </xsl:variable>
        <tr>
            <xsl:for-each select="ead:date">
                <td>
                    <xsl:attribute name="class">
                        <xsl:choose>
                            <xsl:when test="$odd_or_even='odd'">
                                <xsl:text>chrondate-1</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>chrondate-2</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:apply-templates mode="inline"/>
                </td>
            </xsl:for-each>
            <xsl:choose>
                <xsl:when test="ead:eventgrp">
                    <xsl:for-each select="ead:eventgrp">
                        <td>
                            <xsl:attribute name="class">
                                <xsl:choose>
                                    <xsl:when test="$odd_or_even='odd'">
                                        <xsl:text>chronevent-1</xsl:text>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>chronevent-2</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                            <xsl:for-each select="ead:event">
                                <xsl:apply-templates mode="inline"/>
                                <xsl:if test="position()!=last()">
                                    <br />
                                </xsl:if>
                            </xsl:for-each>
                        </td>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <td>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="$odd_or_even='odd'">
                                    <xsl:text>chronevent-1</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>chronevent-2</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <xsl:apply-templates select="ead:event" mode="inline"/>
                    </td>
                </xsl:otherwise>
            </xsl:choose>
        </tr>
    </xsl:template>
    
    <!-- Block <table> Template -->
    <xsl:template match="ead:table" mode="block">
        <table>
            <xsl:apply-templates mode="block"/>
        </table>
    </xsl:template>
    
    <!-- Block <tgroup> Template  -->
    <xsl:template match="ead:tgroup" mode="block">
        <tr>
            <xsl:call-template name="table-column">
                <xsl:with-param name="cols">
                    <xsl:value-of select="@cols"/>
                </xsl:with-param>
                <xsl:with-param name="width_percent">
                    <xsl:value-of select="100 div @cols"/>
                </xsl:with-param>
            </xsl:call-template>
        </tr>
        <xsl:apply-templates mode="block"/>
    </xsl:template>
    
    <!-- Template called by Block <tgroup> Template--> 
    <!-- Inserts <td>s necessary to set columns widths. -->
    <xsl:template name="table-column">
        <xsl:param name="cols"/>
        <xsl:param name="width_percent"/>
        <xsl:if test="$cols > 0">
            <td>
                <xsl:attribute name="style">
                    <xsl:text>width: </xsl:text><xsl:value-of select="$width_percent"/><xsl:text>%;</xsl:text>
                </xsl:attribute>
            </td>
            <xsl:call-template name="table-column">
                <xsl:with-param name="cols">
                    <xsl:value-of select="$cols - 1"/>
                </xsl:with-param>
                <xsl:with-param name="width_percent">
                    <xsl:value-of select="$width_percent"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- Block <thead> Template for tables -->
    <xsl:template match="ead:thead[not(parent::ead:dsc)][not(parent::ead:c01)]" mode="block">
        <xsl:apply-templates mode="block"/>
    </xsl:template>
    
    <!-- Block <thead> Template for for <dsc> theads -->
    <!-- Suppresses <dsc> and <c01> theads -->
    <xsl:template match="ead:thead[parent::ead:dsc or parent::ead:c01]" mode="block"/>
    
    <!-- Block <tbody> Template -->
    <xsl:template match="ead:tbody" mode="block">
        <xsl:apply-templates mode="block"/>
    </xsl:template>
    
    <!-- Block <row> Template -->
    <xsl:template match="ead:row" mode="block">
        <tr>
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="ancestor::ead:thead">
                        <xsl:text>thead</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>tbody</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates mode="block"/>
        </tr>
    </xsl:template>
    
    <!-- Block <entry> Template -->
    <xsl:template match="ead:entry" mode="block">
        <xsl:choose>
            <xsl:when test="ancestor::ead:thead">
                <th>
                    <xsl:call-template name="align-test"/>
                    <xsl:apply-templates mode="inline"/>
                </th>
            </xsl:when>
            <xsl:otherwise>
                <td>
                    <xsl:call-template name="align-test"/>
                    <xsl:apply-templates mode="inline"/>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template called by Block <entry> Template -->
    <!-- Inserts appropriate style based on @align and @valign -->
    <xsl:template name="align-test">
        <xsl:if test="@align | @valign">
            <xsl:attribute name="style">
                <xsl:choose>
                    <xsl:when test="@align='left'">
                        <xsl:text>text-align: left; </xsl:text>
                    </xsl:when>
                    <xsl:when test="@align='right'">
                        <xsl:text>text-align: right; </xsl:text>
                    </xsl:when>
                    <xsl:when test="@align='center'">
                        <xsl:text>text-align: center; </xsl:text>
                    </xsl:when>
                    <xsl:when test="@align='justify'">
                        <xsl:text>text-align: justify; </xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="@valign='top'">
                        <xsl:text>vertical-align: top; </xsl:text>
                    </xsl:when>
                    <xsl:when test="@valign='middle'">
                        <xsl:text>vertical-align: middle; </xsl:text>
                    </xsl:when>
                    <xsl:when test="@valign='bottom'">
                        <xsl:text>vertical-align: bottom; </xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!--  Block <div> Template -->
    <!--  <div> is not supported by Yale EAD BPGs, gives error message if found. -->
    <xsl:template match="ead:div" mode="block">
        <xsl:message>ead:div not rendered. </xsl:message>
    </xsl:template>
    
    <!--  Block <bioghist> template. -->
    <xsl:template match="ead:bioghist" mode="block">
        <div class="sub_block">
            <xsl:apply-templates mode="block"/>
        </div>
    </xsl:template>
    
    <!--  Block <controlaccess> template. -->
    <xsl:template match="ead:controlaccess" mode="block">
        <div class="sub_block">
            <xsl:apply-templates mode="block"/>
        </div>
    </xsl:template>
    
    <!--  Block <odd> template. -->
    <xsl:template match="ead:odd" mode="block">
        <div class="sub_block">
            <xsl:apply-templates mode="block"/>
        </div>
    </xsl:template>
    
    <!--  Block <persname> template  -->
    <xsl:template match="ead:persname" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <corpname> template  -->
    <xsl:template match="ead:corpname" mode="block">
        <xsl:choose>
            <xsl:when test="not(parent::ead:repository)">
                <div class="accessterm">
                    <xsl:apply-templates mode="inline"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <a rel="external">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$repository_link"/>
                    </xsl:attribute>
                    <xsl:apply-templates mode="inline"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--  Block <famname> template  -->
    <xsl:template match="ead:famname" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <name> template  -->
    <xsl:template match="ead:name" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <subject> template  -->
    <xsl:template match="ead:subject" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <geogname> template  -->
    <xsl:template match="ead:geogname" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <genreform> template  -->
    <xsl:template match="ead:genreform" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <occupation> template  -->
    <xsl:template match="ead:occupation" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <function> template  -->
    <xsl:template match="ead:function" mode="block">
        <div class="accessterm">
            <xsl:apply-templates mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <title> template  -->
    <xsl:template match="ead:title" mode="block">
        <div class="accessterm">
            <xsl:apply-templates select="." mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <ref> template  -->
    <xsl:template match="ead:ref" mode="block">
        <div class="blocklinks">
            <xsl:apply-templates select="." mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <ptr> template  -->
    <xsl:template match="ead:ptr" mode="block">
        <div class="blocklinks">
            <xsl:apply-templates select="." mode="inline"/>
        </div>
    </xsl:template>
    
    <!--  Block <c01> template  -->
    <xsl:template match="ead:c01" mode="block"/>

</xsl:stylesheet>