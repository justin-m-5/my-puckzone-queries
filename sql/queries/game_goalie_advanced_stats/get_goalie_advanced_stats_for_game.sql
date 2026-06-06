-- name: get_goalie_advanced_stats_for_game
-- params: $1 = game id
SELECT
  ggas.player_id,
  pl.first_name,
  pl.last_name,
  ggas.team_id,
  ggas.shots_faced,
  ggas.xga,
  ggas.goals_against,
  ggas.gsax,
  ggas.xga_5v5,
  ggas.gsax_5v5,
  ggas.save_pct_above_exp,
  ggas.rebounds_given,
  ggas.freeze_pct
FROM public.game_goalie_advanced_stats AS ggas
JOIN public.players AS pl ON pl.id = ggas.player_id
WHERE ggas.game_id = $1
ORDER BY ggas.gsax DESC NULLS LAST;
