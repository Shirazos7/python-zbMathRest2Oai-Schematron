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