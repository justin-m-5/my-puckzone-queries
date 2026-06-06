-- name: get_recent_completed_games
-- params: $1 = max rows to return
-- A game is treated as completed once both scores are populated.
SELECT
  g.id,
  g.date,
  g.home_team_id,
  g.home_score,
  g.away_team_id,
  g.away_score,
  g.last_period_type,
  g.game_state
FROM public.games AS g
WHERE g.home_score IS NOT NULL
  AND g.away_score IS NOT NULL
ORDER BY g.date DESC, g.start_time_utc DESC
LIMIT $1;
