-- name: get_player_game_log
-- params: $1 = player id, $2 = season
SELECT
  g.id AS game_id,
  g.date,
  gss.team_id,
  gss.is_home,
  gss.goals,
  gss.assists,
  gss.points,
  gss.plus_minus,
  gss.sog,
  gss.toi
FROM public.game_skater_stats AS gss
JOIN public.games AS g ON g.id = gss.game_id
WHERE gss.player_id = $1
  AND g.season = $2
ORDER BY g.date ASC;
