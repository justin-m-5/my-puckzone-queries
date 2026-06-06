-- name: list_teams
SELECT
  t.id,
  t.name,
  t.abbrev,
  t.place,
  t.logo,
  t.primary_color,
  t.secondary_color
FROM public.teams AS t
ORDER BY t.name ASC;
