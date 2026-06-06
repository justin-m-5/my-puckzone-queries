-- name: list_plays_for_game
-- params: $1 = game id
SELECT
  gp.event_id,
  gp.sort_order,
  gp.type_code,
  gp.type_desc_key,
  gp.period,
  gp.period_type,
  gp.time_in_period,
  gp.situation_code,
  gp.x_coord,
  gp.y_coord,
  gp.zone_code,
  gp.event_owner_team_id,
  gp.home_score,
  gp.away_score
FROM public.game_plays AS gp
WHERE gp.game_id = $1
ORDER BY gp.sort_order ASC;
