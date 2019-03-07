<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:ead="urn:isbn:1-931666-22-9"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xsl ead xlink xsi" version="1.0">
  <!--
    =========================================================================
    =          YUL Common XSLT for presenting EAD 2002 as XHTML == Common HTML module      =
    =========================================================================
    
    created:	2008-10-27
    updated:	2014-07-21
    contact:	michael.rush@yale.edu, mssa.systems@yale.edu, kalee.sprague@yale.edu
  -->
  
  <!--<xsl:variable name="support_file_path">file:\\\J:\MSSUNIT\Finding Aids\XSL\XSL-HTML-Test\</xsl:variable>-->
  <xsl:variable name="support_file_path">http://shishen.library.yale.edu/saxon/EAD/</xsl:variable>
  <xsl:variable name="css_file_name">finding_aids.css</xsl:variable>
  <!--kls - link necessary for opening help in new window -->
  <xsl:variable name="external_link_new_win_script">external.js</xsl:variable>
  <!--<xsl:variable name="css_file_name">yul.ead2002.xhtml.css</xsl:variable>-->
  <xsl:variable name="common_xsl_file_name">yul.ead2002.xhtml.common.xsl</xsl:variable>
  <xsl:variable name="find_aid_technical_contact">findingaids.feedback@yale.edu</xsl:variable>
  
  <xsl:template name="commonHeadElements">
    <xsl:param name="finding_aid_title"/>
    <title>
      <xsl:text>Yale Finding Aid Database</xsl:text>
      <xsl:if test="normalize-space($finding_aid_title)">
        <xsl:text> : </xsl:text><xsl:value-of select="$finding_aid_title"/>
      </xsl:if>
    </title>
    
    <!--KLS25 commented out and encorporated in finding_aids.css link rel="stylesheet" href="http://www.library.yale.edu/libraries/ydl.css" type="text/css"/-->
    <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:value-of select="concat($support_file_path,$css_file_name)"/>
      </xsl:attribute>
    </link>
 
        <script type="text/javascript">
          <xsl:attribute name="src">
            <xsl:value-of select="concat($support_file_path,$external_link_new_win_script)"/>
          </xsl:attribute>
          <xsl:text> </xsl:text>
        </script>
    
  </xsl:template>
  
  <xsl:template name="commonHeader">
    <div class="header_line1">
      <!-- start: title graphic -->
	<!-- kls25 10/05/2009 - new slimmer header style -->
      <h1 id="header_title">
        
        <a href="http://www.library.yale.edu" target="_blank">
          <img src="http://shishen.library.yale.edu/saxon/EAD/yul_header.png" alt="Yale University Library" border="1"/></a></h1>
      <!-- end: title graphic -->
      <!-- start: main navigation -->
      <div id="nav_main">
        <a href="http://shishen.library.yale.edu/fedoragsearch/rest/" class="nm_research_tools">Finding Aid Database</a> 
        <a onclick="javascript:open_window_help('http://www.library.yale.edu/facc/yul.ead2002.xhtml.help.html');return false;" href="http://www.library.yale.edu/facc/yul.ead2002.xhtml.help.html/" class="nm_libraries_and_collections">Help</a> 
        <a href="mailto:findingaids.feedback@yale.edu" class="nm_about_the_library">Feedback</a> 
      </div>
      <!-- end: main navigation -->
    </div>
    <div id="nav2">

      <form class="nav_searchbox" action="http://shishen.library.yale.edu/fedoragsearch/rest" method="get">
	<div class="search-options">
		<select name="filter">
			<option selected="selected" value="">all finding aids</option>
		  <option value="fgs.collection:&quot;Manuscripts and Archives&quot;">Manuscripts and Archives</option>
		  <option value="fgs.collection:&quot;Arts Library&quot;">Arts Library</option>
		  <option value="fgs.collection:&quot;Beinecke Library&quot;">Beinecke Library</option>
		  <option value="fgs.collection:&quot;Divinity Library&quot;">Divinity Library</option>
		  <option value="fgs.collection:&quot;Lewis Walpole Library&quot;">Lewis Walpole Library</option>
		  <option value="fgs.collection:&quot;Medical Historical Library&quot;">Medical Historical Library</option>
		  <option value="fgs.collection:&quot;Music Library&quot;">Music Library</option>
		  <option value="fgs.collection:&quot;Visual Resources Collection&quot;">Visual Resources Collection</option>
		  <option value="fgs.collection:&quot;Yale Center for British Art&quot;">Yale Center for British Art</option>
		  <option value="fgs.collection:&quot;Yale Peabody Museum&quot;">Yale Peabody Museum</option>
		</select>
	</div>
	<input value="solrQuery" name="operation" type="hidden" />
	<input size="30" name="query" type="text" />
	<input value="Search" type="submit" />

	<a href="http://shishen.library.yale.edu/fedoragsearch/restAdv" style="margin-left:30px;">Advanced Search</a>
 
        <span>
          <xsl:attribute name="class">
		submenu
          </xsl:attribute>
          <xsl:text>View: </xsl:text>
          <xsl:choose>
            <xsl:when test="not($view='all')">
              <xsl:if test="not($big='y')">
                <a class="bigtitle">
                  <xsl:attribute name="href">
                    <!--<xsl:value-of select="concat($htmlURL,'&amp;view=all')"/>-->
                    <xsl:value-of select="concat($htmlURL2,'&amp;view=all')"/>
                  </xsl:attribute>
                  <xsl:text>Full HTML </xsl:text><span>NOTE: for large finding aids, the full HTML view may take up to 30 seconds to render</span>

                </a>
                <xsl:text> / </xsl:text>
              </xsl:if>
            </xsl:when>
            <xsl:when test="$view='all'">
              <a>
                <xsl:attribute name="href">
                  <!--<xsl:value-of select="concat($htmlURL,'&amp;view=over')"/>-->
                  <xsl:value-of select="concat($htmlURL2,'&amp;view=over')"/>
                </xsl:attribute>
                <xsl:text>HTML by Section</xsl:text>
              </a>
              <xsl:text> / </xsl:text>
            </xsl:when>
          </xsl:choose>
          <a>
            <xsl:attribute name="rel">
              <xsl:text>external</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="href">
              <xsl:value-of select="$pdfURL"/>
            </xsl:attribute>
            <xsl:text>Printable PDF</xsl:text>
          </a>
          <xsl:text> / </xsl:text>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:text>highlightToggle</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="class">
              <xsl:text></xsl:text>
            </xsl:attribute>
            <xsl:text>Turn off highlighting</xsl:text>
          </a>
        </span>
	
      </form>

      
    </div> 
    <!--div id="title_row"-->
  </xsl:template>
  
  <xsl:template name="commonFooter">
    <div id="footer">
      <!-- start: footer and copyright -->
      <!-- footer -->
      <a href="http://www.library.yale.edu/htmldocs/search.html">Search this Site</a> / 
      <a href="http://neworbis.library.yale.edu/">Orbis Library Catalog</a> / 
      <a href="http://www.library.yale.edu/about/contactus.html">Contact Us</a> / 
      <a href="http://portal.yale.edu/">Yale Info</a> / 
      <a href="http://www.yale.edu/">Yale University</a> /
      <a href="http://www.library.yale.edu/reference/asklive/index.html">Ask<i>!</i> a Librarian</a> / 
      <a>
        <xsl:attribute name="href">
          <xsl:value-of select="concat('mailto:',$find_aid_technical_contact)"/>
        </xsl:attribute>
        <xsl:text>Contact Finding Aid Administrator</xsl:text>
      </a>
      <!-- copyright -->
      
      <div class="copyright"><a href="http://www.library.yale.edu/htmldocs/copyright.html" target="_blank">&#169; 2013 Yale University Library.</a></div>
    </div>
  </xsl:template>
  
  <xsl:template name="leftMenuBrowse">
    <div id="left_menu_browse">
      <span class="menu_title">Browse by Repository</span>
      <ul>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22mssa*%22&amp;sortFields=fgs.title">Manuscripts and Archives</a></li>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22beinecke*%22&amp;sortFields=fgs.title">Beinecke Library</a></li>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22divinity*%22&amp;sortFields=fgs.title">Divinity Library</a></li>
	<!--newly added.  test and make sure this works before rolling out to DRS-->	
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22lwl*%22&amp;sortFields=fgs.title">Lewis Walpole Library</a></li>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22music*%22&amp;sortFields=fgs.title">Music Library</a></li>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22vrc*%22&amp;sortFields=fgs.title">Visual Resources Collection</a></li>
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22ycba*%22&amp;sortFields=fgs.title">Yale Center for British Art</a></li>
        <!--newly added.  test and make sure this works before rolling out to DRS-->	
        <li><a href="http://shishen.library.yale.edu/fedoragsearch/rest?Repository=&amp;operation=gfindObjects&amp;query=dc.identifier:%22ypm*%22&amp;sortFields=fgs.title">Yale Peabody Museum</a></li>
      </ul>
      
    </div>
  </xsl:template>
  
</xsl:stylesheet>
