<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ead="urn:isbn:1-931666-22-9"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
        <!--
            ==========================================================================
            =          YUL Common XSLT for presenting EAD 2002 as XHTML == <c0x> module          =
            ==========================================================================
            
            version:	0.0.1
            status:	development
            created:	2007-01-29
            updated:	2015-12-10
            contact:	michael.rush@yale.edu, mssa.systems@yale.edu, mark.custer@yale.edu
            
            
        -->
    <!--removed a few variables from the Aeon links as they're no longer required (no longer created in the aeon.xsl file)--> 
    <!-- Hide elements with altrender nodisplay and internal audience attributes-->
    <!--<xsl:template match="*[@audience='internal']" priority="1" mode="c0x"/>-->
    <!--<xsl:template match="*[@altrender='nodisplay']" priority="2" mode="c0x"/>-->
    
    <!-- pattern for $containerpattern, which keys test for which container columns to include, when it tests just the current c01. -->
    <xsl:template name="containerpatternParamC01">
        <xsl:choose>
            <xsl:when
                test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>bfr</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>bf</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>br</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>b</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>f</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>r</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
                <xsl:text>none</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- pattern for $containerpattern, which keys test for which container columns to include, when it tests the entire dsc. -->
    <xsl:template name="containerpatternParamDsc">
        <xsl:choose>
            <xsl:when
                test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>bfr</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>bf</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>br</xsl:text>
            </xsl:when>
            <xsl:when
                test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>b</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>fr</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>f</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>r</xsl:text>
            </xsl:when>
            <xsl:when
                test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
                <xsl:text>none</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>none</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- This template uses $containerpattern to create sets of table-head table-cells for container headings as appropriate -->
    <xsl:template name="container.column.headers">
        <xsl:param name="containerpattern">
            <xsl:choose>
                <xsl:when test="$multiple-c01-tables='y'">
                    <xsl:call-template name="containerpatternParamC01"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="containerpatternParamDsc"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$containerpattern='bfr'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.box"/>
                <xsl:call-template name="container.column.header.folder"/>
                <xsl:call-template name="container.column.header.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='bf'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.box"/>
                <xsl:call-template name="container.column.header.folder"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='br'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.box"/>
                <xsl:call-template name="container.column.header.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='b'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.box"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='fr'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.folder"/>
                <xsl:call-template name="container.column.header.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='f'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.folder"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='r'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
                <xsl:call-template name="container.column.header.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='none'">
                <xsl:if test="$includeAeonRequests='y'">
                    <xsl:call-template name="container.column.header.request"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- This template determines the proper value for the @number-columns-spanned in the Description cell in the table-row for did siblings. -->
    <xsl:template name="desc.colspanParam">
        <xsl:param name="includeunitdatecolumn"/>
        <xsl:param name="containerpattern">
            <xsl:choose>
                <xsl:when test="$multiple-c01-tables='y'">
                    <xsl:call-template name="containerpatternParamC01"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="containerpatternParamDsc"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='n'">
                <xsl:number value="1"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='n'">
                <xsl:number value="2"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='bfr' and $includeAeonRequests='n'">
                <xsl:number value="4"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='bfr' and $includeAeonRequests='y'">
                <xsl:number value="5"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr') and $includeAeonRequests='n'">
                <xsl:number value="3"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr') and $includeAeonRequests='y'">
                <xsl:number value="4"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r') and $includeAeonRequests='n'">
                <xsl:number value="2"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r') and $includeAeonRequests='y'">
                <xsl:number value="3"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='none' and $includeAeonRequests='n'">
                <xsl:number value="1"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='none' and $includeAeonRequests='y'">
                <xsl:number value="2"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bfr') and $includeAeonRequests='n'">
                <xsl:number value="5"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bfr') and $includeAeonRequests='y'">
                <xsl:number value="6"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr') and $includeAeonRequests='n'">
                <xsl:number value="4"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr') and $includeAeonRequests='y'">
                <xsl:number value="5"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r') and $includeAeonRequests='n'">
                <xsl:number value="3"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r') and $includeAeonRequests='y'">
                <xsl:number value="4"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='none') and $includeAeonRequests='n'">
                <xsl:number value="2"/>
            </xsl:when>
            <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='none') and $includeAeonRequests='y'">
                <xsl:number value="3"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Table cell for Description header -->
    <xsl:template name="desc.column.header">
        <th class="desc">
                <xsl:choose>
                    <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='desc']">
                        <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='desc']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='desc']">
                                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='desc']"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Description</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- Table cell for Dates header -->
    <xsl:template name="unitdate.column.header">
        <th class="dates">
                <xsl:choose>
                    <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='dates']">
                        <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='dates']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='dates']">
                                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='dates']"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Date(s)</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- Table cell for Request header -->
    <xsl:template name="container.column.header.request">
        <!--<th class="req">-->
        <th class="box">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='request']">
                    <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='request']"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='request']">
                            <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='request']"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>Request</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- Table cell for Box header -->
    <xsl:template name="container.column.header.box">
        <th class="box">
                <xsl:choose>
                    <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='box']">
                        <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='box']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='box']">
                                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='box']"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Box</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- Table cell for Folder header -->
    <xsl:template name="container.column.header.folder">
        <th class="folder">
                <xsl:choose>
                    <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='folder']">
                        <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='folder']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='folder']">
                                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='folder']"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Folder</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- Table cell for Reel header -->
    <xsl:template name="container.column.header.reel">
        <th class="reel">
                <xsl:choose>
                    <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='reel']">
                        <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='reel']"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='reel']">
                                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='reel']"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>Reel</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
        </th>
    </xsl:template>
    
    <!-- This table creates the table header, with appropriate containers on right or left -->
    <xsl:template name="dsc.table.header">
        <xsl:param name="includeunitdatecolumn"/>
            <tr>
                <xsl:if test="$containersonright='n'">
                    <xsl:call-template name="container.column.headers"/>
                </xsl:if>
                <xsl:call-template name="desc.column.header"/>
                <xsl:if test="$includeunitdatecolumn='y'">
                    <xsl:call-template name="unitdate.column.header"/>
                </xsl:if>
                <xsl:if test="$containersonright='y'">
                    <xsl:call-template name="container.column.headers"/>
                </xsl:if>
            </tr>
    </xsl:template>
    
    <!-- This tempate creates sets of table body cells for containers -->
    <xsl:template name="container.table-cells">
        <xsl:param name="containerpattern">
            <xsl:choose>
                <xsl:when test="$multiple-c01-tables='y'">
                    <xsl:call-template name="containerpatternParamC01"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="containerpatternParamDsc"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="$containerpattern='bfr'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.box"/>
                <xsl:call-template name="container.table-cell.folder"/>
                <xsl:call-template name="container.table-cell.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='bf'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.box"/>
                <xsl:call-template name="container.table-cell.folder"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='br'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.box"/>
                <xsl:call-template name="container.table-cell.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='b'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.box"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='fr'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.folder"/>
                <xsl:call-template name="container.table-cell.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='f'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.folder"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='r'">
                <xsl:if test="$includeAeonRequests='y' and $containersonright='n'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
                <xsl:call-template name="container.table-cell.reel"/>
                <xsl:if test="$includeAeonRequests='y' and $containersonright='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$containerpattern='none'">
                <xsl:if test="$includeAeonRequests='y'">
                    <xsl:call-template name="container.table-cell.request"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <!-- Table Body cell for unitdate -->
    <xsl:template name="unitdate.table-cell">
        <td class="unitdate">
            <xsl:for-each select="ead:did//ead:unitdate[not(parent::ead:unittitle)][not(@type)]">
                <xsl:apply-templates mode="inline"/>
                <xsl:if test="position()!=last()">
                    <br/>
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="ead:did//ead:unitdate[not(parent::ead:unittitle)][not(@type)] 
                and (ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='inclusive'] or ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='bulk'])">
                <br/>
            </xsl:if>
            <xsl:apply-templates select="ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='inclusive']" mode="inline"/>
            <xsl:if test="ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='inclusive'] 
                and ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='bulk']">
                <br/>
            </xsl:if>
            <xsl:apply-templates select="ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='bulk']" mode="inline"/>
        </td>
    </xsl:template>
    
    <!-- Table Body cell for Aeon Request -->
    <xsl:template name="container.table-cell.request">
        <xsl:variable name="boxValue" select="normalize-space(ead:did//ead:container[@type='Box'])"/>
        <xsl:variable name="precedingBoxValue" select="normalize-space(preceding::ead:container[@type='Box'][1])"/>
        <xsl:variable name="ancestorOrSelfC01ID">
            <xsl:value-of select="ancestor-or-self::ead:c01/@id"/>
        </xsl:variable>
        <xsl:variable name="containerLabelBox">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='box']">
                    <xsl:value-of select="normalize-space(ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='box'])"/>
                </xsl:when>
                <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='box']">
                    <xsl:value-of select="normalize-space(ancestor::ead:dsc/ead:thead//ead:entry[@colname='box'])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ead:did//ead:container[@type='Box']/@type"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="containerLabelFolder">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='folder']">
                    <xsl:value-of select="normalize-space(ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='folder'])"/>
                </xsl:when>
                <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder']">
                    <xsl:value-of select="normalize-space(ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder'])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ead:did//ead:container[@type='Folder']/@type"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="containerLabelReel">
            <xsl:choose>
                <xsl:when test="ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='reel']">
                    <xsl:value-of select="normalize-space(ancestor-or-self::ead:c01/ead:thead//ead:entry[@colname='reel'])"/>
                </xsl:when>
                <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel']">
                    <xsl:value-of select="normalize-space(ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel'])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="ead:did//ead:container[@type='Reel']/@type"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <!--<td class="req">-->
        <td class="box">
            <xsl:choose>
                <xsl:when test="$officeOfOriginRequest='y' and ead:did//ead:container">
                    <xsl:call-template name="aeonRequest">
                        <xsl:with-param name="containerLabelBox">
                            <xsl:value-of select="$containerLabelBox"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelFolder">
                            <xsl:value-of select="$containerLabelFolder"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelReel">
                            <xsl:value-of select="$containerLabelReel"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="not(ead:did/ead:container) and (ead:did/ead:dao[@xlink:role='application/vnd.aeon'] or ead:did/ead:daogrp/ead:daoloc[@xlink:role='application/vnd.aeon'])">
                    <xsl:call-template name="aeonRequest">
                        <xsl:with-param name="containerLabelBox">
                            <xsl:value-of select="$containerLabelBox"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelFolder">
                            <xsl:value-of select="$containerLabelFolder"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelReel">
                            <xsl:value-of select="$containerLabelReel"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                
                <!-- new hack for beinecke.sok materials (in next yfad, all should be governed by Access Restriction codes in ASpace-->
                <xsl:when test="normalize-space(/ead:ead//ead:eadid)='beinecke.sok' and 
                    (ancestor-or-self::*/@id='ref2598' or ancestor-or-self::*/@id='c02.d0e48125')"/>
                   
                <xsl:when test="normalize-space(/ead:ead//ead:eadid)='beinecke.edwards' and not(ancestor-or-self::ead:c01[preceding-sibling::ead:c01]) and ead:did//ead:container">
                    <xsl:call-template name="aeonRequest">
                        <xsl:with-param name="containerLabelBox">
                            <xsl:value-of select="$containerLabelBox"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelFolder">
                            <xsl:value-of select="$containerLabelFolder"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelReel">
                            <xsl:value-of select="$containerLabelReel"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="ead:did//ead:container[@type='Box'] and not (preceding::ead:container[@type='Box'][1]/ancestor-or-self::ead:c01/@id=$ancestorOrSelfC01ID)">
                            <xsl:call-template name="aeonRequest">
                                <xsl:with-param name="containerLabelBox">
                                    <xsl:value-of select="$containerLabelBox"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelFolder">
                                    <xsl:value-of select="$containerLabelFolder"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelReel">
                                    <xsl:value-of select="$containerLabelReel"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="ead:did//ead:container[@type='Box'] and not ($boxValue=$precedingBoxValue)">
                            <xsl:call-template name="aeonRequest">
                                <xsl:with-param name="containerLabelBox">
                                    <xsl:value-of select="$containerLabelBox"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelFolder">
                                    <xsl:value-of select="$containerLabelFolder"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelReel">
                                    <xsl:value-of select="$containerLabelReel"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="ead:did//ead:container[not(@type='Box')] and not(ead:did//ead:container[@type='Box'])">
                            <xsl:call-template name="aeonRequest">
                                <xsl:with-param name="containerLabelBox">
                                    <xsl:value-of select="$containerLabelBox"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelFolder">
                                    <xsl:value-of select="$containerLabelFolder"/>
                                </xsl:with-param>
                                <xsl:with-param name="containerLabelReel">
                                    <xsl:value-of select="$containerLabelReel"/>
                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>
    
    <!-- Table Body cell for Box -->
    <xsl:template name="container.table-cell.box">
        <td class="box">
                <xsl:apply-templates select="ead:did//ead:container[@type='Box']" mode="inline"/>
         </td>
    </xsl:template>
    
    <!-- Table Body cell for Folder -->
    <xsl:template name="container.table-cell.folder">
        <td class="folder">
                <xsl:apply-templates select="ead:did//ead:container[@type='Folder']" mode="inline"/>
        </td>
    </xsl:template>
    
    <!-- Table Body cell for Reel -->
    <xsl:template name="container.table-cell.reel">
        <td class="reel">
            <xsl:apply-templates select="ead:did//ead:container[@type='Reel']" mode="inline"/>
            <xsl:if test="ead:did//ead:container[@type='Frame']">
                <xsl:text>:</xsl:text>
                <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Frame'])"/>
            </xsl:if>
        </td>
    </xsl:template>
    
    <!-- Template for constructing Aeon requests. -->
    <xsl:template name="aeonRequest">
        <xsl:param name="containerLabelBox"/>
        <xsl:param name="containerLabelFolder"/>
        <xsl:param name="containerLabelReel"/>
        <xsl:variable name="aeonResourceID">
            <xsl:call-template name="aeonResourceID">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonSeriesID">
            <xsl:call-template name="aeonSeriesID">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonSeriesTitle">
            <xsl:call-template name="aeonSeriesTitle">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonBox">
            <xsl:choose>
                <xsl:when test="ead:did/ead:container[@type='Box']">
                    <xsl:call-template name="aeonBox">
                        <xsl:with-param name="componentID">
                            <xsl:value-of select="@id"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelBox">
                            <xsl:value-of select="$containerLabelBox"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="not(ead:did/ead:container[@type='Box']) and not(ead:did/ead:container[@type='Folder']) and ead:did/ead:container[@type='Reel']">
                    <xsl:call-template name="aeonReel">
                        <xsl:with-param name="componentID">
                            <xsl:value-of select="@id"/>
                        </xsl:with-param>
                        <xsl:with-param name="containerLabelReel">
                            <xsl:value-of select="$containerLabelReel"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="aeonFolder">
            <xsl:call-template name="aeonFolder">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
                <xsl:with-param name="containerLabelFolder">
                    <xsl:value-of select="$containerLabelFolder"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonBarcode">
            <xsl:call-template name="aeonBarcode">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonLocation">
            <xsl:call-template name="aeonLocation">
                <xsl:with-param name="componentID">
                    <xsl:value-of select="@id"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="aeonURLFullString">
            <xsl:choose>
                <xsl:when test="$officeOfOriginRequest='y'">
                    <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBox,$aeonFolder,$aeonBarcode)"/>
                </xsl:when>
                <xsl:when test="not(ead:did/ead:container) and (ead:did/ead:dao[@xlink:role='application/vnd.aeon'] or ead:did/ead:daogrp/ead:daoloc[@xlink:role='application/vnd.aeon'])">
                    <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBarcode,$aeonFolder,$aeonLocation)"/>
                </xsl:when>
                <xsl:when test="ead:did/ead:container[@type='Box'] and normalize-space(/ead:ead//ead:eadid)='beinecke.edwards' and not(ancestor-or-self::ead:c01[preceding-sibling::ead:c01])">
                    <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBox,$aeonFolder,$aeonBarcode)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="ead:did/ead:container[@type='Box']">
                            <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBox,$aeonBarcode)"/>
                        </xsl:when>
                        <xsl:when test="not(ead:did/ead:container[@type='Box']) and ead:did/ead:container[@type='Folder']">
                            <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBox,$aeonFolder,$aeonBarcode)"/>
                        </xsl:when>
                        <xsl:when test="not(ead:did/ead:container[@type='Box']) and not(ead:did/ead:container[@type='Folder'])
                            and ead:did/ead:container[@type='Reel']">
                            <xsl:value-of select="concat($aeonBaseURL,$aeonForm,$aeonSite,$aeonResourceID,$aeonTitle,$aeonAuthor,$aeonEADNumber,$aeonCitation,$aeonSeriesID,$aeonSeriesTitle,$aeonBox,$aeonBarcode)"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$aeonURLFullString"/>
            </xsl:attribute>
            <xsl:attribute name="rel">
                <xsl:text>external</xsl:text>
            </xsl:attribute>
            <xsl:text>Request </xsl:text>
            <xsl:choose>
                <xsl:when test="$officeOfOriginRequest='y'"/>
                <xsl:when test="not(ead:did/ead:container) and (ead:did/ead:dao[@xlink:role='application/vnd.aeon'] or ead:did/ead:daogrp/ead:daoloc[@xlink:role='application/vnd.aeon'])"/>
                <xsl:when test="normalize-space(/ead:ead//ead:eadid)='beinecke.edwards' and not(ancestor-or-self::ead:c01[preceding-sibling::ead:c01]) and ead:did/ead:container[@type='Folder']">
                    <xsl:value-of select="$containerLabelFolder"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Folder'])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="ead:did/ead:container[@type='Box']">
                            <xsl:choose>
                                <xsl:when test="$repository_code='mssa' 
                                    and (contains(ead:did//ead:container[@type='Box'],'-')
                                    or contains(ead:did//ead:container[@type='Box'],'–')
                                    or contains(ead:did//ead:container[@type='Box'],'—')
                                    or contains(ead:did//ead:container[@type='Box'],','))">
                                    <xsl:value-of select="$containerLabelBox"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$containerLabelBox"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Box'])"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <!--<xsl:value-of select="$containerLabelBox"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Box'])"/>-->
                        </xsl:when>
                        <xsl:when test="not(ead:did/ead:container[@type='Box']) and ead:did/ead:container[@type='Folder']">
                            <xsl:value-of select="$containerLabelFolder"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Folder'])"/>
                        </xsl:when>
                        <xsl:when test="not(ead:did/ead:container[@type='Box']) and not(ead:did/ead:container[@type='Folder'])
                            and ead:did/ead:container[@type='Reel']">
                            <xsl:value-of select="$containerLabelReel"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Reel'])"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <!-- Table that is called when all c01s go into a single table. -->
    <xsl:template name="single-dsc-table">
        <xsl:param name="includeunitdatecolumn">
            <xsl:call-template name="includeUnitdateColumnParamTemplate"/>
        </xsl:param>
        <table class="dsc">
            <xsl:call-template name="dsc.table.header">
                <xsl:with-param name="includeunitdatecolumn">
                    <xsl:value-of select="$includeunitdatecolumn"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="ead:c01">
                <xsl:call-template name="dsc_table_row">
                    <xsl:with-param name="includeunitdatecolumn">
                        <xsl:value-of select="$includeunitdatecolumn"/>
                    </xsl:with-param>
                </xsl:call-template>
                <xsl:apply-templates select="ead:c02" mode="c0x">
                    <xsl:with-param name="includeunitdatecolumn">
                        <xsl:value-of select="$includeunitdatecolumn"/>
                    </xsl:with-param>
                </xsl:apply-templates>
            </xsl:for-each>
        </table>
    </xsl:template>
    
    <!-- <c01> Template (for when each <c01> gets it's own table. -->
    <xsl:template match="ead:c01" mode="c0x">
        <xsl:param name="includeunitdatecolumn">
            <xsl:call-template name="includeUnitdateColumnParamTemplate"/>
        </xsl:param>
        <xsl:if test="$multiple-c01-tables='y'">
            <h2 class="series_title">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
                <xsl:if test="ead:did//ead:unitid">
                    <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
                <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
            </h2>
        </xsl:if>
        <table class="dsc">
            <xsl:call-template name="dsc.table.header">
                <xsl:with-param name="includeunitdatecolumn">
                    <xsl:value-of select="$includeunitdatecolumn"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="dsc_table_row">
                <xsl:with-param name="includeunitdatecolumn">
                    <xsl:value-of select="$includeunitdatecolumn"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:apply-templates select="ead:c02" mode="c0x">
                <xsl:with-param name="includeunitdatecolumn">
                    <xsl:value-of select="$includeunitdatecolumn"/>
                </xsl:with-param>
            </xsl:apply-templates>
        </table>
    </xsl:template>
    
    <!-- Template for all components c02 and below to c10 -->
    <xsl:template match="ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12" mode="c0x">
        <xsl:param name="includeunitdatecolumn"/>
        <xsl:call-template name="dsc_table_row">
            <xsl:with-param name="includeunitdatecolumn">
                <xsl:value-of select="$includeunitdatecolumn"/>
            </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12" mode="c0x">
            <xsl:with-param name="includeunitdatecolumn">
                <xsl:value-of select="$includeunitdatecolumn"/>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Creates separate table rows for component <did> elements and component <did> siblings -->
    <xsl:template name="dsc_table_row">
        <xsl:param name="includeunitdatecolumn"/>
        <xsl:param name="containerpattern">
            <xsl:choose>
                <xsl:when test="$multiple-c01-tables='y'">
                    <xsl:call-template name="containerpatternParamC01"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="containerpatternParamDsc"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        <xsl:param name="desc.colspan">
            <xsl:call-template name="desc.colspanParam">
                <xsl:with-param name="includeunitdatecolumn">
                    <xsl:value-of select="$includeunitdatecolumn"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:param>
        <tr>
            <xsl:choose>
                <xsl:when test="self::ead:c01 and $multiple-c01-tables='y'"/>
                <xsl:otherwise>
                    <xsl:choose>
                <xsl:when test="ead:did/@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="ead:did/@id" />
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id" />
                    </xsl:attribute>
                </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="$containersonright='n'">
                <xsl:call-template name="container.table-cells"/>
            </xsl:if>
            <td>
                <xsl:attribute name="style">
                    <xsl:call-template name="c0x.did.indent"/>
                </xsl:attribute>
                <xsl:apply-templates select="ead:did//ead:origination" mode="c0x"/>
                <xsl:choose>
                    <xsl:when test="ead:did//ead:unittitle">
                        <xsl:apply-templates select="ead:did//ead:unittitle" mode="c0x"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="ead:did//ead:unitid" mode="c0x"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="ead:did//ead:physdesc" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:langmaterial" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:materialspec" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:physloc" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:daogrp" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:dao" mode="c0x"/>
                <xsl:apply-templates select="ead:did//ead:note" mode="c0x"/>
            </td>
            <xsl:if test="$includeunitdatecolumn='y'">
                <xsl:call-template name="unitdate.table-cell"/>
            </xsl:if>
            <xsl:if test="$containersonright='y'">
                <xsl:call-template name="container.table-cells"/>
            </xsl:if>
        </tr>
        
        <xsl:if test="ead:arrangement or ead:scopecontent or ead:bioghist or ead:accessrestrict 
            or ead:userestrict or ead:processinfo or ead:relatedmaterial or ead:separatedmaterial 
            or ead:note or ead:acqinfo or ead:custodhist or ead:altformavail or ead:originalsloc 
            or ead:otherfindaid or ead:phystech or ead:fileplan or ead:bibliography 
            or ead:accruals or ead:appraisal or ead:prefercite or ead:controlaccess">
            <tr>
                <xsl:if test="$containersonright='n'">
                    <xsl:choose>
                        <xsl:when test="$containerpattern='b' or $containerpattern='f' or $containerpattern='r'">
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <xsl:if test="$includeAeonRequests='y'">
                                <td>
                                    <xsl:text> </xsl:text>
                                </td>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="$containerpattern='bf' or $containerpattern='br' or $containerpattern='fr'">
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <xsl:if test="$includeAeonRequests='y'">
                                <td>
                                    <xsl:text> </xsl:text>
                                </td>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="$containerpattern='bfr'">
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <td>
                                <xsl:text> </xsl:text>
                            </td>
                            <xsl:if test="$includeAeonRequests='y'">
                                <td>
                                    <xsl:text> </xsl:text>
                                </td>
                            </xsl:if>
                        </xsl:when>
                        <xsl:when test="$containerpattern='none'">
                            <xsl:if test="$includeAeonRequests='y'">
                                <td>
                                    <xsl:text> </xsl:text>
                                </td>
                            </xsl:if>
                        </xsl:when>
                    </xsl:choose>
                </xsl:if>
                <td class="desc">
                    <xsl:attribute name="colspan">
                        <xsl:value-of select="$desc.colspan"/>
                    </xsl:attribute>
                    <!-- specified indent level-->
                    <div class="c0x-did-siblings">
                        <xsl:call-template name="c0x.did.sib.indent"/>
                        <xsl:apply-templates select="ead:arrangement" mode="c0x"/>
                        <xsl:apply-templates select="ead:bioghist" mode="c0x"/>
                        <xsl:apply-templates select="ead:scopecontent" mode="c0x"/>
                        <xsl:apply-templates select="ead:accessrestrict" mode="c0x"/>
                        <xsl:apply-templates select="ead:userestrict" mode="c0x"/>
                        <xsl:apply-templates select="ead:processinfo" mode="c0x"/>
                        <xsl:apply-templates select="ead:relatedmaterial" mode="c0x"/>
                        <xsl:apply-templates select="ead:separatedmaterial" mode="c0x"/>
                        <xsl:apply-templates select="ead:note" mode="c0x"/>
                        <xsl:apply-templates select="ead:acqinfo" mode="c0x"/>
                        <xsl:apply-templates select="ead:custodhist" mode="c0x"/>
                        <xsl:apply-templates select="ead:altformavail" mode="c0x"/>
                        <xsl:apply-templates select="ead:originalsloc" mode="c0x"/>
                        <xsl:apply-templates select="ead:otherfindaid" mode="c0x"/>
                        <xsl:apply-templates select="ead:phystech" mode="c0x"/>
                        <xsl:apply-templates select="ead:fileplan" mode="c0x"/>
                        <xsl:apply-templates select="ead:bibliography" mode="c0x"/>
                        <xsl:apply-templates select="ead:accruals" mode="c0x"/>
                        <xsl:apply-templates select="ead:appraisal" mode="c0x"/>
                        <xsl:apply-templates select="ead:prefercite" mode="c0x"/>
                        <xsl:apply-templates select="ead:controlaccess" mode="c0x"/>
                    </div>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    
    <!-- ead:origination c0x Template -->
    <xsl:template match="ead:origination" mode="c0x">
            <xsl:apply-templates mode="inline"/><br />
    </xsl:template>
    
    <!-- ead:unitid c0x Template -->
    <xsl:template match="ead:unitid" mode="c0x">
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- ead:unittitle c0x Template -->
    <!-- Also catches component <unitid>s -->
    <xsl:template match="ead:unittitle" mode="c0x">
        <xsl:choose>
            <xsl:when test="../ead:dao[not(@xlink:actuate='none') and not(../ead:dao[@xlink:role='application/vnd.aeon']) and normalize-space(../ead:dao/@xlink:href)]">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="../ead:dao/@xlink:href"/>
                    </xsl:attribute>
                    <xsl:if test="../ead:dao/@xlink:show='new'">
                        <xsl:attribute name="rel">
                            <xsl:text>external</xsl:text>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:call-template name="c0x.did.unittitle"/>
                </xsl:element>
            </xsl:when>
            <!-- 1st test at merging titles / dao links in Kissinger 
            doesn't work now since some of the components were updated later to include dates, and the DAO titles were constructed with "title + date" (so, no match for those)
            <xsl:when test="concat(., ', ', translate(../ead:unitdate[@type='inclusive'], ' ', '')) = ../ead:daogrp/ead:resource[1]">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="../ead:daogrp/ead:daoloc[1]/@xlink:href"/>
                    </xsl:attribute>
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:call-template name="c0x.did.unittitle"/>
                </xsl:element>
            </xsl:when>
            -->
            <!--2nd test with merging/dao links in Kissinger-->
            <xsl:when test="../ead:daogrp/ead:resource and (normalize-space(ancestor::ead:ead/ead:eadheader/ead:eadid) = 'mssa.ms.1981' or normalize-space(ancestor::ead:ead/ead:eadheader/ead:eadid) = 'mssa.ms.2004')">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="../ead:daogrp/ead:daoloc[1]/@xlink:href"/>
                    </xsl:attribute>
                    <xsl:attribute name="rel">
                        <xsl:text>external</xsl:text>
                    </xsl:attribute>
                    <xsl:call-template name="c0x.did.unittitle"/>
                </xsl:element>
            </xsl:when>

            <xsl:otherwise>
                <xsl:call-template name="c0x.did.unittitle"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ead:unittitle c0x call Template -->
    <xsl:template name="c0x.did.unittitle">
        <span>
            <xsl:choose>
                <xsl:when test="ancestor::ead:did/parent::*[@level='subgrp' or @level='series' or @level='subseries' or @otherlevel='accession']">
                    <xsl:attribute name="style">
                        <xsl:text>font-weight: bold;</xsl:text>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1'
                    and not(ancestor::ead:did/parent::*/ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12)">
                    <xsl:attribute name="style">
                        <xsl:text>font-size: 20px;</xsl:text>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:if test="not(preceding-sibling::ead:unittitle) and ancestor::ead:did//ead:unitid">
                <xsl:apply-templates select="ancestor::ead:did//ead:unitid[1]" mode="inline"/><xsl:text> </xsl:text>
            </xsl:if>
            <xsl:if test="@type='alternative'">
                <xsl:choose>
                    <xsl:when test="@label">
                        <xsl:value-of select="@label"/><xsl:text> </xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Alternate title: </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <xsl:apply-templates mode="inline"/>
            <xsl:if test="position()!=last()">
                <br />
            </xsl:if>
        </span>
    </xsl:template>
    
    <!-- ead:unitdate c0x Template (unittitle siblings) -->
    <xsl:template match="ead:unitdate[not(parent::ead:unittitle)]" mode="c0x">
        <xsl:apply-templates mode="inline"/>
        <xsl:if test="position()!=last()">
            <br />
        </xsl:if>
    </xsl:template>
    
    <!--  c0x/did physdesc Template -->
    <xsl:template match="ead:physdesc" mode="c0x">
        <br />
        <span class="c0x-physdesc"><xsl:apply-templates mode="inline"/></span>
    </xsl:template>
    
    <!--  c0x/didlangmaterial Template -->
    <xsl:template match="ead:langmaterial" mode="c0x">
        <br />
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!--  c0x/did materialspec Template -->
    <xsl:template match="ead:materialspec" mode="c0x">
        <br />
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!--  c0x/did physloc Template -->
    <xsl:template match="ead:physloc" mode="c0x">
        <br />
        <xsl:apply-templates mode="inline"/>
    </xsl:template>
    
    <!-- ead:dao c0x Template -->
    <xsl:template match="ead:dao" mode="c0x">
        <!--<xsl:if test="@xlink:actuate='none'">
            <xsl:choose>
                <xsl:when test="$repository_code='mssa'">
                    <br/>
                    <xsl:text>TEST TEST TEST TEST</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:if>-->
    </xsl:template>
    
    
    <!-- for kissinger (and perhaps other collections in the future), suppress any daogrp links that have kaltura links, since those will be handled by FindIt / elsewhere.
    this is a safe guard.  
    the links should already be removed before going into YFAD, as long as they're marked as "unpublished" dao's. -->
    <xsl:template match="ead:daogrp[ead:daoloc[contains(@xlink:href, '://www.kaltura.com')]]" mode="c0x"/>
    
    
    <!--  c0x/did daogrp Template -->
    <xsl:template match="ead:daogrp" mode="c0x">
        <xsl:for-each select="ead:daodesc/ead:p">
            <br />
            <xsl:apply-templates mode="inline"/>
            <xsl:if test="position()!=last()">
                <br />
            </xsl:if>
        </xsl:for-each>
        <xsl:choose>
            <xsl:when test="ead:daoloc[@xlink:role='application/vnd.aeon']"/>
            <xsl:when test="ead:arc[@xlink:actuate='none']"/>
            <!--kissinger stuff
            tried this first, but it doesn't work right now since some of the components have had dates added after the DAO titles were constructed (which include title + date)
            <xsl:when test="concat(../ead:unittitle, ', ', translate(../ead:unitdate[@type='inclusive'], ' ', '')) = ead:resource[1]"/>
            -->
            <xsl:when test="normalize-space(ancestor::ead:ead/ead:eadheader/ead:eadid) = 'mssa.ms.1981' or normalize-space(ancestor::ead:ead/ead:eadheader/ead:eadid) = 'mssa.ms.2004'"/>
            
            <xsl:otherwise>
                <br />
                <xsl:choose>
                    <!-- Embed first arc, link to second -->
                    <xsl:when test="ead:arc[@xlink:from='start' and @xlink:to='thumb'] and ead:arc[@xlink:from='thumb' and @xlink:to='reference']">
                        <a>
                            <xsl:if test="ead:arc[@xlink:to='reference'][@xlink:show='new']">
                                <xsl:attribute name="rel">
                                    <xsl:text>external</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="not(ead:arc[@xlink:to='reference'][@xlink:actuate='none'])">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:href"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="ead:daoloc[@xlink:label='reference']/@xlink:title">
                                <xsl:attribute name="title">
                                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                                </xsl:attribute>
                            </xsl:if>
                            <img>
                                <xsl:attribute name="src">
                                    <xsl:value-of select="ead:daoloc[@xlink:label='thumb']/@xlink:href"/>
                                </xsl:attribute>
                                <xsl:choose>
                                    <xsl:when test="ead:daoloc[@xlink:label='reference']/@xlink:title">
                                        <xsl:attribute name="alt">
                                            <xsl:value-of
                                                select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of
                                                select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                                        </xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:choose>
                                            <xsl:when test="ead:daoloc[@xlink:label='thumb']/@xlink:title">
                                                <xsl:attribute name="alt">
                                                    <xsl:value-of
                                                        select="ead:daoloc[@xlink:label='thumb']/@xlink:title"
                                                    />
                                                </xsl:attribute>
                                                <xsl:attribute name="title">
                                                    <xsl:value-of
                                                        select="ead:daoloc[@xlink:label='thumb']/@xlink:title"
                                                    />
                                                </xsl:attribute>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:attribute name="alt">
                                                    <xsl:text>Link to digital archival object</xsl:text>
                                                </xsl:attribute>
                                                <xsl:attribute name="title">
                                                    <xsl:text>Link to digital archival object</xsl:text>
                                                </xsl:attribute>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </img>
                        </a>
                    </xsl:when>
                    <!-- Link to single arc -->
                    <xsl:when test="ead:arc[@xlink:from='start' and @xlink:to='reference']">
                        <a>
                            <xsl:if test="ead:arc[@xlink:to='reference'][@xlink:show='new']">
                                <xsl:attribute name="rel">
                                    <xsl:text>external</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="ead:daoloc[@xlink:label='reference']/@xlink:title">
                                <xsl:attribute name="title">
                                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="not(ead:arc[@xlink:actuate='none'])">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:href"/>
                                </xsl:attribute>
                            </xsl:if>
                            <!-- Insert icon based on @xlink:role. -->
                            <xsl:choose>
                                <xsl:when test="starts-with (ead:daoloc[@xlink:label='reference']/@xlink:role, 'audio') or 
                                    starts-with (ead:daoloc[@xlink:label='reference']/@xlink:role, 'Audio')">
                                    <xsl:call-template name="icon.audio"/>
                                </xsl:when>
                                <!--<xsl:when test="starts-with (ead:daoloc[@xlink:label='reference']/@xlink:role, 'video')">
                            <xsl:call-template name="icon.video"></xsl:call-template>
                        </xsl:when>
                        <xsl:when test="starts-with (ead:daoloc[@xlink:label='reference']/@xlink:role, 'image')">
                            <xsl:call-template name="icon.image"/>
                            </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/pdf']">
                            <xsl:call-template name="icon.pdf"/>
                        </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/msword']">
                            <xsl:call-template name="icon.msword"/>
                        </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/rtf']">
                            <xsl:call-template name="icon.rtf"/>
                        </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/vnd.ms-excel']">
                            <xsl:call-template name="icon.msexcel"/>
                        </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/ms-powerpoint']">
                            <xsl:call-template name="icon.mspowerpoint"/>
                        </xsl:when>
                        <xsl:when test="ead:daoloc[@xlink:label='reference'][@xlink:role='application/x-msaccess']">
                            <xsl:call-template name="icon.msaccess"/>
                            </xsl:when>-->
                                <xsl:otherwise/>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="ead:resource[@xlink:label='start']/text()">
                                    <xsl:apply-templates select="ead:resource[@xlink:label='start']"
                                        mode="inline"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                        </a>
                    </xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- ead:did/ead:note c0x Template -->
    <xsl:template match="ead:did//ead:note" mode="c0x">
        <xsl:for-each select="ead:p">
            <br />
            <xsl:apply-templates mode="inline"/>
        </xsl:for-each>
    </xsl:template>
    
    <!-- component did sibling c0x Template -->
    <xsl:template match="ead:arrangement|ead:scopecontent|ead:bioghist|
        ead:accessrestrict|ead:userestrict|ead:processinfo|ead:relatedmaterial|
        ead:separatedmaterial|ead:note|ead:acqinfo|
        ead:custodhist|ead:altformavail|ead:originalsloc|ead:otherfindaid|
        ead:phystech|ead:fileplan|ead:bibliography|
        ead:accruals|ead:appraisal|ead:prefercite" mode="c0x">
        <xsl:apply-templates mode="block"/>
    </xsl:template>
    
    <!-- component did sibling controlaccess Template -->
    <xsl:template match="ead:controlaccess" mode="c0x">
        <xsl:if test="ead:persname|ead:corpname|ead:famname|ead:name
            |ead:subject|ead:geogname|ead:occupation|ead:function|ead:title">
            <xsl:element name="p">
                <xsl:attribute name="class">
                    <xsl:text>c0x</xsl:text>
                </xsl:attribute>
                <xsl:text>Subjects:</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="ead:persname|ead:corpname
                |ead:famname|ead:name|ead:subject|ead:geogname
                |ead:occupation|ead:function|ead:title" mode="block"/>
        </xsl:if>
        <xsl:if test="ead:genreform">
            <xsl:element name="p">
                <xsl:attribute name="class">
                    <xsl:text>c0x</xsl:text>
                </xsl:attribute>
                <xsl:text>Type of material:</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="ead:genreform" mode="block"/>
        </xsl:if>
    </xsl:template>
    
    <!-- ead:dsc/ead:head c0x Template -->
    <xsl:template match="ead:head" mode="c0x"/>
    
    <!-- ead:dsc/ead:p c0x Template -->
    <xsl:template match="ead:p" mode="c0x"/>
    
    <!-- Template that is called to create the includeunitdatecolumn parameter -->
    <xsl:template name="includeUnitdateColumnParamTemplate">
        <xsl:choose>
            <xsl:when test="descendant-or-self::ead:c01//ead:unitdate[not(parent::ead:unittitle)]">
                <xsl:text>y</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>n</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
</xsl:stylesheet>
