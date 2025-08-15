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

  </schema>