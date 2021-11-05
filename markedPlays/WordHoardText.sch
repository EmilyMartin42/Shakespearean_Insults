<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="insultStart/@insType">
            <sch:let name="allTypes" value="'nameCall', 'pAttack', 'sexGen', 'backComp', 'slander'"/>
            <sch:let name="myTypes" value="tokenize(.)"/>
            <sch:let name="illegalValues" value="$myTypes[not(. = $allTypes)]"/>
            <sch:assert test="empty($illegalValues)">"<sch:value-of select="$illegalValues"/>" not
                permitted.</sch:assert>
            <sch:report
                test="empty($illegalValues) and not(deep-equal($allTypes[. = $myTypes], $myTypes))"
                >The values "<sch:value-of select="$myTypes"/>" are legal but not in the correct
                order.</sch:report>
            <sch:assert test="count($myTypes) eq count(distinct-values($myTypes))">@type
                values cannot repeat</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>
