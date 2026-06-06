-- name: get_shots_for_game
-- params: $1 = game id
-- Note: x_coord/y_coord are NHL rink coordinates intended for shot chart plotting.
SELECT
  gp.type_desc_key,
  gp.event_owner_team_id,
  gp.shooting_player_id,
  gp.shot_type,
  gp.x_coord,
  gp.y_coord,
  gp.zone_code,
  gp.period,
  gp.time_in_period
FROM public.game_plays AS gp
WHERE gp.game_id = $1
  AND gp.type_desc_key IN ('goal', 'shot-on-goal', 'missed-shot', 'blocked-shot')
ORDER BY gp.sort_order ASC;
