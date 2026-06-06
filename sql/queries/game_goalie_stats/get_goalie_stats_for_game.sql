-- name: get_goalie_stats_for_game
-- params: $1 = game id
SELECT
  ggs.player_id,
  pl.first_name,
  pl.last_name,
  ggs.team_id,
  ggs.is_home,
  ggs.starter,
  ggs.decision,
  ggs.toi,
  ggs.shots_against,
  ggs.saves,
  ggs.goals_against,
  ggs.save_pctg
FROM public.game_goalie_stats AS ggs
JOIN public.players AS pl ON pl.id = ggs.player_id
WHERE ggs.game_id = $1
ORDER BY ggs.is_home DESC, ggs.starter DESC NULLS LAST;
