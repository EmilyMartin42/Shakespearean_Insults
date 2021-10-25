<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="insultStart/@type">
            <sch:let name="type-parts" value="tokenize(.)"/>
            <sch:assert test="count($type-parts) eq count(distinct-values($type-parts))">@type
                values cannot repeat</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
