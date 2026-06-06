-- object: public.v_skater_leaderboard
-- purpose: Ranked skater leaderboard by season built from v_player_season_totals.
-- Note: Depends on public.v_player_season_totals; apply that view first.
CREATE OR REPLACE VIEW public.v_skater_leaderboard WITH (security_invoker = true) AS
SELECT
  pst.player_id,
  pst.season,
  pst.first_name,
  pst.last_name,
  pst.games_played,
  pst.goals,
  pst.assists,
  pst.points,
  pst.plus_minus,
  pst.pim,
  pst.hits,
  pst.sog,
  pst.blocked_shots,
  pst.power_play_goals,
  RANK() OVER (
    PARTITION BY pst.season
    ORDER BY pst.points DESC, pst.goals DESC
  ) AS points_rank
FROM public.v_player_season_totals AS pst
ORDER BY pst.season, points_rank;
