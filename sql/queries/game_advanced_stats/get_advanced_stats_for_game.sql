-- name: get_advanced_stats_for_game
-- params: $1 = game id
SELECT
  gas.team_id,
  t.abbrev,
  gas.cf,
  gas.ca,
  gas.cf_pct,
  gas.xgf,
  gas.xga,
  gas.xgf_pct,
  gas.hdcf,
  gas.hdca,
  gas.hdcf_pct,
  gas.scf,
  gas.sca,
  gas.scf_pct,
  gas.pdo,
  gas.cf_pct_5v5,
  gas.xgf_pct_5v5,
  gas.hdcf_pct_5v5
FROM public.game_advanced_stats AS gas
JOIN public.teams AS t ON t.id = gas.team_id
WHERE gas.game_id = $1
ORDER BY gas.team_id ASC;
