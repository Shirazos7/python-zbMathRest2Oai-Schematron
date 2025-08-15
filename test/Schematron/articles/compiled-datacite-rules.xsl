<?xml version="1.0" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:d="http://datacite.org/schema/kernel-4" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
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
<axsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" title="" schemaVersion=""><axsl:comment><axsl:value-of select="$archiveDirParameter"/>   
		 <axsl:value-of select="$archiveNameParameter"/>  
		 <axsl:value-of select="$fileNameParameter"/>  
		 <axsl:value-of select="$fileDirParameter"/></axsl:comment><svrl:ns-prefix-in-attribute-values uri="http://datacite.org/schema/kernel-4" prefix="d"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/XML/1998/namespace" prefix="xml"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/><svrl:active-pattern><axsl:attribute name="id">p_root_and_order</axsl:attribute><axsl:attribute name="name">resource root and child element order as emitted by XSLT</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M3"/><svrl:active-pattern><axsl:attribute name="id">p_identifier</axsl:attribute><axsl:attribute name="name">Primary identifier (DOI preferred; ARXIV if no DOI)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M4"/><svrl:active-pattern><axsl:attribute name="id">p_alternate_identifiers</axsl:attribute><axsl:attribute name="name">Alternate identifiers (zbMATH Identifier, zbMATH Document ID, URL)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M5"/><svrl:active-pattern><axsl:attribute name="id">p_creators</axsl:attribute><axsl:attribute name="name">Creators mapping, including ':unav' placeholder option</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M6"/><svrl:active-pattern><axsl:attribute name="id">p_descriptions</axsl:attribute><axsl:attribute name="name">Abstract description</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><axsl:attribute name="id">p_titles</axsl:attribute><axsl:attribute name="name">Titles and fallback</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><axsl:attribute name="id">p_publisher</axsl:attribute><axsl:attribute name="name">Publisher</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><axsl:attribute name="id">p_publication_year</axsl:attribute><axsl:attribute name="name">Publication year</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><axsl:attribute name="id">p_subjects</axsl:attribute><axsl:attribute name="name">Subjects (MSC and keywords)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><axsl:attribute name="id">p_language</axsl:attribute><axsl:attribute name="name">Language</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M12"/><svrl:active-pattern><axsl:attribute name="id">p_resource_type</axsl:attribute><axsl:attribute name="name">Resource type mapping (JournalArticle/Book/:none)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M13"/><svrl:active-pattern><axsl:attribute name="id">p_related_identifiers</axsl:attribute><axsl:attribute name="name">Related identifiers (Cites / IsCitedBy / IsPartOf) — optional</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M14"/><svrl:active-pattern><axsl:attribute name="id">p_rights</axsl:attribute><axsl:attribute name="name">Rights statement (zbMATH / CC-BY-SA 4.0)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M15"/><svrl:active-pattern><axsl:attribute name="id">p_relatedItems_cites</axsl:attribute><axsl:attribute name="name">relatedItems: Cites → JournalArticle</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M16"/><svrl:active-pattern><axsl:attribute name="id">p_relatedItems_isPublishedIn</axsl:attribute><axsl:attribute name="name">relatedItems: IsPublishedIn → Book (container)</axsl:attribute><axsl:apply-templates/></svrl:active-pattern><axsl:apply-templates select="/" mode="M17"/></svrl:schematron-output></axsl:template>

<!--SCHEMATRON PATTERNS-->


<!--PATTERN p_root_and_orderresource root and child element order as emitted by XSLT-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">resource root and child element order as emitted by XSLT</svrl:text>

	<!--RULE -->
<axsl:template match="/" priority="1001" mode="M3"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(/d:resource)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(/d:resource)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Must have exactly one d:resource root element.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource" priority="1000" mode="M3"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="contains(@xsi:schemaLocation, 'http://datacite.org/schema/kernel-4 ')              and (contains(@xsi:schemaLocation, 'schema.datacite.org/meta/kernel-4/metadata.xsd')              or contains(@xsi:schemaLocation, 'schema.datacite.org/meta/kernel-4.1/metadata.xsd'))"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="contains(@xsi:schemaLocation, 'http://datacite.org/schema/kernel-4 ') and (contains(@xsi:schemaLocation, 'schema.datacite.org/meta/kernel-4/metadata.xsd') or contains(@xsi:schemaLocation, 'schema.datacite.org/meta/kernel-4.1/metadata.xsd'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
             d:resource/@xsi:schemaLocation must reference DataCite kernel-4 (4.0 or 4.1).
     </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:alternateIdentifiers)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:alternateIdentifiers)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Exactly one d:alternateIdentifiers element is required (the XSLT always emits this container).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:creators)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:creators)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Exactly one d:creators element is required (container is always emitted).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:titles)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:titles)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Exactly one d:titles element is required (either from root/title or the ':unav' fallback).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:rightsList)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:rightsList)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Exactly one d:rightsList element is required (always emitted).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:relatedItems)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:relatedItems)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Exactly one d:relatedItems element is required (container is always emitted).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:identifier) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:identifier) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:identifier is allowed (first DOI or first ARXIV only).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:descriptions) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:descriptions) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:descriptions block is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:publisher) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:publisher) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:publisher is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:publicationYear) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:publicationYear) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:publicationYear is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:subjects) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:subjects) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:subjects block is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:language) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:language) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:language is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:resourceType) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:resourceType) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:resourceType is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:relatedIdentifiers) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:relatedIdentifiers) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:relatedIdentifiers block is allowed.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:relatedIdentifier)"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:relatedIdentifier)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:relatedIdentifier elements must appear only inside d:relatedIdentifiers.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:identifier) or count(d:identifier/preceding-sibling::*)=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:identifier) or count(d:identifier/preceding-sibling::*)=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:identifier (when present) must be the first child element of d:resource.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:alternateIdentifiers/preceding-sibling::*[not(self::d:identifier)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:alternateIdentifiers/preceding-sibling::*[not(self::d:identifier)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:alternateIdentifiers must come immediately after d:identifier (if any) and before all other blocks.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:creators/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:creators/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:creators must come after d:alternateIdentifiers (and identifier, if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:descriptions) or count(d:descriptions/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:descriptions) or count(d:descriptions/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:descriptions (when present) must come after d:creators and before d:titles.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:titles/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:titles/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:titles must come after d:creators (and d:descriptions if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:publisher) or count(d:publisher/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:publisher) or count(d:publisher/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:publisher (when present) must come after d:titles.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:publicationYear) or count(d:publicationYear/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:publicationYear) or count(d:publicationYear/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:publicationYear (when present) must come after d:publisher (if present) and after d:titles.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:subjects) or count(d:subjects/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:subjects) or count(d:subjects/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:subjects (when present) must come after d:publicationYear (if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:language) or count(d:language/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:language) or count(d:language/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:language (when present) must come after d:subjects (if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:resourceType) or count(d:resourceType/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:resourceType) or count(d:resourceType/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:resourceType (when present) must come after d:language (if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:relatedIdentifiers) or count(d:relatedIdentifiers/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language or self::d:resourceType)])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:relatedIdentifiers) or count(d:relatedIdentifiers/preceding-sibling::*[not(self::d:identifier or self::d:alternateIdentifiers or self::d:creators or self::d:descriptions or self::d:titles or self::d:publisher or self::d:publicationYear or self::d:subjects or self::d:language or self::d:resourceType)])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:relatedIdentifiers (when present) must come after d:resourceType (if present).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:rightsList/preceding-sibling::*[self::d:relatedItems])=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:rightsList/preceding-sibling::*[self::d:relatedItems])=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:rightsList must appear before d:relatedItems.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:relatedItems/following-sibling::*)=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:relatedItems/following-sibling::*)=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        d:relatedItems must be the last child element in d:resource.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/></axsl:template><axsl:template match="text()" priority="-1" mode="M3"/><axsl:template match="@*|node()" priority="-2" mode="M3"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M3"/></axsl:template>

<!--PATTERN p_identifierPrimary identifier (DOI preferred; ARXIV if no DOI)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Primary identifier (DOI preferred; ARXIV if no DOI)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:identifier" priority="1000" mode="M4"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:identifier"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@identifierType='DOI' or @identifierType='ARXIV'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@identifierType='DOI' or @identifierType='ARXIV'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        @identifierType must be 'DOI' (if any DOI existed) or 'ARXIV' (only when no DOI existed); got '<axsl:text/><axsl:value-of select="@identifierType"/><axsl:text/>'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="@identifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@identifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        DOI value '<axsl:text/><axsl:value-of select="."/><axsl:text/>' does not look like a DOI (should contain a slash and no spaces).
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@identifierType='ARXIV' and not(starts-with(normalize-space(.), 'arXiv:'))                                  and not(contains(., '.'))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@identifierType='ARXIV' and not(starts-with(normalize-space(.), 'arXiv:')) and not(contains(., '.'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ARXIV value '<axsl:text/><axsl:value-of select="."/><axsl:text/>' should resemble 'arXiv:YYYY.NNNN' or 'YYYY.NNNN'.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/></axsl:template><axsl:template match="text()" priority="-1" mode="M4"/><axsl:template match="@*|node()" priority="-2" mode="M4"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M4"/></axsl:template>

<!--PATTERN p_alternate_identifiersAlternate identifiers (zbMATH Identifier, zbMATH Document ID, URL)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Alternate identifiers (zbMATH Identifier, zbMATH Document ID, URL)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:alternateIdentifiers" priority="1001" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:alternateIdentifiers"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:alternateIdentifier) &gt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:alternateIdentifier) &gt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Expected at least one alternateIdentifier (zbMATH Identifier/Document ID/URL) when present in source.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:alternateIdentifiers/d:alternateIdentifier" priority="1000" mode="M5"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:alternateIdentifiers/d:alternateIdentifier"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@alternateIdentifierType='zbMATH Identifier'                         or @alternateIdentifierType='zbMATH Document ID'                         or @alternateIdentifierType='URL'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@alternateIdentifierType='zbMATH Identifier' or @alternateIdentifierType='zbMATH Document ID' or @alternateIdentifierType='URL'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        alternateIdentifierType must be one of 'zbMATH Identifier', 'zbMATH Document ID', or 'URL'; got '<axsl:text/><axsl:value-of select="@alternateIdentifierType"/><axsl:text/>'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)!=''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)!=''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        alternateIdentifier value must not be empty.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="@alternateIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@alternateIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        URL alternateIdentifier should start with 'http' (got '<axsl:text/><axsl:value-of select="."/><axsl:text/>' ).
      </svrl:text></svrl:successful-report></axsl:if>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(following-sibling::d:alternateIdentifier[@alternateIdentifierType=current()/@alternateIdentifierType])"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(following-sibling::d:alternateIdentifier[@alternateIdentifierType=current()/@alternateIdentifierType])"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Duplicate alternateIdentifier of type '<axsl:text/><axsl:value-of select="@alternateIdentifierType"/><axsl:text/>'; only one per type expected.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5"/></axsl:template><axsl:template match="text()" priority="-1" mode="M5"/><axsl:template match="@*|node()" priority="-2" mode="M5"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M5"/></axsl:template>

<!--PATTERN p_creatorsCreators mapping, including ':unav' placeholder option-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Creators mapping, including ':unav' placeholder option</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:creators" priority="1001" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:creators"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:creator) &gt;= 1                         or (count(d:creator)=1                             and normalize-space(d:creator/d:creatorName)=':unav'                             and normalize-space(d:creator/d:givenName)=':unav'                             and normalize-space(d:creator/d:familyName)=':unav'                             and normalize-space(d:creator/d:nameIdentifier)=':unav')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:creator) &gt;= 1 or (count(d:creator)=1 and normalize-space(d:creator/d:creatorName)=':unav' and normalize-space(d:creator/d:givenName)=':unav' and normalize-space(d:creator/d:familyName)=':unav' and normalize-space(d:creator/d:nameIdentifier)=':unav')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Creators must include ≥1 creator OR a single ':unav' placeholder creator when no authors are available.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="count(d:creator)=0"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:creator)=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        No creators generated. If source has no authors, emit one placeholder creator with ':unav' values; otherwise map authors to creators.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:creators/d:creator" priority="1000" mode="M6"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:creators/d:creator"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:creatorName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:creatorName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Missing creatorName.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:givenName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:givenName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Missing givenName (':unav' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:familyName"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:familyName"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Missing familyName (':unav' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:nameIdentifier"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:nameIdentifier"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Missing nameIdentifier (':unav' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:nameIdentifier) or d:nameIdentifier/@nameIdentifierScheme='zbMATH Author Code'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:nameIdentifier) or d:nameIdentifier/@nameIdentifierScheme='zbMATH Author Code'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        nameIdentifier/@nameIdentifierScheme must be 'zbMATH Author Code'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(d:nameIdentifier) or d:nameIdentifier/@schemeURI='https://zbmath.org/'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(d:nameIdentifier) or d:nameIdentifier/@schemeURI='https://zbmath.org/'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        nameIdentifier/@schemeURI must be 'https://zbmath.org/'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="normalize-space(d:creatorName)!=':unav'                         and contains(normalize-space(d:creatorName), ',')                         and normalize-space(d:givenName) != normalize-space(substring-after(d:creatorName, ','))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(d:creatorName)!=':unav' and contains(normalize-space(d:creatorName), ',') and normalize-space(d:givenName) != normalize-space(substring-after(d:creatorName, ','))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        givenName '<axsl:text/><axsl:value-of select="d:givenName"/><axsl:text/>' should equal the part after the comma in creatorName '<axsl:text/><axsl:value-of select="d:creatorName"/><axsl:text/>'.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="normalize-space(d:creatorName)!=':unav'                         and contains(normalize-space(d:creatorName), ',')                         and normalize-space(d:familyName) != normalize-space(substring-before(d:creatorName, ','))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(d:creatorName)!=':unav' and contains(normalize-space(d:creatorName), ',') and normalize-space(d:familyName) != normalize-space(substring-before(d:creatorName, ','))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        familyName '<axsl:text/><axsl:value-of select="d:familyName"/><axsl:text/>' should equal the part before the comma in creatorName '<axsl:text/><axsl:value-of select="d:creatorName"/><axsl:text/>'.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/></axsl:template><axsl:template match="text()" priority="-1" mode="M6"/><axsl:template match="@*|node()" priority="-2" mode="M6"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M6"/></axsl:template>

<!--PATTERN p_descriptionsAbstract description-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Abstract description</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:descriptions" priority="1001" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:descriptions"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:description) &gt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:description) &gt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        /descriptions must contain at least one description when present.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:descriptions/d:description" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:descriptions/d:description"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@descriptionType='Abstract'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@descriptionType='Abstract'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>description/@descriptionType must be 'Abstract'.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@xml:lang"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@xml:lang"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>description must have @xml:lang.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)!=''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)!=''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Abstract text must not be empty.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(contains(., 'zbMATH Open Web Interface contents unavailable'))"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(contains(., 'zbMATH Open Web Interface contents unavailable'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Abstract must not contain the placeholder text for unavailable content.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></axsl:template><axsl:template match="text()" priority="-1" mode="M7"/><axsl:template match="@*|node()" priority="-2" mode="M7"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></axsl:template>

<!--PATTERN p_titlesTitles and fallback-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Titles and fallback</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:titles" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:titles"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:title)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:title)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Exactly one titles/title expected.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:title/@xml:lang"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:title/@xml:lang"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>/titles/title must carry @xml:lang.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(d:title)!=''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(d:title)!=''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>/titles/title must not be empty (':unav' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></axsl:template><axsl:template match="text()" priority="-1" mode="M8"/><axsl:template match="@*|node()" priority="-2" mode="M8"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></axsl:template>

<!--PATTERN p_publisherPublisher-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Publisher</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:publisher" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:publisher"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)!=''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)!=''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>publisher must not be empty (':unav' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></axsl:template><axsl:template match="text()" priority="-1" mode="M9"/><axsl:template match="@*|node()" priority="-2" mode="M9"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></axsl:template>

<!--PATTERN p_publication_yearPublication year-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Publication year</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:publicationYear" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:publicationYear"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        publicationYear must be a 4-digit year or ':unav'; got '<axsl:text/><axsl:value-of select="."/><axsl:text/>'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/></axsl:template><axsl:template match="text()" priority="-1" mode="M10"/><axsl:template match="@*|node()" priority="-2" mode="M10"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/></axsl:template>

<!--PATTERN p_subjectsSubjects (MSC and keywords)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Subjects (MSC and keywords)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:subjects/d:subject" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:subjects/d:subject"/>

		<!--REPORT -->
<axsl:if test="@classificationCode and not(@subjectScheme)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@classificationCode and not(@subjectScheme)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        MSC subject must have @subjectScheme (e.g., 'msc2020').
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@classificationCode and (string-length(@classificationCode)!=5                          or string-length(translate(substring(@classificationCode,1,2),'0123456789','')) &gt; 0                          or string-length(translate(substring(@classificationCode,3,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','')) &gt; 0                          or string-length(translate(substring(@classificationCode,4,2),'0123456789','')) &gt; 0)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@classificationCode and (string-length(@classificationCode)!=5 or string-length(translate(substring(@classificationCode,1,2),'0123456789','')) &gt; 0 or string-length(translate(substring(@classificationCode,3,1),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','')) &gt; 0 or string-length(translate(substring(@classificationCode,4,2),'0123456789','')) &gt; 0)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        MSC @classificationCode '<axsl:text/><axsl:value-of select="@classificationCode"/><axsl:text/>' should look like '11N05'.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@subjectScheme='keyword' and @classificationCode"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@subjectScheme='keyword' and @classificationCode"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Keyword subjects should not carry @classificationCode.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.) != ''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.) != ''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Subject value must not be empty.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/></axsl:template><axsl:template match="text()" priority="-1" mode="M11"/><axsl:template match="@*|node()" priority="-2" mode="M11"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/></axsl:template>

<!--PATTERN p_languageLanguage-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Language</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:language" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:language"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)!=''"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)!=''"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>language value must not be empty (':unkn' allowed).</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/></axsl:template><axsl:template match="text()" priority="-1" mode="M12"/><axsl:template match="@*|node()" priority="-2" mode="M12"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/></axsl:template>

<!--PATTERN p_resource_typeResource type mapping (JournalArticle/Book/:none)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Resource type mapping (JournalArticle/Book/:none)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:resourceType" priority="1000" mode="M13"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:resourceType"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@resourceTypeGeneral"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@resourceTypeGeneral"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>resourceType must carry @resourceTypeGeneral.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'article') and @resourceTypeGeneral='JournalArticle')                         or (contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'book') and @resourceTypeGeneral='Book')                         or (not(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'article'))                             and not(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'book'))                             and @resourceTypeGeneral=':none')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'article') and @resourceTypeGeneral='JournalArticle') or (contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'book') and @resourceTypeGeneral='Book') or (not(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'article')) and not(contains(translate(normalize-space(.),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'book')) and @resourceTypeGeneral=':none')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        resourceTypeGeneral does not match the text mapping rule for 'article'/'book'/other → ':none'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13"/></axsl:template><axsl:template match="text()" priority="-1" mode="M13"/><axsl:template match="@*|node()" priority="-2" mode="M13"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M13"/></axsl:template>

<!--PATTERN p_related_identifiersRelated identifiers (Cites / IsCitedBy / IsPartOf) — optional-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Related identifiers (Cites / IsCitedBy / IsPartOf) — optional</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource" priority="1001" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:relatedIdentifiers) &lt;= 1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:relatedIdentifiers) &lt;= 1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        At most one d:relatedIdentifiers container (it may be absent).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedIdentifiers/d:relatedIdentifier" priority="1000" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedIdentifiers/d:relatedIdentifier"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@relationType='Cites' or @relationType='IsCitedBy' or @relationType='IsPartOf'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relationType='Cites' or @relationType='IsCitedBy' or @relationType='IsPartOf'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        relationType must be 'Cites', 'IsCitedBy', or 'IsPartOf'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@relatedIdentifierType='DOI' or @relatedIdentifierType='URL' or @relatedIdentifierType='ARXIV'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedIdentifierType='DOI' or @relatedIdentifierType='URL' or @relatedIdentifierType='ARXIV'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        relatedIdentifierType must be 'DOI', 'URL', or 'ARXIV'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@relationType='IsCitedBy') or @relatedIdentifierType='URL'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@relationType='IsCitedBy') or @relatedIdentifierType='URL'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        'IsCitedBy' entries are produced only as zbMATH URLs.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="not(@relatedIdentifierType='ARXIV') or @relationType='IsPartOf'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="not(@relatedIdentifierType='ARXIV') or @relationType='IsPartOf'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ARXIV relatedIdentifier is only produced with relationType='IsPartOf'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="@relatedIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        URL relatedIdentifier should start with 'http'.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@relatedIdentifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedIdentifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        DOI relatedIdentifier '<axsl:text/><axsl:value-of select="."/><axsl:text/>' should contain a slash and no spaces.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@relatedIdentifierType='ARXIV' and not(starts-with(normalize-space(.), 'arXiv:')) and not(contains(., '.'))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedIdentifierType='ARXIV' and not(starts-with(normalize-space(.), 'arXiv:')) and not(contains(., '.'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ARXIV relatedIdentifier '<axsl:text/><axsl:value-of select="."/><axsl:text/>' should resemble 'arXiv:YYYY.NNNN' or 'YYYY.NNNN'.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14"/></axsl:template><axsl:template match="text()" priority="-1" mode="M14"/><axsl:template match="@*|node()" priority="-2" mode="M14"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M14"/></axsl:template>

<!--PATTERN p_rightsRights statement (zbMATH / CC-BY-SA 4.0)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">Rights statement (zbMATH / CC-BY-SA 4.0)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:rightsList" priority="1001" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:rightsList"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="count(d:rights)=1"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="count(d:rights)=1"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        rightsList must contain exactly one rights element with the configured zbMATH statement.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:rightsList/d:rights" priority="1000" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:rightsList/d:rights"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@rightsIdentifier='CC-BY-SA 4.0'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@rightsIdentifier='CC-BY-SA 4.0'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>rightsIdentifier must be 'CC-BY-SA 4.0'.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@rightsURI='https://creativecommons.org/licenses/by-sa/4.0/'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@rightsURI='https://creativecommons.org/licenses/by-sa/4.0/'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>rightsURI must be that CC BY-SA URL.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@rightsIdentifierScheme='zbMATH'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@rightsIdentifierScheme='zbMATH'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>rightsIdentifierScheme must be 'zbMATH'.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@schemeURI='https://api.zbmath.org/v1/'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@schemeURI='https://api.zbmath.org/v1/'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>schemeURI must be 'https://api.zbmath.org/v1/'.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@xml:lang"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@xml:lang"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>rights must have @xml:lang.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="contains(., 'zbMATH Open OAI-PMH API')"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="contains(., 'zbMATH Open OAI-PMH API')"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        rights text must contain the zbMATH Open OAI-PMH API notice.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15"/></axsl:template><axsl:template match="text()" priority="-1" mode="M15"/><axsl:template match="@*|node()" priority="-2" mode="M15"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M15"/></axsl:template>

<!--PATTERN p_relatedItems_citesrelatedItems: Cites → JournalArticle-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">relatedItems: Cites → JournalArticle</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']" priority="1003" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@relatedItemType='JournalArticle'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedItemType='JournalArticle'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>relatedItemType must be 'JournalArticle'.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:relatedItemIdentifier"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:relatedItemIdentifier"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>relatedItemIdentifier is required.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:titles/d:title"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:titles/d:title"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>titles/title is required.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:publicationYear"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:publicationYear"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>publicationYear is required.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:creators/d:creator"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:creators/d:creator"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>At least one creator expected for cited items.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:relatedItemIdentifier" priority="1002" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:relatedItemIdentifier"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@relatedItemIdentifierType='DOI' or @relatedItemIdentifierType='URL'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedItemIdentifierType='DOI' or @relatedItemIdentifierType='URL'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        relatedItemIdentifierType must be 'DOI' or 'URL'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--REPORT -->
<axsl:if test="@relatedItemIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedItemIdentifierType='URL' and not(starts-with(normalize-space(.), 'http'))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        relatedItemIdentifier URL should start with 'http'.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="@relatedItemIdentifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedItemIdentifierType='DOI' and (not(contains(normalize-space(.), '/')) or contains(., ' '))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        relatedItemIdentifier DOI '<axsl:text/><axsl:value-of select="."/><axsl:text/>' should contain a slash and no spaces.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:creators/d:creator" priority="1001" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:creators/d:creator"/>

		<!--REPORT -->
<axsl:if test="normalize-space(d:creatorName)!=':unav'                         and contains(normalize-space(d:creatorName), ',')                         and normalize-space(d:givenName) != normalize-space(substring-after(d:creatorName, ','))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(d:creatorName)!=':unav' and contains(normalize-space(d:creatorName), ',') and normalize-space(d:givenName) != normalize-space(substring-after(d:creatorName, ','))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        (Cited item) givenName mismatch with creatorName.
      </svrl:text></svrl:successful-report></axsl:if>

		<!--REPORT -->
<axsl:if test="normalize-space(d:creatorName)!=':unav'                         and contains(normalize-space(d:creatorName), ',')                         and normalize-space(d:familyName) != normalize-space(substring-before(d:creatorName, ','))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(d:creatorName)!=':unav' and contains(normalize-space(d:creatorName), ',') and normalize-space(d:familyName) != normalize-space(substring-before(d:creatorName, ','))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        (Cited item) familyName mismatch with creatorName.
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:publicationYear" priority="1000" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='Cites']/d:publicationYear"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        (Cited item) publicationYear must be a 4-digit year or ':unav'; got '<axsl:text/><axsl:value-of select="."/><axsl:text/>'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16"/></axsl:template><axsl:template match="text()" priority="-1" mode="M16"/><axsl:template match="@*|node()" priority="-2" mode="M16"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M16"/></axsl:template>

<!--PATTERN p_relatedItems_isPublishedInrelatedItems: IsPublishedIn → Book (container)-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron">relatedItems: IsPublishedIn → Book (container)</svrl:text>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']" priority="1003" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="@relatedItemType='Book'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="@relatedItemType='Book'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>relatedItemType must be 'Book' for container.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:titles/d:title"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:titles/d:title"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Container titles/title is required.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="d:publicationYear"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:publicationYear"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>Container publicationYear is required.</svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']/d:relatedItemIdentifier[@relatedItemIdentifierType='ISSN']" priority="1002" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']/d:relatedItemIdentifier[@relatedItemIdentifierType='ISSN']"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(normalize-space(.))=9 and substring(.,5,1)='-'"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="string-length(normalize-space(.))=9 and substring(.,5,1)='-'"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ISSN should be 9 chars with a hyphen at position 5 (e.g., 1234-567X).
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(translate(concat(substring(.,1,4), substring(.,6,3)),'0123456789',''))=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="string-length(translate(concat(substring(.,1,4), substring(.,6,3)),'0123456789',''))=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ISSN first 4 and next 3 positions must be digits.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose>

		<!--ASSERT -->
<axsl:choose><axsl:when test="string-length(translate(substring(.,9,1),'0123456789X',''))=0"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="string-length(translate(substring(.,9,1),'0123456789X',''))=0"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        ISSN check digit must be 0–9 or 'X'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']" priority="1001" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']"/>

		<!--REPORT -->
<axsl:if test="d:firstPage and d:lastPage                         and number(d:firstPage)=number(d:firstPage)                         and number(d:lastPage)=number(d:lastPage)                         and number(d:lastPage) &lt; number(d:firstPage)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="d:firstPage and d:lastPage and number(d:firstPage)=number(d:firstPage) and number(d:lastPage)=number(d:lastPage) and number(d:lastPage) &lt; number(d:firstPage)"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Container lastPage (<axsl:text/><axsl:value-of select="d:lastPage"/><axsl:text/>) is less than firstPage (<axsl:text/><axsl:value-of select="d:firstPage"/><axsl:text/>).
      </svrl:text></svrl:successful-report></axsl:if><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17"/></axsl:template>

	<!--RULE -->
<axsl:template match="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']/d:publicationYear" priority="1000" mode="M17"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="/d:resource/d:relatedItems/d:relatedItem[@relationType='IsPublishedIn']/d:publicationYear"/>

		<!--ASSERT -->
<axsl:choose><axsl:when test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"/><axsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:schold="http://www.ascc.net/xml/schematron" test="normalize-space(.)=':unav' or (string-length(normalize-space(.))=4 and number(.)=number(.))"><axsl:attribute name="location"><axsl:apply-templates select="." mode="schematron-get-full-path"/></axsl:attribute><svrl:text>
        Container publicationYear must be a 4-digit year or ':unav'; got '<axsl:text/><axsl:value-of select="."/><axsl:text/>'.
      </svrl:text></svrl:failed-assert></axsl:otherwise></axsl:choose><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17"/></axsl:template><axsl:template match="text()" priority="-1" mode="M17"/><axsl:template match="@*|node()" priority="-2" mode="M17"><axsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M17"/></axsl:template></axsl:stylesheet>
