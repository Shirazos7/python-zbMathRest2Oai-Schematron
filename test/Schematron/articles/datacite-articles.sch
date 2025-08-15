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

  </schema>