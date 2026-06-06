-- name: get_latest_standings
-- params: $1 = season id, $2 = game_type id
-- Returns the most recent standings snapshot per team for a season.
-- Rows come back one-per-team ordered by team_id; sort downstream as needed.
SELECT DISTINCT ON (ts.team_id)
  ts.team_id,
  t.abbrev,
  t.name,
  ts.as_of_date,
  ts.conference_name,
  ts.division_name,
  ts.games_played,
  ts.wins,
  ts.losses,
  ts.ot_losses,
  ts.points,
  ts.point_pctg,
  ts.goal_differential,
  ts.league_sequence,
  ts.conference_sequence,
  ts.division_sequence,
  ts.wildcard_sequence,
  ts.streak_code,
  ts.streak_count
FROM public.team_standings AS ts
JOIN public.teams AS t ON t.id = ts.team_id
WHERE ts.season_id = $1
  AND ts.game_type_id = $2
ORDER BY ts.team_id, ts.as_of_date DESC;
