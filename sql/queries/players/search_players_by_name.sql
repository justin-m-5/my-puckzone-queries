-- name: search_players_by_name
-- params: $1 = case-insensitive name fragment (e.g. 'mcda')
SELECT
  pl.id,
  pl.first_name,
  pl.last_name,
  pl.position,
  pl.draft_year,
  pl.draft_team_abbrev
FROM public.players AS pl
WHERE (pl.first_name || ' ' || pl.last_name) ILIKE '%' || $1 || '%'
ORDER BY pl.last_name ASC, pl.first_name ASC
LIMIT 50;
