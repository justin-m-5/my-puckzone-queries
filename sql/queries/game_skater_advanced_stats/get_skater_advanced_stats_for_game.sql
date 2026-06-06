-- name: get_skater_advanced_stats_for_game
-- params: $1 = game id
SELECT
  gsas.player_id,
  pl.first_name,
  pl.last_name,
  gsas.team_id,
  gsas.icf,
  gsas.iff,
  gsas.ixg,
  gsas.cf_pct,
  gsas.xgf_pct,
  gsas.gf_pct,
  gsas.cf_pct_rel,
  gsas.xgf_pct_rel,
  gsas.ozs_pct,
  gsas.toi_seconds
FROM public.game_skater_advanced_stats AS gsas
JOIN public.players AS pl ON pl.id = gsas.player_id
WHERE gsas.game_id = $1
ORDER BY gsas.ixg DESC NULLS LAST;
