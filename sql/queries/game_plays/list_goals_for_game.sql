-- name: list_goals_for_game
-- params: $1 = game id
SELECT
  gp.event_id,
  gp.sort_order,
  gp.scoring_player_id,
  pl.first_name,
  pl.last_name,
  gp.goalie_in_net_id,
  gp.event_owner_team_id,
  gp.period,
  gp.time_in_period,
  gp.home_score,
  gp.away_score,
  gp.shot_type,
  gp.x_coord,
  gp.y_coord
FROM public.game_plays AS gp
LEFT JOIN public.players AS pl ON pl.id = gp.scoring_player_id
WHERE gp.game_id = $1
  AND gp.type_desc_key = 'goal'
ORDER BY gp.sort_order ASC;
