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