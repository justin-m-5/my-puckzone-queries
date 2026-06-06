# my-puckzone-supabase-queries

A dedicated SQL/DAL-style repository for **My PuckZone** Supabase schema, queries, and database routines.

## Suggested GitHub repository description

**SQL and DAL repository for My PuckZone Supabase schema, migrations, and reusable queries used by the app and API services.**

## Why this repo exists

This keeps database concerns separate from your other projects:

- `/my-puckzone-app` (Vercel React app)
- `/my-puckzone-nhl-api` (NHL ingest/API logic)
- `/my-puckzone-supabase-queries` (schema + SQL query layer)

That separation helps you avoid app bloat and keeps SQL changes versioned in one place.

## Repository structure

```text
sql/
  schema/
    000_context_schema.sql
  queries/
    game_advanced_stats/
      get_advanced_stats_for_game.sql
    game_goalie_advanced_stats/
      get_goalie_advanced_stats_for_game.sql
    game_goalie_stats/
      get_goalie_stats_for_game.sql
    game_plays/
      get_shots_for_game.sql
      list_goals_for_game.sql
      list_plays_for_game.sql
    game_shifts/
      list_shifts_for_game.sql
    game_skater_advanced_stats/
      get_skater_advanced_stats_for_game.sql
    game_skater_stats/
      get_player_game_log.sql
      get_skater_stats_for_game.sql
    game_team_stats/
      get_team_stats_for_game.sql
    games/
      get_game_by_id.sql
      get_recent_completed_games.sql
      list_games_by_date.sql
      list_games_for_team.sql
    invites/
      get_invite_by_code.sql
      list_invites_by_creator.sql
      redeem_invite.sql
    players/
      get_player_by_id.sql
      search_players_by_name.sql
    playoff_series/
      list_series_by_year.sql
    power_ranking_history/
      list_history_for_user_season.sql
    power_rankings/
      get_power_ranking.sql
      list_power_rankings_for_season.sql
    profiles/
      get_profile_by_id.sql
      get_profile_with_referrer.sql
      list_profiles.sql
      update_last_seen.sql
    team_standings/
      get_latest_standings.sql
      get_team_standing_history.sql
    teams/
      get_team_by_id.sql
      list_teams.sql
  views/
    game_box_score.sql
    player_season_totals.sql
    skater_leaderboard.sql
    team_season_summary.sql
  functions/
    get_game_overview.sql
```

## How this repo maps to Supabase

- `sql/queries/**` are runtime SQL strings the app sends to the database (with `$1`, `$2`, ... params). These are loaded/read by the app at request time and do not need to be installed in advance.
- `sql/views/**` and `sql/functions/**` are database DDL objects. These must be applied to your Supabase database once before the app can reference them.
- This repository is the source of truth; your live Supabase database does not auto-sync from these files.

Three ways to apply DDL files (pick one):

1. Supabase Studio → SQL Editor → paste a file's SQL → **Run**.
2. CLI: `supabase db query --file sql/views/game_box_score.sql`
3. Migrations (recommended long-term): copy DDL into `supabase/migrations/<timestamp>_<name>.sql` and run `supabase db push`.

Apply order notes:

- Apply `player_season_totals` before `skater_leaderboard`.
- Apply all views before `get_game_overview`.

Views in this repo use `WITH (security_invoker = true)` (Postgres 15+, Supabase default), so existing RLS policies still apply through the view.

Guidance: don't copy the same multi-table join into many query files. Add it once as a reusable view, then keep runtime query files focused on filtering. Example: `public.v_game_box_score` replaces repeating the home/away `teams` join pattern used in `list_games_by_date.sql`.

## Getting started

```bash
git clone git@github.com:justin-m-5/my-puckzone-supabase-queries.git
cd my-puckzone-supabase-queries
```

Optional Supabase CLI flow:

```bash
# Link to your Supabase project
supabase link --project-ref <your-project-ref>

# Run a query file against the linked project (example)
supabase db query --file sql/queries/profiles/get_profile_by_id.sql
```

## Notes on schema file

`sql/schema/000_context_schema.sql` contains your provided schema context as a reference snapshot.
