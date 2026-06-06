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

## Starter structure

```text
sql/
  schema/
    000_context_schema.sql
  queries/
    profiles/
      get_profile_by_id.sql
```

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
