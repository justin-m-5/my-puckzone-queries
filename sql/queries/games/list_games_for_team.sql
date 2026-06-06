-- name: list_games_for_team
-- params: $1 = team id, $2 = season
SELECT
  g.id,
  g.date,
  g.start_time_utc,
  g.home_team_id,
  g.away_team_id,
  g.home_score,
  g.away_score,
  g.game_state,
  CASE WHEN g.home_team_id = $1 THEN 'home' ELSE 'away' END AS side
FROM public.games AS g
WHERE g.season = $2
  AND (g.home_team_id = $1 OR g.away_team_id = $1)
ORDER BY g.date ASC;
