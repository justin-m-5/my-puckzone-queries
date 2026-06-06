-- name: get_skater_stats_for_game
-- params: $1 = game id
SELECT
  gss.player_id,
  pl.first_name,
  pl.last_name,
  gss.team_id,
  gss.is_home,
  gss.position,
  gss.toi,
  gss.goals,
  gss.assists,
  gss.points,
  gss.plus_minus,
  gss.pim,
  gss.hits,
  gss.sog,
  gss.blocked_shots,
  gss.power_play_goals,
  gss.faceoff_winning_pctg,
  gss.giveaways,
  gss.takeaways,
  gss.shifts
FROM public.game_skater_stats AS gss
JOIN public.players AS pl ON pl.id = gss.player_id
WHERE gss.game_id = $1
ORDER BY gss.points DESC, gss.goals DESC;
