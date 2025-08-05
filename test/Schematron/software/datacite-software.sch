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