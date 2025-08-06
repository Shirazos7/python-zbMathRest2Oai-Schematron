<schema xmlns="http://purl.oclc.org/dsdl/schematron"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        queryBinding="xslt2">
<pattern id="swmath-identifier-validation">
        <title>Validation of swMATH identifier</title>

        <rule context="identifier[@identifierType='swMATH']">

            <!-- 1. Identifier value must not be empty -->
            <assert test="normalize-space(.) != ''">
                swMATH identifier must have a non-empty value
            </assert>

            <!-- 2. Identifier value should be numeric (optional) -->
            <assert test="matches(., '^\d+$')">
                swMATH identifier should be numeric
            </assert>

        </rule>

         </pattern>

          <pattern id="zbmath-url-to-swmath">
    <title>Validation of transformed zbmath_url as alternateIdentifier</title>

    <rule context="alternateIdentifier[@alternateIdentifierType='URL']">

        <!-- Must not be empty -->
        <assert test="normalize-space(.) != ''">
            alternateIdentifier must not be empty
        </assert>

        <!-- Must start with swmath.org -->
        <assert test="starts-with(normalize-space(.), 'https://swmath.org')">
            alternateIdentifier must start with 'https://swmath.org'
        </assert>

        <!-- Should not still include zbmath.org -->
        <assert test="not(contains(., 'zbmath.org'))">
            alternateIdentifier must not contain 'zbmath.org' (it should be transformed)
        </assert>

    </rule>
</pattern>


<pattern id="creator-from-authors-validation">
        <title>Validation of creator elements transformed from authors</title>

        <!-- Apply rule to every creator element -->
        <rule context="creator">

            <!-- 1. creatorName must exist and have the correct attribute -->
            <assert test="creatorName[@nameType='Personal']">
                creator must contain creatorName with nameType="Personal"
            </assert>

            <!-- 2. All values must be present and not empty -->
            <assert test="normalize-space(creatorName) != ''">
                creatorName must not be empty (use ':unav' if unavailable)
            </assert>
            <assert test="normalize-space(givenName) != ''">
                givenName must not be empty (use ':unav' if unavailable)
            </assert>
            <assert test="normalize-space(familyName) != ''">
                familyName must not be empty (use ':unav' if unavailable)
            </assert>

            <!-- 3. If any one field is ':unav', then all must be ':unav' -->
            <assert test="not(creatorName = ':unav' or givenName = ':unav' or familyName = ':unav')
                          or (creatorName = ':unav' and givenName = ':unav' and familyName = ':unav')">
                If any of creatorName, givenName, or familyName is ':unav', then all three must be ':unav'
            </assert>

            <!-- 4. If not :unav, creatorName should include comma separating surname and given name -->
            <assert test="creatorName = ':unav' or contains(creatorName, ',')">
                creatorName should contain a comma separating surname and given name unless it is ':unav'
            </assert>

        </rule>
    </pattern>

     <pattern id="title-validation">
        <title>Validation of title element transformed from name</title>

        <rule context="title">

            <!-- 1. Title must not be empty -->
            <assert test="normalize-space(.) != ''">
                title must not be empty (use ':unav' if unavailable)
            </assert>

            <!-- 2. Title must be either ':unav' or a real, non-placeholder value -->
            <assert test=". = ':unav' or not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))">
                title must be ':unav' if original content was unavailable
            </assert>

        </rule>
    </pattern>

    <pattern id="descriptions-validation">
    <title>Validation of all descriptions: Abstract + TechnicalInfo</title>


    <rule context="description[@descriptionType='Abstract' and @xml:lang='en']">

        <!-- Abstract description must not be empty -->
        <assert test="normalize-space(.) != ''">
            Abstract description must not be empty (use ':unav' if unavailable)
        </assert>

        <!-- Must be either real text or exactly ':unav' -->
        <assert test=". = ':unav' or not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))">
            Abstract must be ':unav' if original content was unavailable
        </assert>
    </rule>


    <rule context="description[@descriptionType='TechnicalInfo'
                               and @xml:lang='en'
                               and starts-with(normalize-space(.),
                                               'operating systems:')]">

        <assert test="normalize-space(substring-after(., ':')) != ''">
            operating systems description must list at least one OS after the “operating systems:” prefix
        </assert>
    </rule>


    <rule context="description[@descriptionType='TechnicalInfo'
                               and @xml:lang='en'
                               and starts-with(normalize-space(.),
                                               'programming languages :')]">

        <assert test="normalize-space(substring-after(., ':')) != ''">
            programming languages description must list at least one language after the “programming languages :” prefix
        </assert>
    </rule>


    <rule context="description[@descriptionType='TechnicalInfo' and @xml:lang='en']">

        <assert test="normalize-space(.) != ''">
            TechnicalInfo description must not be empty
        </assert>

        <assert test=". != ':unav'">
            The TechnicalInfo templates never produce ':unav'; its presence indicates an error
        </assert>
    </rule>
</pattern>

<pattern id="publication-year-full-validation">
    <title>Validation of publicationYear based on all fallback sources</title>

    <rule context="publicationYear">

        <!-- 1. Must not be empty -->
        <assert test="normalize-space(.) != ''">
            publicationYear must not be empty (use ':unav' if unavailable)
        </assert>

        <!-- 2. Must be :unav or a valid, clean year -->
        <assert test=". = ':unav'
                      or (
                          . != 'None'
                          and . != 'none'
                          and not(starts-with(., '0'))
                          and not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))
                      )">
            publicationYear must be a valid year or ':unav'
        </assert>

        <!-- 3. Must match 4-digit year format if not :unav -->
        <assert test=". = ':unav' or matches(., '^(19|20)\d{2}$')">
            publicationYear must be a 4-digit year between 1900–2099, or ':unav'
        </assert>

    </rule>
</pattern>

<pattern id="subjects-validation">
    <title>Validation of subject elements (msc2020 and keyword)</title>

    <!-- Rule applies to each <subject> inside <subjects> -->
    <rule context="subject">

        <!-- subjectScheme must exist -->
        <assert test="@subjectScheme">
            Each subject must have a subjectScheme attribute
        </assert>

        <!-- subjectScheme must be either 'msc2020' or 'keyword' -->
        <assert test="@subjectScheme = 'msc2020' or @subjectScheme = 'keyword'">
            subjectScheme must be either 'msc2020' (for classification) or 'keyword'
        </assert>

        <!-- Subject text must not be empty -->
        <assert test="normalize-space(.) != ''">
            subject must not be empty (must contain a valid value)
        </assert>

        <!-- Subject must not contain placeholders -->
        <assert test=". != 'None' and . != 'none' and not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))">
            subject must not be 'None', 'none', or contain the zbMATH unavailable notice
        </assert>

    </rule>

    <!-- Optional: check <subjects> container has at least one subject -->
    <rule context="subjects">
        <assert test="subject">
            subjects must contain at least one subject element
        </assert>
    </rule>
</pattern>

<pattern id="rights-validation">
    <title>Validation of rights element generated from license_terms</title>

    <rule context="rights">

        <!-- Must not be empty -->
        <assert test="normalize-space(.) != ''">
            rights must not be empty (it should not be generated for empty or placeholder values)
        </assert>

        <!-- Must not contain placeholder values -->
        <assert test=". != 'None' and . != 'none' and not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))">
            rights must not contain placeholder values like 'None', 'none', or the zbMATH disclaimer
        </assert>

    </rule>

</pattern>

<pattern id="publisher-validation">
    <title>Validation of publisher element derived from source_code and homepage</title>

    <rule context="publisher">

        <!-- 1. Publisher must not be empty -->
        <assert test="normalize-space(.) != ''">
            publisher must not be empty (use ':unav' if unavailable)
        </assert>

        <!-- 2. Publisher must be either ':unav' or a valid value -->
        <assert test=". = ':unav'
                      or (
                          . != 'none'
                          and . != 'null'
                          and not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))
                      )">
            publisher must be a valid value or ':unav' — not 'none', 'null', or zbMATH disclaimer
        </assert>

        <!-- 3. If not :unav, must look like a URL -->
        <assert test=". = ':unav' or matches(normalize-space(.), '^https?://')">
            If publisher is not ':unav', it must be a URL starting with http:// or https://
        </assert>

    </rule>
</pattern>

<pattern id="static-values-validation">
    <title>Validation of hardcoded/generated elements</title>

    <!-- 1. language -->
    <rule context="language">
        <assert test=". = 'English'">
            language must be 'English'
        </assert>
    </rule>

    <!-- 2. resourceType -->
    <rule context="resourceType">
        <assert test="@resourceTypeGeneral = 'Software'">
            resourceTypeGeneral must be 'Software'
        </assert>
        <assert test=". = ':none'">
            resourceType text must be ':none' (if default value is used)
        </assert>
    </rule>

    <!-- 3. format inside formats -->
    <rule context="formats">
        <assert test="format = 'application/xml'">
            formats must contain format 'application/xml'
        </assert>
    </rule>
</pattern>

<pattern id="related-identifiers-validation">
    <title>RelatedIdentifier rules for URL / DOI / arXiv sources</title>

    <rule context="relatedIdentifier">

        <!-- 1. @relatedIdentifierType must be one of the three allowed values -->
        <assert test="@relatedIdentifierType = ('URL', 'DOI', 'ARXIV', 'arXiv')">
            relatedIdentifierType must be URL, DOI, or ARXIV
        </assert>

        <!-- 2. @relationType must be either IsSourceOf or IsCitedBy -->
        <assert test="@relationType = ('IsSourceOf', 'IsCitedBy')">
            relationType must be IsSourceOf or IsCitedBy
        </assert>

        <!-- 3. Element text must not be empty or placeholder -->
        <assert test="normalize-space(.) != ''">
            relatedIdentifier value must not be empty
        </assert>
        <assert test=". != 'None' and . != 'none' and
                      not(contains(., 'zbMATH Open Web Interface contents unavailable due to conflicting licenses'))">
            relatedIdentifier value must not contain placeholder values
        </assert>

        <!-- 4. Type-specific content and relationType checks -->
        <!-- ------------------------------------------------ -->

        <!-- URL coming from <homepage>  -->
        <assert test="not(@relatedIdentifierType='URL' and
                           not(starts-with(., 'https://api.zbmath.org/')) and
                           @relationType != 'IsSourceOf')">
            If relatedIdentifierType='URL' and it is *not* a zbMATH API link,
            relationType must be IsSourceOf
        </assert>

        <!-- URL coming from <references>  -->
        <assert test="not(@relatedIdentifierType='URL' and
                           starts-with(., 'https://api.zbmath.org/') and
                           @relationType != 'IsCitedBy')">
            zbMATH API URLs must have relationType='IsCitedBy'
        </assert>

        <!-- DOI -->
        <assert test="not(@relatedIdentifierType='DOI' and not(starts-with(., '10.')))">
            DOI identifiers must start with '10.'
        </assert>
        <assert test="not(@relatedIdentifierType='DOI' and @relationType != 'IsCitedBy')">
            DOI relatedIdentifier must have relationType='IsCitedBy'
        </assert>

        <!-- arXiv -->
        <assert test="not((@relatedIdentifierType='ARXIV' or @relatedIdentifierType='arXiv')
                           and not(matches(., '^\d{4}\.\d{4,5}$')))">
            arXiv identifiers must follow the modern pattern nnnn.nnnnn
            (four digits, dot, 4–5 digits)
        </assert>
        <assert test="not((@relatedIdentifierType='ARXIV' or @relatedIdentifierType='arXiv')
                           and @relationType != 'IsCitedBy')">
            arXiv relatedIdentifier must have relationType='IsCitedBy'
        </assert>

    </rule>

    <rule context="relatedIdentifiers">
        <assert test="relatedIdentifier">
            relatedIdentifiers must contain at least one relatedIdentifier element
        </assert>
    </rule>
</pattern>


</schema>