<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <ns uri="urn:isbn:1-931666-22-9" prefix="ead"/>
    <!-- last updated: 2017-11-16 --> 
    <title>Schematron validations to ensure YFAD compliance.</title>
    
    <pattern>
        <rule context="ead:archdesc">
            <assert test="@level = 'collection'">You must change this level attribute to "collection" in ArchivesSpace. "<value-of select="@level"/>" is not a valid value at this level of description at YUL.</assert>
            <assert test="ead:descgrp">There are three possible problems with this file since it's missing the "description group" element:  1) You haven't run the EAD file through the ASpace-to-YaleEAD.bpg style sheet yet.  2) You've run this XML file through the transformation scenario more than once. 3) You don't have the minimum amount of description required for YFAD (and if so, you'll see additional validation errors).  Whatever the reason, you'll need to start over again in ArchivesSpace!</assert>
            <assert test="ead:descgrp/ead:accessrestrict">You must supply a resource-level access restriction statement to be DACS compliant.</assert>
        </rule>
    </pattern>

    <pattern>
        <rule context="ead:eadid">
            <assert test="matches(.,
                    '(mssa\.((ms|ru|hvt)\.[0-9]{4}[A-Z]?|pubs\.[0-9a-z]*))|(divinity\.([0-9a-zA-Z]+(\.[0-9]{1})?|bib\.[0-9]*))|(beinecke\.[0-9a-zA-Z]{2,16}(\.[0-9]{1})?)|(music\.(mss|misc)\.[0-9]{4}(\.[0-9]{1})?)|(arts\.(aob|dra|art|bkp)\.[0-9]{4}(\.[0-9]{1})?)|(vrc\.[0-9]{4}(\.[0-9]{1})?)|(med\.(ms|pam)\.[0-9]{4}(\.[0-9]{1})?)|(ycba\.(mss|ar)\.[0-9]{4}(\.[0-9]{1})?)|(ypm\.[a-z]{2,7}\.[0-9]{6})|(lwl\.[a-z]{2,7}\.[0-9]{1,6})|(yul\.[0-9a-zA-Z\.]{2,16})')">
                The EAD ID value for this collection does not adhere to our local best practices.  You must correct this issue before uploading to YFAD
            </assert>
        </rule>
    </pattern>

    <pattern>
        <rule context="ead:publicationstmt">
            <assert test="ead:date">This finding aid is missing a publication date.  Please supply one before uploading to YFAD</assert>
        </rule>
    </pattern>

    <pattern>
        <rule context="ead:titlestmt">
            <assert test="ead:titleproper[@type = 'formal']">You must supply a title for the finding aid in ArchivesSpace.</assert>
            <assert test="ead:titleproper[@type = 'filing']">You have to supply a filing title! If
                you don't, there won't be a link to this collection in YFAD's search
                results.</assert>
        </rule>
    </pattern>
   
    <pattern>
        <rule context="ead:archdesc/ead:did">
            <assert test="ead:unittitle[normalize-space()]">You must supply a title at the resource
                level</assert>
            <assert test="ead:unitdate[normalize-space()]">You must supply a date at the resource
                level</assert>
            <assert test="ead:unitid[normalize-space()]">You must supply an identifier at the
                resource level</assert>
            <assert test="ead:abstract[normalize-space()]">You must supply an abstract at the
                resource level</assert>
            <assert test="ead:physdesc/ead:extent[normalize-space()][1]">You must supply an extent
                statement at the resource level. This should be formatted with an extent number and
                an extent type, like so: "3.25 linear feet"</assert>
            <assert test="ead:langmaterial[normalize-space()]">To be DACs compliant, you must supply a language at the resource level.</assert>
            <report test="ead:langmaterial[2]">This file has more than one language material statement.  Please verify that this is correct before uploading to YFAD</report>
        </rule>
    </pattern>

    <pattern>
        <!-- do this based on the repo information in ASpace, rather than the value assigned in the eadid
        <let name="repo" value="substring-before(normalize-space(/ead:ead/ead:eadheader/ead:eadid),'.')"/>
        -->
        <rule context="ead:container/@label">
            <assert test="matches(., '^\d{14}(,\d{14})*')">Please verify that your barcode values are correct. They should be 14 digits long.</assert>
        </rule>
        <!--
            not sure yet how to paramertize these rules, so i'm leaving this out for now.
        <rule context="ead:container/@label">
            <assert test="$repo = 'ycba-ia' and matches(., '^\d{9}(,\d{9})*')">Please verify that your barcode values are correct. They should be 9 digits long</assert>
        </rule>
        -->
    </pattern>
    
    <pattern>
        <rule context="ead:c | ead:*[matches(local-name(), '^c0|^c1')]">
            <assert test="@level=('series', 'subseries', 'file', 'item', 'otherlevel', 'recordgrp', 'subgrp')">
                Please update your level attribute.  "<value-of select="@level"/>" is not a valid option. The valid options for Yale's best practices are:
                 series, subseries, file, item, otherlevel, recordgrp, or subgrp.
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="*[@level ='otherlevel']">
            <assert test="@otherlevel">If the value of a level attribute is "otherlevel', then you
                must specify the value of the otherlevel attribute</assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="ead:head">
            <report test="lower-case(.) = 'typecollection'">
                Please verity that this finding aid does not contain a note that should remain unpublished.
                The note, "<value-of select=".."/>," contains a head element that usually indicates 
                that this note is a staff-only Preservica note.
            </report>
            <report test="contains(lower-case(.), 'samma')">
                Please verity that this finding aid does not contain a note that should remain unpublished.
                The note, "<value-of select=".."/>," contains a head element that includes the word "Samma", 
                which typically indicate that the note is meant to be internal-only.
            </report>
        </rule>
    </pattern>

</schema>
