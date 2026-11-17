-- mcp_db_demo_user.sql: the role the hotel demo belongs to. Run it once, as a superuser
-- or a role with CREATEROLE, in the database the demo goes into:
--
--   psql -h <host> -U postgres -d <database> -f db/mcp_db_demo_user.sql
--
-- It creates two login roles (change both passwords for anything but a demo):
--
-- * mcpdemo (password mcpdemo), which may create schemas in this database. The DDL
--   creates the demo's three schemas owned by it, so mcp_db_demo_drop.sql can remove
--   them again. The staff config connects as mcpdemo and sees every row.
-- * mcpdemo_customer (password mcpdemo_customer), which owns nothing. The customer
--   config connects as it, so the DDL's row-level security applies: it sees only the
--   rows of the customer its connection URL names, and none without one.

CREATE ROLE mcpdemo LOGIN PASSWORD 'mcpdemo';
CREATE ROLE mcpdemo_customer LOGIN PASSWORD 'mcpdemo_customer';

DO $$
BEGIN
    EXECUTE format('GRANT CREATE ON DATABASE %I TO mcpdemo', current_database());
END $$;

-- The SQL statements in the demo's configs name their tables unqualified, as Oracle
-- resolves them against MCPDEMO's own schema; this is the Postgres equivalent.
ALTER ROLE mcpdemo SET search_path = mcpdemo, public;
ALTER ROLE mcpdemo_customer SET search_path = mcpdemo, public;
