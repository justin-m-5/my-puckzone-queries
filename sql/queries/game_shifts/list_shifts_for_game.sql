-- name: list_shifts_for_game
-- params: $1 = game id
SELECT
  gs.player_id,
  pl.first_name,
  pl.last_name,
  gs.team_id,
  t.abbrev,
  gs.period,
  gs.shift_number,
  gs.start_time,
  gs.end_time,
  gs.duration
FROM public.game_shifts AS gs
JOIN public.players AS pl ON pl.id = gs.player_id
JOIN public.teams AS t ON t.id = gs.team_id
WHERE gs.game_id = $1
ORDER BY gs.period ASC, gs.start_time ASC;
