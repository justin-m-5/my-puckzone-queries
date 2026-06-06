-- object: public.v_player_season_totals
-- purpose: One row per player-season with aggregated skater counting stats.
-- Note: toi is intentionally omitted because it is stored as text and cannot be summed directly.
CREATE OR REPLACE VIEW public.v_player_season_totals WITH (security_invoker = true) AS
SELECT
  gss.player_id,
  g.season,
  pl.first_name,
  pl.last_name,
  COUNT(*) AS games_played,
  SUM(gss.goals) AS goals,
  SUM(gss.assists) AS assists,
  SUM(gss.points) AS points,
  SUM(gss.plus_minus) AS plus_minus,
  SUM(gss.pim) AS pim,
  SUM(gss.hits) AS hits,
  SUM(gss.sog) AS sog,
  SUM(gss.blocked_shots) AS blocked_shots,
  SUM(gss.power_play_goals) AS power_play_goals
FROM public.game_skater_stats AS gss
JOIN public.games AS g ON g.id = gss.game_id
JOIN public.players AS pl ON pl.id = gss.player_id
GROUP BY gss.player_id, g.season, pl.first_name, pl.last_name;
