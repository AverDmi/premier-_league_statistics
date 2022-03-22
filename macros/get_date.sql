{#
    This macro returns the normal date for column Date
#}

{% macro get_date(Date) -%}

    case {{ Date }}
        when length(Date) = 8 then PARSE_DATE('%d/%m/%y', Date)
        when length(Date) = 10 then PARSE_DATE('%d/%m/%Y', Date)
    end

{%- endmacro %}