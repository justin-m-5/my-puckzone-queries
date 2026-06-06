-- name: list_series_by_year
-- params: $1 = bracket year
SELECT
  ps.id,
  ps.bracket_year,
  ps.round_number,
  ps.series_letter,
  ps.series_title,
  ps.series_abbrev,
  ps.top_seed_team_id,
  ps.top_seed_abbrev,
  ps.top_seed_rank,
  ps.top_seed_wins,
  ps.bottom_seed_team_id,
  ps.bottom_seed_abbrev,
  ps.bottom_seed_rank,
  ps.bottom_seed_wins,
  ps.winning_team_id,
  ps.losing_team_id,
  ps.series_url,
  ps.series_logo
FROM public.playoff_series AS ps
WHERE ps.bracket_year = $1
ORDER BY ps.round_number ASC, ps.series_letter ASC;
