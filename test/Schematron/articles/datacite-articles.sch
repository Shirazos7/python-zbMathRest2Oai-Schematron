<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
            queryBinding="xslt">
  <!-- Namespace for DataCite kernel-4 -->
  <sch:ns prefix="d" uri="http://datacite.org/schema/kernel-4"/>
  <sch:ns prefix="xml" uri="http://www.w3.org/XML/1998/namespace"/>

    <sch:pattern id="p_resource_root">
    <sch:title>Resource root and basic structure</sch:title>
    <sch:rule context="/">
      <sch:assert test="count(/d:resource)=1">
        Expected exactly one <sch:name/> element in the DataCite namespace as the document root.
      </sch:assert>
    </sch:rule>

 <sch:rule context="/d:resource">
      <sch:assert test="d:identifier">
        Missing primary identifier (/resource/identifier) created from first DOI (or ARXIV when no DOI).
      </sch:assert>
      <sch:assert test="d:alternateIdentifiers">
        Missing /resource/alternateIdentifiers block (zbMATH Identifier, zbMATH Document ID, URL).
      </sch:assert>
      <sch:assert test="d:creators">
        Missing /resource/creators block mapped from contributors/authors.
      </sch:assert>
      <sch:assert test="d:titles">
        Missing /resource/titles block (or ':unav' fallback).
      </sch:assert>
      <sch:assert test="d:publisher">
        Missing /resource/publisher (':unav' allowed).
      </sch:assert>
      <sch:assert test="d:publicationYear">
        Missing /resource/publicationYear (4-digit or ':unav').
      </sch:assert>
      <sch:assert test="d:resourceType">
        Missing /resource/resourceType with @resourceTypeGeneral mapping (JournalArticle/Book/:none).
      </sch:assert>
      <sch:assert test="d:rightsList">
        Missing /resource/rightsList with configured zbMATH/CC-BY-SA 4.0 rights statement.
      </sch:assert>
      <!-- subjects, language, descriptions, relatedIdentifiers, relatedItems are optional based on input/filters -->
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


  </schema>