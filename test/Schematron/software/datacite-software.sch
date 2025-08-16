<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            queryBinding="xslt">

  <sch:ns prefix="datacite" uri="http://datacite.org/schema/kernel-4"/>
  <sch:ns prefix="xsi"      uri="http://www.w3.org/2001/XMLSchema-instance"/>

  <sch:pattern id="p-resource-root">
    <sch:rule context="datacite:resource">
      <sch:assert test="@xsi:schemaLocation">
        Missing xsi:schemaLocation
      </sch:assert>

       <sch:assert test="datacite:identifier[@identifierType]">
        Missing datacite:identifier or @identifierType
      </sch:assert>
      <sch:assert test="datacite:creators/datacite:creator">
        At least one creator is required
      </sch:assert>
      <sch:assert test="datacite:titles/datacite:title">
        Title is required
      </sch:assert>
      <sch:assert test="normalize-space(datacite:publicationYear)">
        publicationYear is required (may be ':unav')
      </sch:assert>
      <sch:assert test="datacite:subjects/datacite:subject">
        At least one subject is required
      </sch:assert>
      <sch:assert test="datacite:language">
        Language is required
      </sch:assert>
      <sch:assert test="datacite:resourceType[@resourceTypeGeneral]">
        resourceType with @resourceTypeGeneral is required
      </sch:assert>
      <sch:assert test="datacite:formats/datacite:format">
        formats/format is required
      </sch:assert>

      <!-- if relatedIdentifiers exists it must contain items -->
      <sch:assert test="not(datacite:relatedIdentifiers) or datacite:relatedIdentifiers/datacite:relatedIdentifier">
        relatedIdentifiers, if present, must contain at least one relatedIdentifier
      </sch:assert>
    </sch:rule>
  </sch:pattern>