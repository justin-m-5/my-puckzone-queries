-- object: public.v_team_season_summary
-- purpose: Per-team, per-season summary derived from completed game results.
-- Note: Derived from game results and independent of team_standings snapshots.
CREATE OR REPLACE VIEW public.v_team_season_summary WITH (security_invoker = true) AS
SELECT
  tr.team_id,
  t.abbrev,
  t.name,
  tr.season,
  COUNT(*) AS games_played,
  SUM(CASE WHEN tr.gf > tr.ga THEN 1 ELSE 0 END) AS wins,
  SUM(CASE WHEN tr.gf < tr.ga AND tr.last_period_type = 'REG' THEN 1 ELSE 0 END) AS losses,
  SUM(CASE WHEN tr.gf < tr.ga AND tr.last_period_type IN ('OT', 'SO') THEN 1 ELSE 0 END) AS ot_losses,
  SUM(tr.gf) AS goals_for,
  SUM(tr.ga) AS goals_against,
  SUM(tr.gf) - SUM(tr.ga) AS goal_differential,
  (2 * SUM(CASE WHEN tr.gf > tr.ga THEN 1 ELSE 0 END))
    + SUM(CASE WHEN tr.gf < tr.ga AND tr.last_period_type IN ('OT', 'SO') THEN 1 ELSE 0 END) AS points
FROM (
  SELECT
    g.home_team_id AS team_id,
    g.season,
    g.home_score AS gf,
    g.away_score AS ga,
    g.last_period_type
  FROM public.games AS g
  WHERE g.home_score IS NOT NULL
    AND g.away_score IS NOT NULL

  UNION ALL

  SELECT
    g.away_team_id AS team_id,
    g.season,
    g.away_score AS gf,
    g.home_score AS ga,
    g.last_period_type
  FROM public.games AS g
  WHERE g.home_score IS NOT NULL
    AND g.away_score IS NOT NULL
) AS tr
JOIN public.teams AS t ON t.id = tr.team_id
GROUP BY tr.team_id, t.abbrev, t.name, tr.season;
