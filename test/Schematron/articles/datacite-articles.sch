<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            queryBinding="xslt">
  <!-- Namespace for DataCite kernel-4 -->
  <sch:ns prefix="d" uri="http://datacite.org/schema/kernel-4"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>

  <sch:pattern id="p_root_and_order">
    <sch:title>resource root and child element order as emitted by XSLT</sch:title>

    <!-- Exactly one DataCite resource with the schemaLocation your XSLT sets -->
    <sch:rule context="/">
      <sch:assert test="count(/d:resource)=1">
        Must have exactly one d:resource root element.
      </sch:assert>
    </sch:rule>

    <sch:rule context="/d:resource">
      <!-- schemaLocation attribute as in your literal XSLT -->
      <sch:assert test="@xsi:schemaLocation='http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4/metadata.xsd'">
        d:resource/@xsi:schemaLocation must be 'http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4/metadata.xsd'.
      </sch:assert>

      <sch:assert test="count(d:alternateIdentifiers)=1">
        Exactly one d:alternateIdentifiers element is required (the XSLT always emits this container).
      </sch:assert>
      <sch:assert test="count(d:creators)=1">
        Exactly one d:creators element is required (container is always emitted).
      </sch:assert>
      <sch:assert test="count(d:titles)=1">
        Exactly one d:titles element is required (either from root/title or the ':unav' fallback).
      </sch:assert>
      <sch:assert test="count(d:rightsList)=1">
        Exactly one d:rightsList element is required (always emitted).
      </sch:assert>
      <sch:assert test="count(d:relatedItems)=1">
        Exactly one d:relatedItems element is required (container is always emitted).
      </sch:assert>

      <sch:assert test="count(d:identifier) &lt;= 1">
        At most one d:identifier is allowed (first DOI or first ARXIV only).
      </sch:assert>
      <sch:assert test="count(d:descriptions) &lt;= 1">
        At most one d:descriptions block is allowed.
      </sch:assert>
      <sch:assert test="count(d:publisher) &lt;= 1">
        At most one d:publisher is allowed.
      </sch:assert>
      <sch:assert test="count(d:publicationYear) &lt;= 1">
        At most one d:publicationYear is allowed.
      </sch:assert>
      <sch:assert test="count(d:subjects) &lt;= 1">
        At most one d:subjects block is allowed.
      </sch:assert>
      <sch:assert test="count(d:language) &lt;= 1">
        At most one d:language is allowed.
      </sch:assert>
      <sch:assert test="count(d:resourceType) &lt;= 1">
        At most one d:resourceType is allowed.
      </sch:assert>
      <sch:assert test="count(d:relatedIdentifiers) &lt;= 1">
        At most one d:relatedIdentifiers block is allowed.
      </sch:assert>

      <sch:assert test="not(d:relatedIdentifier)">
        d:relatedIdentifier elements must appear only inside d:relatedIdentifiers.
      </sch:assert>

      <sch:assert test="not(d:identifier) or count(d:identifier/preceding-sibling::*)=0">
        d:identifier (when present) must be the first child element of d:resource.
      </sch:assert>

      <sch:assert test="count(d:alternateIdentifiers/preceding-sibling::*[not(self::d:identifier)])=0">
        d:alternateIdentifiers must come immediately after d:identifier (if any) and before all other blocks.
      </sch:assert>

      <sch:assert test="count(d:creators/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers)])=0">
        d:creators must come after d:alternateIdentifiers (and identifier, if present).
      </sch:assert>

      <sch:assert test="not(d:descriptions) or count(d:descriptions/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators)])=0">
        d:descriptions (when present) must come after d:creators and before d:titles.
      </sch:assert>

      <sch:assert test="count(d:titles/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions)])=0">
        d:titles must come after d:creators (and d:descriptions if present).
      </sch:assert>

      <sch:assert test="not(d:publisher) or count(d:publisher/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles)])=0">
        d:publisher (when present) must come after d:titles.
      </sch:assert>

      <sch:assert test="not(d:publicationYear) or count(d:publicationYear/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher)])=0">
        d:publicationYear (when present) must come after d:publisher (if present) and after d:titles.
      </sch:assert>

      <sch:assert test="not(d:subjects) or count(d:subjects/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear)])=0">
        d:subjects (when present) must come after d:publicationYear (if present).
      </sch:assert>

      <sch:assert test="not(d:language) or count(d:language/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects)])=0">
        d:language (when present) must come after d:subjects (if present).
      </sch:assert>

      <sch:assert test="not(d:resourceType) or count(d:resourceType/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language)])=0">
        d:resourceType (when present) must come after d:language (if present).
      </sch:assert>

      <sch:assert test="not(d:relatedIdentifiers) or count(d:relatedIdentifiers/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language or self::d:resourceType)])=0">
        d:relatedIdentifiers (when present) must come after d:resourceType (if present).
      </sch:assert>

      <sch:assert test="count(d:rightsList/preceding-sibling::*[self::d:relatedItems])=0">
        d:rightsList must appear before d:relatedItems.
      </sch:assert>

      <sch:assert test="count(d:relatedItems/following-sibling::*)=0">
        d:relatedItems must be the last child element in d:resource.
      </sch:assert>
    </sch:rule>
  </sch:pattern>



  <sch:pattern id="p_identifier">
    <sch:title>Primary identifier (DOI preferred; ARXIV if no DOI)</sch:title>
    <sch:rule context="/d:resource/d:identifier">
      <sch:assert test="@identifierType='DOI' or @identifierType='ARXIV'">
        @identifierType must be 'DOI' (if any DOI existed) or 'ARXIV' (only when no DOI existed); got '<sch:value-of select="@identifierType"/>'.
      </sch:assert>
      <!-- coarse DOI check: has slash, no spaces -->
      <sch:report test="@identifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))">
        DOI value '<sch:value-of select="." />' does not look like a DOI (should contain a slash and no spaces).
      </sch:report>
      <!-- coarse arXiv check: allow 'arXiv:NNNN.NNNN' or 'NNNN.NNNN' (optionally 5 digits after dot) -->
      <sch:report test="@identifierType='ARXIV' and not(starts-with(normalize-space(.), 'arXiv:'))
                                 and not(contains(., '.'))">
        ARXIV value '<sch:value-of select="." />' should resemble 'arXiv:YYYY.NNNN' or 'YYYY.NNNN'.
      </sch:report>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="p_alternate_identifiers">
    <sch:title>Alternate identifiers (zbMATH Identifier, zbMATH Document ID, URL)</sch:title>
    <sch:rule context="/d:resource/d:alternateIdentifiers">
      <sch:assert test="count(d:alternateIdentifier) &gt;= 1">
        Expected at least one alternateIdentifier (zbMATH Identifier/Document ID/URL) when present in source.
      </sch:assert>
    </sch:rule>
    <sch:rule context="/d:resource/d:alternateIdentifiers/d:alternateIdentifier">
      <sch:assert test="@alternateIdentifierType='zbMATH Identifier'
                        or @alternateIdentifierType='zbMATH Document ID'
                        or @alternateIdentifierType='URL'">
        alternateIdentifierType must be one of 'zbMATH Identifier', 'zbMATH Document ID', or 'URL'; got '<sch:value-of select="@alternateIdentifierType"/>'.
      </sch:assert>
      <sch:assert test="normalize-space(.)!=''">
        alternateIdentifier value must not be empty.
      </sch:assert>
      <sch:report test="@alternateIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))">
        URL alternateIdentifier should start with 'http' (got '<sch:value-of select="."/>' ).
      </sch:report>
      <!-- no duplicates by type -->
      <sch:assert test="not(following-sibling::d:alternateIdentifier[@alternateIdentifierType=current()/@alternateIdentifierType])">
        Duplicate alternateIdentifier of type '<sch:value-of select="@alternateIdentifierType"/>'; only one per type expected.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

   <sch:pattern id="p_creators">
    <sch:title>Creators mapping, including ':unav' placeholder option</sch:title>
    <sch:rule context="/d:resource/d:creators">
      <sch:assert test="count(d:creator) &gt;= 1
                        or (count(d:creator)=1
                            and normalize-space(d:creator/d:creatorName)=':unav'
                            and normalize-space(d:creator/d:givenName)=':unav'
                            and normalize-space(d:creator/d:familyName)=':unav'
                            and normalize-space(d:creator/d:nameIdentifier)=':unav')">
        Creators must include ≥1 creator OR a single ':unav' placeholder creator when no authors are available.
      </sch:assert>
      <sch:report test="count(d:creator)=0">
        No creators generated. If source has no authors, emit one placeholder creator with ':unav' values; otherwise map authors to creators.
      </sch:report>
    </sch:rule>
    <sch:rule context="/d:resource/d:creators/d:creator">
      <sch:assert test="d:creatorName">Missing creatorName.</sch:assert>
      <sch:assert test="d:givenName">Missing givenName (':unav' allowed).</sch:assert>
      <sch:assert test="d:familyName">Missing familyName (':unav' allowed).</sch:assert>
      <sch:assert test="d:nameIdentifier">Missing nameIdentifier (':unav' allowed).</sch:assert>
      <sch:assert test="not(d:nameIdentifier) or d:nameIdentifier/@nameIdentifierScheme='zbMATH Author Code'">
        nameIdentifier/@nameIdentifierScheme must be 'zbMATH Author Code'.
      </sch:assert>
      <sch:assert test="not(d:nameIdentifier) or d:nameIdentifier/@schemeURI='https://zbmath.org/'">
        nameIdentifier/@schemeURI must be 'https://zbmath.org/'.
      </sch:assert>
      <sch:report test="normalize-space(d:creatorName)!=':unav'
                        and contains(normalize-space(d:creatorName), ',')
                        and normalize-space(d:givenName) != normalize-space(substring-after(d:creatorName, ','))">
        givenName '<sch:value-of select="d:givenName"/>' should equal the part after the comma in creatorName '<sch:value-of select="d:creatorName"/>'.
      </sch:report>
      <sch:report test="normalize-space(d:creatorName)!=':unav'
                        and contains(normalize-space(d:creatorName), ',')
                        and normalize-space(d:familyName) != normalize-space(substring-before(d:creatorName, ','))">
        familyName '<sch:value-of select="d:familyName"/>' should equal the part before the comma in creatorName '<sch:value-of select="d:creatorName"/>'.
      </sch:report>
    </sch:rule>
  </sch:pattern>

<sch:pattern id="p_descriptions">
    <sch:title>Abstract description</sch:title>
    <sch:rule context="/d:resource/d:descriptions">
      <sch:assert test="count(d:description) &gt;= 1">
        /descriptions must contain at least one description when present.
      </sch:assert>
    </sch:rule>
    <sch:rule context="/d:resource/d:descriptions/d:description">
      <sch:assert test="@descriptionType='Abstract'">description/@descriptionType must be 'Abstract'.</sch:assert>
      <sch:assert test="@xml:lang">description must have @xml:lang.</sch:assert>
      <sch:assert test="normalize-space(.)!=''">Abstract text must not be empty.</sch:assert>
      <sch:assert test="not(contains(., 'zbMATH Open Web Interface contents unavailable'))">
        Abstract must not contain the placeholder text for unavailable content.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  </schema>