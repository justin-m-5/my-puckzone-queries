-- name: get_team_stats_for_game
-- params: $1 = game id
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
WHERE gts.game_id = $1
ORDER BY gts.is_home DESC;
