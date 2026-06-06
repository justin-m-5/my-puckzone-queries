-- name: get_game_by_id
-- params: $1 = game id
SELECT
  g.id,
  g.season,
  g.game_type,
  g.date,
  g.start_time_utc,
  g.home_team_id,
  g.away_team_id,
  g.home_score,
  g.away_score,
  g.home_sog,
  g.away_sog,
  g.game_state,
  g.venue,
  g.last_period_type,
  g.reg_periods,
  g.ot_periods,
  g.ot_in_use,
  g.shootout_in_use,
  g.star1_player_id,
  g.star2_player_id,
  g.star3_player_id
FROM public.games AS g
WHERE g.id = $1
LIMIT 1;
