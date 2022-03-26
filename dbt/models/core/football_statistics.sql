{{ config(materialized='table') }}

select
    {{ get_date(Date) }} as match_date,
    cast(Time as TIME FORMAT 'HH24:MI') as match_time,
    HomeTeam,
    AwayTeam,
    FTHG,
    FTAG,
    {{ get_result_description_FTR('FTR') }} as FTR,
    HTHG,
    HTAG,
    {{ get_result_description_HTR('HTR') }} as HTR,
    Referee,
    HS,
    premier_league_statistics.AS,
    HST,
    AST,
    HF,
    AF,
    HC,
    AC,
    HY,
    AY,
    HR,
    AR
from {{ source('staging', 'premier_league_statistics') }}
where FTHG is not Null
