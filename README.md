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
```

## How this repo maps to Supabase

- This repo (`my-puckzone-queries`) contains runtime query files in `sql/queries/**` and the schema context snapshot in `sql/schema/000_context_schema.sql`.
- `sql/queries/**` are SQL strings the app sends at request time (with `$1`, `$2`, ... params). They are not database objects and do not need to be installed.
- Database DDL objects (reusable views + functions/RPCs) now live in the companion repo [`justin-m-5/my-puckzone-db-migration`](https://github.com/justin-m-5/my-puckzone-db-migration), which is the source of truth for objects applied to Supabase (for example: `v_game_box_score`, `v_player_season_totals`, `v_team_season_summary`, `v_skater_leaderboard`, and `get_game_overview`).
- The app still references those database objects by name at runtime, and query files in this repo may filter views defined in the migration repo.

Guidance: don't copy the same multi-table join into many query files. Add it once as a reusable view in `my-puckzone-db-migration`, then keep runtime query files focused on filtering.

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
