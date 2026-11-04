-- mcp_db_demo_user.sql: the role the hotel demo belongs to. Run it once, as a superuser
-- or a role with CREATEROLE, in the database the demo goes into:
--
--   psql -h <host> -U postgres -d <database> -f db/mcp_db_demo_user.sql
--
-- It creates a login role mcpdemo (password mcpdemo: change it for anything but a demo)
-- and lets it create schemas in this database. The DDL then creates the demo's three
-- schemas, owned by mcpdemo, so mcp_db_demo_drop.sql can remove them again.

CREATE ROLE mcpdemo LOGIN PASSWORD 'mcpdemo';

DO $$
BEGIN
    EXECUTE format('GRANT CREATE ON DATABASE %I TO mcpdemo', current_database());
END $$;

-- The SQL statements in the demo's configs name their tables unqualified, as Oracle
-- resolves them against MCPDEMO's own schema; this is the Postgres equivalent.
ALTER ROLE mcpdemo SET search_path = mcpdemo, public;
