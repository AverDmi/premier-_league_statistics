{#
    This macro returns the description of results fields 
#}

{% macro get_result_description_FTR(FTR) -%}

    case {{ FTR }}
        when 'H' then 'Home Win'
        when 'D' then 'Draw'
        when 'A' then 'Away Win'
    end

{%- endmacro %}
