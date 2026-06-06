-- name: get_player_by_id
-- params: $1 = player id
SELECT
  pl.id,
  pl.first_name,
  pl.last_name,
  pl.position,
  pl.shoots_catches,
  pl.birth_date,
  pl.birth_country,
  pl.height_in_cm,
  pl.weight_in_kg,
  pl.draft_year,
  pl.draft_round,
  pl.draft_overall_pick,
  pl.draft_team_abbrev
FROM public.players AS pl
WHERE pl.id = $1
LIMIT 1;
