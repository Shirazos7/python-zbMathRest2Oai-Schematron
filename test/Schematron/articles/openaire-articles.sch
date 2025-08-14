<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:datacite="http://datacite.org/schema/kernel-4"
        xmlns:dc="http://purl.org/dc/elements/1.1/"
        xmlns:oaire="http://www.openarchives.org/OAI/2.0/oai_dc/"
        queryBinding="xslt">

  <ns prefix="res"      uri="http://namespace.openaire.eu/schema/oaire/"/>
  <ns prefix="datacite" uri="http://datacite.org/schema/kernel-4"/>
  <ns prefix="dc"       uri="http://purl.org/dc/elements/1.1/"/>
  <ns prefix="oaire"    uri="http://www.openarchives.org/OAI/2.0/oai_dc/"/>

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


  <pattern id="creators">
    <title>Check for datacite:creators and creator structure</title>
    <rule context="resource">
      <assert test="datacite:creators/datacite:creator">
        ERROR: At least one datacite:creator must be present.
      </assert>
      <report test="datacite:creators/datacite:creator and not(datacite:creators/datacite:creator/datacite:creatorName)">
        WARNING: datacite:creator is present but missing datacite:creatorName.
      </report>
    </rule>
  </pattern>


  <pattern id="creator-details">
    <title>Check for creator name fields</title>
    <rule context="datacite:creator">
      <assert test="datacite:creatorName">
        ERROR: datacite:creatorName is required.
      </assert>
      <assert test="datacite:givenName">
        ERROR: datacite:givenName is required.
      </assert>
      <assert test="datacite:familyName">
        ERROR: datacite:familyName is required.
      </assert>
      <report test="not(datacite:nameIdentifier)">
        WARNING: datacite:nameIdentifier (zbMATH Author Code) is recommended.
      </report>
    </rule>
  </pattern>

 <pattern id="titles">
    <title>Check for datacite:title</title>
    <rule context="resource">
      <assert test="datacite:titles/datacite:title">
        ERROR: datacite:title must be present.
      </assert>
      <report test="datacite:titles/datacite:title and normalize-space(datacite:titles/datacite:title) = ''">
        WARNING: datacite:title is present but empty.
      </report>
    </rule>
  </pattern>

 <pattern id="abstract">
    <title>Check for abstract in dc:description</title>
    <rule context="resource">
      <assert test="dc:description">
        ERROR: dc:description (abstract) must be present.
      </assert>
      <report test="dc:description and normalize-space(dc:description) = ''">
        WARNING: dc:description is present but empty.
      </report>
    </rule>
  </pattern>

   <pattern id="subjects">
    <title>Check for datacite:subject</title>
    <rule context="resource">
      <assert test="datacite:subjects/datacite:subject">
        ERROR: At least one datacite:subject (MSC or keyword) must be present.
      </assert>
      <report test="datacite:subjects/datacite:subject[normalize-space(.) = '']">
        WARNING: One or more datacite:subject entries are empty.
      </report>
    </rule>
  </pattern>

  <pattern id="issued-date">
    <title>Check for datacite:date</title>
    <rule context="resource">
      <assert test="datacite:dates/datacite:date[@dateType='Issued']">
        ERROR: Publication date (datacite:date with dateType='Issued') must be present.
      </assert>
      <report test="datacite:dates/datacite:date[@dateType='Issued'] and normalize-space(datacite:dates/datacite:date[@dateType='Issued']) = ''">
        WARNING: Issued date is present but empty.
      </report>
    </rule>
  </pattern>

  <pattern id="publisher">
    <title>Check for dc:publisher</title>
    <rule context="resource">
      <assert test="dc:publisher">
        ERROR: dc:publisher must be present.
      </assert>
      <report test="dc:publisher and normalize-space(dc:publisher) = ''">
        WARNING: dc:publisher is present but empty.
      </report>
    </rule>
  </pattern>

 <pattern id="resourceType">
    <title>Check for oaire:resourceType</title>
    <rule context="resource">
      <assert test="oaire:resourceType">
        ERROR: oaire:resourceType must be present.
      </assert>
      <report test="oaire:resourceType and normalize-space(oaire:resourceType) = ''">
        WARNING: oaire:resourceType is present but empty.
      </report>
    </rule>
  </pattern>

  <!-- datacite:relatedIdentifiers -->
  <pattern id="relatedIdentifiers">
    <title>Check for datacite:relatedIdentifier</title>
    <rule context="resource">
      <assert test="datacite:relatedIdentifiers/datacite:relatedIdentifier">
        ERROR: At least one datacite:relatedIdentifier must be present.
      </assert>
      <report test="datacite:relatedIdentifiers/datacite:relatedIdentifier[normalize-space(.) = '']">
        WARNING: One or more datacite:relatedIdentifier entries are empty.
      </report>
    </rule>
  </pattern>


<pattern id="source">
    <title>Check for dc:source</title>
    <rule context="resource">
      <assert test="dc:source">
        ERROR: dc:source must be present.
      </assert>
      <report test="dc:source and normalize-space(dc:source) = ''">
        WARNING: dc:source is present but empty.
      </report>
    </rule>
  </pattern>

  <!-- citation metadata -->
  <pattern id="citation">
    <title>Check for citation metadata</title>
    <rule context="resource">
      <assert test="oaire:citationTitle">
        ERROR: oaire:citationTitle is required.
      </assert>
      <assert test="oaire:citationVolume">
        ERROR: oaire:citationVolume is required.
      </assert>
      <assert test="oaire:citationIssue">
        ERROR: oaire:citationIssue is required.
      </assert>
      <assert test="oaire:citationStartPage">
        ERROR: oaire:citationStartPage is required.
      </assert>
      <assert test="oaire:citationEndPage">
        ERROR: oaire:citationEndPage is required.
      </assert>

      <report test="oaire:citationVolume and normalize-space(oaire:citationVolume) = ''">
        WARNING: oaire:citationVolume is empty.
      </report>
      <report test="oaire:citationIssue and normalize-space(oaire:citationIssue) = ''">
        WARNING: oaire:citationIssue is empty.
      </report>
    </rule>
  </pattern>

</schema>