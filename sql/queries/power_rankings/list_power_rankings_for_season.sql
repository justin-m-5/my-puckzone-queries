-- name: list_power_rankings_for_season
-- params: $1 = season
SELECT
  pr.id,
  pr.user_id,
  prof.display_name,
  pr.season,
  pr."order",
  pr.submitted_at,
  pr.updated_at
FROM public.power_rankings AS pr
JOIN public.profiles AS prof ON prof.id = pr.user_id
WHERE pr.season = $1
ORDER BY pr.updated_at DESC;
