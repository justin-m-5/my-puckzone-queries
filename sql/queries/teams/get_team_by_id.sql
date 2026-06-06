-- name: get_team_by_id
-- params: $1 = team id
SELECT
  t.id,
  t.name,
  t.abbrev,
  t.place,
  t.logo,
  t.primary_color,
  t.secondary_color,
  t.created_at,
  t.updated_at
FROM public.teams AS t
WHERE t.id = $1
LIMIT 1;
