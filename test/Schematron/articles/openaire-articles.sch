<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:datacite="http://datacite.org/schema/kernel-4"
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns:oaire="http://www.openarchives.org/OAI/2.0/oai_dc/"
        queryBinding="xslt">

   <title>Schematron Validation for OpenAIRE XSLT Output</title>

  <!-- datacite:identifier -->
  <pattern id="identifier">
    <title>Check for datacite:identifier</title>
    <rule context="resource">
      <assert test="datacite:identifier">
        ERROR: datacite:identifier is required.
      </assert>
      <report test="datacite:identifier and normalize-space(datacite:identifier) = ''">
        WARNING: datacite:identifier is present but empty.
      </report>
    </rule>
  </pattern>


   <pattern id="alternateIdentifiers">
    <title>Check for datacite:alternateIdentifiers</title>
    <rule context="resource">
      <assert test="datacite:alternateIdentifiers/datacite:alternateIdentifier">
        ERROR: At least one datacite:alternateIdentifier is required (DOI or arXiv).
      </assert>
      <report test="datacite:alternateIdentifiers/datacite:alternateIdentifier and normalize-space(datacite:alternateIdentifiers/datacite:alternateIdentifier) = ''">
        WARNING: datacite:alternateIdentifier is present but empty.
      </report>
    </rule>
  </pattern>