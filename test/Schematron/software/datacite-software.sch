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

      <sch:assert test="not(datacite:relatedIdentifiers) or datacite:relatedIdentifiers/datacite:relatedIdentifier">
        relatedIdentifiers, if present, must contain at least one relatedIdentifier
      </sch:assert>
    </sch:rule>
  </sch:pattern>

   <sch:pattern id="p-identifier">
    <sch:rule context="datacite:identifier">
      <sch:assert test="@identifierType='swMATH'">
        identifier/@identifierType must be 'swMATH' (maps from /root/id)
      </sch:assert>
      <sch:assert test="normalize-space(.)!=''">
        identifier value must not be empty
      </sch:assert>
      <!-- value is numeric in your data; allow leading digits only -->
      <sch:assert test="translate(normalize-space(.),'0123456789','')=''">
        identifier should be numeric (swMATH internal id)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="p-alternateIdentifiers">
    <sch:rule context="datacite:alternateIdentifier">
      <sch:assert test="@alternateIdentifierType='URL'">
        alternateIdentifierType must be 'URL'
      </sch:assert>
      <sch:assert test="starts-with(normalize-space(.),'http://') or starts-with(normalize-space(.),'https://')">
        alternateIdentifier must be a URL
      </sch:assert>
      <!-- your template rewrites zbmath_url → swmath.org/software/... -->
      <sch:assert test="starts-with(normalize-space(.),'https://swmath.org/')">
        alternateIdentifier should point to swmath.org (derived from zbmath_url)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="p-creators">
    <sch:rule context="datacite:creator">
      <sch:assert test="datacite:creatorName[@nameType='Personal']">
        creatorName must have @nameType='Personal'
      </sch:assert>
      <!-- your XSLT always outputs given/family; may be ':unav' -->
      <sch:assert test="datacite:givenName">
        givenName is required (may be ':unav')
      </sch:assert>
      <sch:assert test="datacite:familyName">
        familyName is required (may be ':unav')
      </sch:assert>
      <sch:assert test="normalize-space(datacite:creatorName)!=''">
        creatorName must not be empty (may be ':unav')
      </sch:assert>
    </sch:rule>
  </sch:pattern>


  <sch:pattern id="p-titles">
    <sch:rule context="datacite:title">
      <sch:assert test="normalize-space(.)!=''">
        Title must not be empty (':unav' allowed by your logic, but not empty)
      </sch:assert>
    </sch:rule>
  </sch:pattern>


  <sch:pattern id="p-descriptions">
    <!-- abstract (always emitted; ':unav' if blocked/missing) -->
    <sch:rule context="datacite:descriptions">
      <sch:assert test="datacite:description[@descriptionType='Abstract']">
        An Abstract description must exist
      </sch:assert>
    </sch:rule>

    <sch:rule context="datacite:description[@descriptionType='TechnicalInfo']">
      <sch:assert test="contains(.,'operating systems') or contains(.,'programming languages')">
        TechnicalInfo must originate from operating_systems or programming_languages
      </sch:assert>
    </sch:rule>
  </sch:pattern>


   <sch:pattern id="p-publicationYear">
    <sch:rule context="datacite:publicationYear">
      <!-- either ':unav' OR a 4-digit year (per your fallbacks) -->
      <sch:assert test=".=':unav' or (string-length(normalize-space(.))=4 and translate(normalize-space(.),'0123456789','')='' and (starts-with(normalize-space(.),'1') or starts-with(normalize-space(.),'2')))">
        publicationYear must be ':unav' or a 4-digit year
      </sch:assert>
    </sch:rule>
  </sch:pattern>


  <sch:pattern id="p-subjects">
    <sch:rule context="datacite:subject">
      <sch:assert test="@subjectScheme='msc2020' or @subjectScheme='keyword'">
        subject/@subjectScheme must be 'msc2020' or 'keyword'
      </sch:assert>
      <sch:assert test="normalize-space(.)!=''">
        subject value must not be empty
      </sch:assert>
    </sch:rule>
  </sch:pattern>

   <sch:pattern id="p-language">
    <sch:rule context="datacite:language">
      <sch:assert test="normalize-space(.)='English'">
        language must be 'English' (as set by the stylesheet)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="p-resourceType">
    <sch:rule context="datacite:resourceType">
      <sch:assert test="@resourceTypeGeneral='Software'">
        resourceType/@resourceTypeGeneral must be 'Software'
      </sch:assert>
      <!-- your XSLT writes literal ':none' -->
      <sch:assert test="normalize-space(.)=':none'">
        resourceType text content must be ':none'
      </sch:assert>
    </sch:rule>
  </sch:pattern>


  <sch:pattern id="p-formats">
    <sch:rule context="datacite:format">
      <sch:assert test="normalize-space(.)='application/xml'">
        format must be 'application/xml'
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern id="p-publisher">
    <sch:rule context="datacite:publisher">
      <!-- stylesheet emits source_code OR homepage OR ':unav' -->
      <sch:assert test=".:=':unav' or starts-with(normalize-space(.),'http://') or starts-with(normalize-space(.),'https://')">
        publisher must be ':unav' or a URL (source_code/homepage)
      </sch:assert>
    </sch:rule>
  </sch:pattern>


 <sch:pattern id="p-relatedIdentifiers">
    <sch:rule context="datacite:relatedIdentifier">
      <sch:assert test="@relationType">
        relatedIdentifier must have @relationType
      </sch:assert>
      <sch:assert test="@relatedIdentifierType">
        relatedIdentifier must have @relatedIdentifierType
      </sch:assert>


      <sch:assert test="(@relationType='IsSourceOf' and @relatedIdentifierType='URL') or (@relationType!='IsSourceOf')">
        If relationType is 'IsSourceOf', relatedIdentifierType must be 'URL'
      </sch:assert>


      <sch:assert test="@relationType='IsSourceOf' or @relationType='IsCitedBy'">
        relationType must be 'IsSourceOf' (homepage) or 'IsCitedBy' (citations)
      </sch:assert>


      <sch:assert test="(@relatedIdentifierType!='URL') or
                        starts-with(normalize-space(.),'https://api.zbmath.org/v1/document/') or
                        starts-with(normalize-space(.),'https://zbmath.org/') or
                        starts-with(normalize-space(.),'http://') or starts-with(normalize-space(.),'https://')">
        URL relatedIdentifier must be a valid URL; citations typically point to zbMATH API or site
      </sch:assert>


      <sch:assert test="not(starts-with(normalize-space(.),'10.')) or
                        (@relatedIdentifierType='DOI' and @relationType='IsCitedBy')">
        Strings starting with '10.' must be emitted as DOI with relationType='IsCitedBy'
      </sch:assert>


      <sch:assert test="not(string-length(normalize-space(.)) &gt; 6 and substring(normalize-space(.),5,1)='.') or
                        ((@relatedIdentifierType='ARXIV' or @relatedIdentifierType='arXiv') and @relationType='IsCitedBy')">
        arXiv-like tokens must be emitted as ARXIV/arXiv with relationType='IsCitedBy'
      </sch:assert>
    </sch:rule>


    <sch:rule context="datacite:relatedIdentifiers">
      <sch:assert test="count(datacite:relatedIdentifier[@relationType='IsSourceOf']) &lt;= 1">
        At most one homepage relatedIdentifier (IsSourceOf) should be present
      </sch:assert>
    </sch:rule>
  </sch:pattern>


   <sch:pattern id="p-misc">
    <!-- ensure there is exactly one Abstract -->
    <sch:rule context="datacite:descriptions">
      <sch:assert test="count(datacite:description[@descriptionType='Abstract'])=1">
        There must be exactly one Abstract description
      </sch:assert>
    </sch:rule>

    <sch:rule context="datacite:subjects">
      <sch:assert test="count(datacite:subject[@subjectScheme='msc2020']) &gt;= 1">
        At least one msc2020 subject must be present
      </sch:assert>
    </sch:rule>
  </sch:pattern>

</sch:schema>