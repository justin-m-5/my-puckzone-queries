-- object: public.get_game_overview(p_game_id integer)
-- purpose: Returns a hydrated game payload in one RPC round-trip.
-- usage: supabase.rpc('get_game_overview', { p_game_id: 123 })
-- Note: Depends on public.v_game_box_score; apply views before this function.
CREATE OR REPLACE FUNCTION public.get_game_overview(p_game_id integer)
RETURNS jsonb
LANGUAGE sql
STABLE
SET search_path = public
AS $$
SELECT jsonb_build_object(
  'game',
  (
    SELECT to_jsonb(vgbs)
    FROM public.v_game_box_score AS vgbs
    WHERE vgbs.game_id = p_game_id
    LIMIT 1
  ),
  'team_stats',
  (
    SELECT COALESCE(jsonb_agg(to_jsonb(ts_row) ORDER BY ts_row.is_home DESC), '[]'::jsonb)
    FROM (
      SELECT
        gts.team_id,
        t.abbrev,
        gts.is_home,
        gts.sog,
        gts.hits,
        gts.blocked_shots,
        gts.pim,
        gts.giveaways,
        gts.takeaways,
        gts.pp_pctg,
        gts.pk_pctg,
        gts.faceoff_winning_pctg
      FROM public.game_team_stats AS gts
      JOIN public.teams AS t ON t.id = gts.team_id
      WHERE gts.game_id = p_game_id
      ORDER BY gts.is_home DESC
    ) AS ts_row
  ),
  'skaters',
  (
    SELECT COALESCE(jsonb_agg(to_jsonb(sk_row) ORDER BY sk_row.points DESC), '[]'::jsonb)
    FROM (
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
      WHERE gss.game_id = p_game_id
      ORDER BY gss.points DESC, gss.goals DESC
    ) AS sk_row
  ),
  'goalies',
  (
    SELECT COALESCE(jsonb_agg(to_jsonb(gl_row) ORDER BY gl_row.is_home DESC, gl_row.starter DESC NULLS LAST), '[]'::jsonb)
    FROM (
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
      WHERE ggs.game_id = p_game_id
      ORDER BY ggs.is_home DESC, ggs.starter DESC NULLS LAST
    ) AS gl_row
  ),
  'scoring_plays',
  (
    SELECT COALESCE(jsonb_agg(to_jsonb(sp_row) ORDER BY sp_row.sort_order ASC), '[]'::jsonb)
    FROM (
      SELECT
        gp.event_id,
        gp.sort_order,
        gp.type_desc_key,
        gp.period,
        gp.time_in_period,
        gp.event_owner_team_id,
        gp.scoring_player_id,
        gp.goalie_in_net_id,
        gp.home_score,
        gp.away_score,
        gp.shot_type,
        gp.x_coord,
        gp.y_coord
      FROM public.game_plays AS gp
      WHERE gp.game_id = p_game_id
        AND gp.type_desc_key = 'goal'
      ORDER BY gp.sort_order ASC
    ) AS sp_row
  )
);
$$;
