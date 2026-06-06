-- name: list_history_for_user_season
-- params: $1 = user UUID, $2 = season
-- Note: "order" is a reserved keyword and must stay quoted.
SELECT
  prh.id,
  prh.user_id,
  prh.season,
  prh."order",
  prh.created_at
FROM public.power_ranking_history AS prh
WHERE prh.user_id = $1
  AND prh.season = $2
ORDER BY prh.created_at DESC;
