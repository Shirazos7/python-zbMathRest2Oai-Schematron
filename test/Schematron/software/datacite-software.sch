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