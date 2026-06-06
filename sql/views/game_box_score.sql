-- object: public.v_game_box_score
-- purpose: One row per game with home/away team joins centralized.
CREATE OR REPLACE VIEW public.v_game_box_score WITH (security_invoker = true) AS
SELECT
  g.id AS game_id,
  g.season,
  g.game_type,
  g.date,
  g.start_time_utc,
  g.game_state,
  g.last_period_type,
  g.ot_in_use,
  g.shootout_in_use,
  g.home_team_id,
  home_team.abbrev AS home_abbrev,
  home_team.name AS home_name,
  g.home_score,
  g.home_sog,
  g.away_team_id,
  away_team.abbrev AS away_abbrev,
  away_team.name AS away_name,
  g.away_score,
  g.away_sog
FROM public.games AS g
JOIN public.teams AS home_team ON home_team.id = g.home_team_id
JOIN public.teams AS away_team ON away_team.id = g.away_team_id;
