<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:res="http://namespace.openaire.eu/schema/oaire/" xmlns:datacite="http://datacite.org/schema/kernel-4" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:oaire="http://www.openarchives.org/OAI/2.0/oai_dc/" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<axsl:param name="archiveDirParameter"/><axsl:param name="archiveNameParameter"/><axsl:param name="fileNameParameter"/><axsl:param name="fileDirParameter"/>

<!--PHASES-->


<!--PROLOG-->
<axsl:output xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--KEYS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-select-full-path"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<axsl:template match="*" mode="schematron-get-full-path"><axsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''"><axsl:value-of select="name()"/><axsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><axsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<axsl:value-of select="$p_1"/>]</axsl:if></axsl:when><axsl:otherwise><axsl:text>*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text><axsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><axsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<axsl:value-of select="$p_2"/>]</axsl:if></axsl:otherwise></axsl:choose></axsl:template><axsl:template match="@*" mode="schematron-get-full-path"><axsl:text>/</axsl:text><axsl:choose><axsl:when test="namespace-uri()=''">@<axsl:value-of select="name()"/></axsl:when><axsl:otherwise><axsl:text>@*[local-name()='</axsl:text><axsl:value-of select="local-name()"/><axsl:text>' and namespace-uri()='</axsl:text><axsl:value-of select="namespace-uri()"/><axsl:text>']</axsl:text></axsl:otherwise></axsl:choose></axsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-2"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="preceding-sibling::*[name(.)=name(current())]"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<axsl:template match="/" mode="generate-id-from-path"/><axsl:template match="text()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></axsl:template><axsl:template match="comment()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></axsl:template><axsl:template match="processing-instruction()" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></axsl:template><axsl:template match="@*" mode="generate-id-from-path"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:value-of select="concat('.@', name())"/></axsl:template><axsl:template match="*" mode="generate-id-from-path" priority="-0.5"><axsl:apply-templates select="parent::*" mode="generate-id-from-path"/><axsl:text>.</axsl:text><axsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></axsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<axsl:template match="node() | @*" mode="schematron-get-full-path-3"><axsl:for-each select="ancestor-or-self::*"><axsl:text>/</axsl:text><axsl:value-of select="name(.)"/><axsl:if test="parent::*"><axsl:text>[</axsl:text><axsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><axsl:text>]</axsl:text></axsl:if></axsl:for-each><axsl:if test="not(self::*)"><axsl:text/>/@<axsl:value-of select="name(.)"/></axsl:if></axsl:template>

<!--MODE: GENERATE-ID-2 -->
<axsl:template match="/" mode="generate-id-2">U</axsl:template><axsl:template match="*" mode="generate-id-2" priority="2"><axsl:text>U</axsl:text><axsl:number level="multiple" count="*"/></axsl:template><axsl:template match="node()" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>n</axsl:text><axsl:number count="node()"/></axsl:template><axsl:template match="@*" mode="generate-id-2"><axsl:text>U.</axsl:text><axsl:number level="multiple" count="*"/><axsl:text>_</axsl:text><axsl:value-of select="string-length(local-name(.))"/><axsl:text>_</axsl:text><axsl:value-of select="translate(name(),':','.')"/></axsl:template><!--Strip characters--><axsl:template match="text()" priority="-1"/>

<!--SCHEMA METADATA-->
<axsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" title="Schematron Validation for OpenAIRE XSLT Output" schemaVersion=""><axsl:comment><axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/></axsl:comment><svrl:ns-prefix-in-attribute-values uri="http://namespace.openaire.eu/schema/oaire/" prefix="res"/><svrl:ns-prefix-in-attribute-values uri="http://datacite.org/schema/kernel-4" prefix="datacite"/><svrl:ns-prefix-in-attribute-values uri="http://purl.org/dc/elements/1.1/" prefix="dc"/><svrl:ns-prefix-in-attribute-values uri="http://www.openarchives.org/OAI/2.0/oai_dc/" prefix="oaire"/><svrl:active-pattern><axsl:attribute name="id">identifier</axsl:attribute><axsl:attribute name="name">Check for datacite:identifier</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M5"/><svrl:active-pattern><axsl:attribute name="id">alternateIdentifiers</axsl:attribute><axsl:attribute name="name">Check for datacite:alternateIdentifiers</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M6"/><svrl:active-pattern><axsl:attribute name="id">creators</axsl:attribute><axsl:attribute name="name">Check for datacite:creators and creator structure</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><axsl:attribute name="id">creator-details</axsl:attribute><axsl:attribute name="name">Check for creator name fields</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><axsl:attribute name="id">titles</axsl:attribute><axsl:attribute name="name">Check for datacite:title</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><axsl:attribute name="id">abstract</axsl:attribute><axsl:attribute name="name">Check for abstract in dc:description</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><axsl:attribute name="id">subjects</axsl:attribute><axsl:attribute name="name">Check for datacite:subject</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><axsl:attribute name="id">issued-date</axsl:attribute><axsl:attribute name="name">Check for datacite:date</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M12"/><svrl:active-pattern><axsl:attribute name="id">publisher</axsl:attribute><axsl:attribute name="name">Check for dc:publisher</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M13"/><svrl:active-pattern><axsl:attribute name="id">resourceType</axsl:attribute><axsl:attribute name="name">Check for oaire:resourceType</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M14"/><svrl:active-pattern><axsl:attribute name="id">relatedIdentifiers</axsl:attribute><axsl:attribute name="name">Check for datacite:relatedIdentifier</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M15"/><svrl:active-pattern><axsl:attribute name="id">source</axsl:attribute><axsl:attribute name="name">Check for dc:source</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M16"/><svrl:active-pattern><axsl:attribute name="id">citation</axsl:attribute><axsl:attribute name="name">Check for citation metadata</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M17"/></svrl:schematron-output></axsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Schematron Validation for OpenAIRE XSLT Output</svrl:text>

<!--PATTERN identifierCheck for datacite:identifier-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:identifier</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:identifier"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:identifier"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: datacite:identifier is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:identifier and normalize-space(datacite:identifier) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:identifier and normalize-space(datacite:identifier) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: datacite:identifier is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template><axsl:template match="text()" priority="-1" mode="M5"/><axsl:template match="@*|node()" priority="-2" mode="M5"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M5"/></axsl:template>

<!--PATTERN alternateIdentifiersCheck for datacite:alternateIdentifiers-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:alternateIdentifiers</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:alternateIdentifiers/datacite:alternateIdentifier"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:alternateIdentifiers/datacite:alternateIdentifier"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: At least one datacite:alternateIdentifier is required (DOI or arXiv).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:alternateIdentifiers/datacite:alternateIdentifier and normalize-space(datacite:alternateIdentifiers/datacite:alternateIdentifier) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:alternateIdentifiers/datacite:alternateIdentifier and normalize-space(datacite:alternateIdentifiers/datacite:alternateIdentifier) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: datacite:alternateIdentifier is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template><axsl:template match="text()" priority="-1" mode="M6"/><axsl:template match="@*|node()" priority="-2" mode="M6"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M6"/></axsl:template>

<!--PATTERN creatorsCheck for datacite:creators and creator structure-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:creators and creator structure</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:creators/datacite:creator"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:creators/datacite:creator"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: At least one datacite:creator must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:creators/datacite:creator and not(datacite:creators/datacite:creator/datacite:creatorName)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:creators/datacite:creator and not(datacite:creators/datacite:creator/datacite:creatorName)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: datacite:creator is present but missing datacite:creatorName.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M7"/></axsl:template>

<!--PATTERN creator-detailsCheck for creator name fields-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for creator name fields</svrl:text>

	<!--RULE -->
<axsl:template match="datacite:creator" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="datacite:creator"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:creatorName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:creatorName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: datacite:creatorName is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:givenName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:givenName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: datacite:givenName is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:familyName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:familyName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: datacite:familyName is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="not(datacite:nameIdentifier)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(datacite:nameIdentifier)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: datacite:nameIdentifier (zbMATH Author Code) is recommended.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></axsl:template><axsl:template match="text()" priority="-1" mode="M8"/><axsl:template match="@*|node()" priority="-2" mode="M8"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M8"/></axsl:template>

<!--PATTERN titlesCheck for datacite:title-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:title</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:titles/datacite:title"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:titles/datacite:title"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: datacite:title must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:titles/datacite:title and normalize-space(datacite:titles/datacite:title) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:titles/datacite:title and normalize-space(datacite:titles/datacite:title) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: datacite:title is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></axsl:template><axsl:template match="text()" priority="-1" mode="M9"/><axsl:template match="@*|node()" priority="-2" mode="M9"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M9"/></axsl:template>

<!--PATTERN abstractCheck for abstract in dc:description-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for abstract in dc:description</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="dc:description"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:description"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: dc:description (abstract) must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="dc:description and normalize-space(dc:description) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:description and normalize-space(dc:description) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: dc:description is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></axsl:template><axsl:template match="text()" priority="-1" mode="M10"/><axsl:template match="@*|node()" priority="-2" mode="M10"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M10"/></axsl:template>

<!--PATTERN subjectsCheck for datacite:subject-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:subject</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:subjects/datacite:subject"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:subjects/datacite:subject"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: At least one datacite:subject (MSC or keyword) must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:subjects/datacite:subject[normalize-space(.) = '']"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:subjects/datacite:subject[normalize-space(.) = '']"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: One or more datacite:subject entries are empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></axsl:template><axsl:template match="text()" priority="-1" mode="M11"/><axsl:template match="@*|node()" priority="-2" mode="M11"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M11"/></axsl:template>

<!--PATTERN issued-dateCheck for datacite:date-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:date</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:dates/datacite:date[@dateType='Issued']"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:dates/datacite:date[@dateType='Issued']"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: Publication date (datacite:date with dateType='Issued') must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:dates/datacite:date[@dateType='Issued'] and normalize-space(datacite:dates/datacite:date[@dateType='Issued']) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:dates/datacite:date[@dateType='Issued'] and normalize-space(datacite:dates/datacite:date[@dateType='Issued']) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: Issued date is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></axsl:template><axsl:template match="text()" priority="-1" mode="M12"/><axsl:template match="@*|node()" priority="-2" mode="M12"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M12"/></axsl:template>

<!--PATTERN publisherCheck for dc:publisher-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for dc:publisher</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M13"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="dc:publisher"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:publisher"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: dc:publisher must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="dc:publisher and normalize-space(dc:publisher) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:publisher and normalize-space(dc:publisher) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: dc:publisher is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></axsl:template><axsl:template match="text()" priority="-1" mode="M13"/><axsl:template match="@*|node()" priority="-2" mode="M13"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M13"/></axsl:template>

<!--PATTERN resourceTypeCheck for oaire:resourceType-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for oaire:resourceType</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:resourceType"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:resourceType"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:resourceType must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="oaire:resourceType and normalize-space(oaire:resourceType) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:resourceType and normalize-space(oaire:resourceType) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: oaire:resourceType is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></axsl:template><axsl:template match="text()" priority="-1" mode="M14"/><axsl:template match="@*|node()" priority="-2" mode="M14"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></axsl:template>

<!--PATTERN relatedIdentifiersCheck for datacite:relatedIdentifier-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for datacite:relatedIdentifier</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="datacite:relatedIdentifiers/datacite:relatedIdentifier"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:relatedIdentifiers/datacite:relatedIdentifier"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: At least one datacite:relatedIdentifier must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="datacite:relatedIdentifiers/datacite:relatedIdentifier[normalize-space(.) = '']"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="datacite:relatedIdentifiers/datacite:relatedIdentifier[normalize-space(.) = '']"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: One or more datacite:relatedIdentifier entries are empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></axsl:template><axsl:template match="text()" priority="-1" mode="M15"/><axsl:template match="@*|node()" priority="-2" mode="M15"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></axsl:template>

<!--PATTERN sourceCheck for dc:source-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for dc:source</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="dc:source"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:source"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: dc:source must be present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="dc:source and normalize-space(dc:source) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="dc:source and normalize-space(dc:source) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: dc:source is present but empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></axsl:template><axsl:template match="text()" priority="-1" mode="M16"/><axsl:template match="@*|node()" priority="-2" mode="M16"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></axsl:template>

<!--PATTERN citationCheck for citation metadata-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Check for citation metadata</svrl:text>

	<!--RULE -->
<axsl:template match="resource" priority="1000" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:citationTitle"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationTitle"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:citationTitle is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:citationVolume"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationVolume"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:citationVolume is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:citationIssue"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationIssue"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:citationIssue is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:citationStartPage"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationStartPage"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:citationStartPage is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="oaire:citationEndPage"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationEndPage"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ERROR: oaire:citationEndPage is required.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="oaire:citationVolume and normalize-space(oaire:citationVolume) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationVolume and normalize-space(oaire:citationVolume) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: oaire:citationVolume is empty.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="oaire:citationIssue and normalize-space(oaire:citationIssue) = ''"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="oaire:citationIssue and normalize-space(oaire:citationIssue) = ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        WARNING: oaire:citationIssue is empty.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></axsl:template><axsl:template match="text()" priority="-1" mode="M17"/><axsl:template match="@*|node()" priority="-2" mode="M17"><axsl:apply-templates select="*|comment()|processing-instruction()" mode="M17"/></axsl:template></axsl:stylesheet>
