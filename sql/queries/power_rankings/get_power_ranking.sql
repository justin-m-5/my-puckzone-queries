-- name: get_power_ranking
-- params: $1 = user UUID, $2 = season
-- Note: "order" is a reserved keyword and must stay quoted.
SELECT
  pr.id,
  pr.user_id,
  pr.season,
  pr."order",
  pr.submitted_at,
  pr.updated_at
FROM public.power_rankings AS pr
WHERE pr.user_id = $1
  AND pr.season = $2
LIMIT 1;
