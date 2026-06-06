-- name: list_games_by_date
-- params: $1 = calendar date (YYYY-MM-DD)
SELECT
  g.id,
  g.season,
  g.game_type,
  g.date,
  g.start_time_utc,
  g.home_team_id,
  home_team.abbrev AS home_abbrev,
  g.home_score,
  g.away_team_id,
  away_team.abbrev AS away_abbrev,
  g.away_score,
  g.game_state
FROM public.games AS g
JOIN public.teams AS home_team ON home_team.id = g.home_team_id
JOIN public.teams AS away_team ON away_team.id = g.away_team_id
WHERE g.date = $1
ORDER BY g.start_time_utc ASC;
