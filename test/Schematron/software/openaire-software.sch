<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            xmlns:datacite="http://datacite.org/schema/kernel-4"
            xmlns:oaire="http://www.openarchives.org/OAI/2.0/oai_dc/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            queryBinding="xslt">

    <!-- ========== Root Element ========= -->
    <sch:pattern id="resource-root">
        <sch:rule context="/resource">
            <sch:assert test="@xsi:schemaLocation">Missing xsi:schemaLocation</sch:assert>
            <sch:assert test="datacite:identifier">Missing datacite:identifier</sch:assert>
            <sch:assert test="datacite:creators/datacite:creator">At least one creator is required</sch:assert>
            <sch:assert test="datacite:titles/datacite:title">Title is required</sch:assert>
            <sch:assert test="oaire:resourceType[@resourceTypeGeneral='software']">Resource type must be 'software'</sch:assert>
            <sch:assert test="datacite:rights[@rightsURI]">Rights must include rightsURI</sch:assert>
            <sch:assert test="dc:format='application/xml'">Format must be 'application/xml'</sch:assert>
            <sch:assert test="dc:language='eng'">Language must be 'eng'</sch:assert>
            <sch:assert test="datacite:date[@dateType='Issued']">Issued date is mandatory</sch:assert>
        </sch:rule>
    </sch:pattern>

     <sch:pattern id="identifier">
        <sch:rule context="datacite:identifier">
            <sch:assert test="@identifierType='URL'">identifierType must be 'URL'</sch:assert>
            <sch:assert test="starts-with(., 'https://swmath.org/software/')">Identifier must be a swmath software URL</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- ========== Creators ========= -->
    <sch:pattern id="creators">
        <sch:rule context="datacite:creator">
            <sch:assert test="datacite:creatorName[@nameType='Personal']">creatorName must have nameType='Personal'</sch:assert>
            <sch:assert test="datacite:givenName">givenName is required</sch:assert>
            <sch:assert test="datacite:familyName">familyName is required</sch:assert>
        </sch:rule>
    </sch:pattern>

 <sch:pattern id="titles">
        <sch:rule context="datacite:title">
            <sch:assert test="normalize-space(.) != ''">Title must not be empty</sch:assert>
        </sch:rule>
    </sch:pattern>

    <!-- ========== Description ========= -->
    <sch:pattern id="description">
        <sch:rule context="dc:description">
            <sch:assert test="@descriptionType='Abstract'">Description type must be 'Abstract'</sch:assert>
            <sch:assert test="@xml:lang='en'">Description must be in English</sch:assert>
        </sch:rule>
    </sch:pattern>

<sch:pattern id="subjects">
        <sch:rule context="datacite:subject">
            <sch:assert test="@subjectScheme='msc2020' or @subjectScheme='keyword'">subjectScheme must be 'msc2020' or 'keyword'</sch:assert>
            <sch:assert test="normalize-space(.) != ''">Subject value must not be empty</sch:assert>
        </sch:rule>
    </sch:pattern>


    <sch:pattern id="relatedIdentifiers">
        <sch:rule context="datacite:relatedIdentifier">
            <sch:assert test="@relatedIdentifierType='URL'">relatedIdentifierType must be 'URL'</sch:assert>
            <sch:assert test="@relationType='IsReferencedBy' or @relationType='IsSupplementedBy'">relationType must be valid</sch:assert>
            <sch:assert test="starts-with(., 'https://zbmath.org/') or starts-with(., 'https://api.zbmath.org/')">Must be zbmath or API URL</sch:assert>
        </sch:rule>
    </sch:pattern>

    </sch:schema>