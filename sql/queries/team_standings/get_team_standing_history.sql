-- name: get_team_standing_history
-- params: $1 = team id, $2 = season id
SELECT
  ts.as_of_date,
  ts.games_played,
  ts.wins,
  ts.losses,
  ts.ot_losses,
  ts.points,
  ts.point_pctg,
  ts.goal_differential,
  ts.league_sequence,
  ts.division_sequence
FROM public.team_standings AS ts
WHERE ts.team_id = $1
  AND ts.season_id = $2
ORDER BY ts.as_of_date ASC;
