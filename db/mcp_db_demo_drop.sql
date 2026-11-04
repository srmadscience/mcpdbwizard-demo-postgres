-- mcp_db_demo_drop.sql: drops everything the DDL created, so the demo can be built
-- again. Run it as mcpdemo:
--
--   psql -h <host> -U mcpdemo -d <database> -f db/mcp_db_demo_drop.sql
--
-- The role itself is left alone. To remove that too, as a superuser:
--   DROP OWNED BY mcpdemo; DROP ROLE mcpdemo;

SET client_min_messages = warning;

DROP SCHEMA IF EXISTS mcpdemo_customer_portal CASCADE;
DROP SCHEMA IF EXISTS mcpdemo_room_manager CASCADE;
DROP SCHEMA IF EXISTS mcpdemo CASCADE;
