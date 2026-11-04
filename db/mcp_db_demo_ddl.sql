-- mcp_db_demo_ddl.sql: the hotel demo's schemas, tables, views, sequences and routines,
-- for MCPDBWizard for Postgres. Run it as mcpdemo, after mcp_db_demo_user.sql:
--
--   psql -h <host> -U mcpdemo -d <database> -f db/mcp_db_demo_ddl.sql
--
-- A port of the Oracle demo in github.com/srmadscience/mcpdbwizard-demo. Oracle's
-- packages become schemas: ROOM_MANAGER is mcpdemo_room_manager and CUSTOMER_PORTAL is
-- mcpdemo_customer_portal, so a routine's MCP tool is named schema_routine
-- (mcpdemo_room_manager_bookroom).
--
-- What changed on the way from Oracle:
-- * DATE -> timestamp(0); NUMBER -> numeric; VARCHAR2(n) -> varchar(n);
--   PL/SQL's NATURAL -> the domain mcpdemo.dom_natural.
-- * Strong REF CURSOR types and SYS_REFCURSOR -> refcursor.
-- * SYS_CONTEXT('MCP', 'CUSTOMER_NAME') -> current_setting('mcp.customer_name', true),
--   which MCPDBWizard for Postgres sets for each tool call from the ?CUSTOMER_NAME= URL
--   parameter. Nothing needs installing in the database for it.
-- * There are no COMMITs: each MCP tool call commits or rolls back on its own.
--   ROOM_MANAGER.BookRoom's ROLLBACK, when it can't book every room asked for, is a
--   block that raises U0900 and a handler that undoes the block's own work.
-- * RAISE_APPLICATION_ERROR(-20nnn, msg) -> SQLSTATE U0nnn.
--
-- Kept as Oracle has it, quirks included: bookroom with p_room_count 0 or NULL books
-- every free room, and getroomlist's overlap test also rejects any room booked after
-- p_from_date.

CREATE SCHEMA mcpdemo;
CREATE SCHEMA mcpdemo_room_manager;
CREATE SCHEMA mcpdemo_customer_portal;

SET search_path = mcpdemo, public;

-- PL/SQL's NATURAL: an integer that is never negative.
CREATE DOMAIN dom_natural AS integer CHECK (VALUE >= 0);

CREATE TABLE hotels (
    hotel_name       varchar(20)  NOT NULL,
    region_name      varchar(20)  NOT NULL,
    star_rating      numeric(1,0) NOT NULL,
    customer_rating  numeric(2,1) NOT NULL,
    CONSTRAINT hotels_pk PRIMARY KEY (hotel_name)
);

CREATE TABLE hotel_amenities (
    hotel_name           varchar(20)  NOT NULL,
    amenity_name         varchar(80)  NOT NULL,
    amenity_description  varchar(200) NOT NULL,
    chargable_y_or_n     varchar(1)   NOT NULL,
    CONSTRAINT hotel_amenities_pk PRIMARY KEY (hotel_name, amenity_name),
    CONSTRAINT hotel_amenities_chk1 CHECK (chargable_y_or_n IN ('Y','N')),
    CONSTRAINT hotel_amenities_chk2 CHECK (amenity_name = upper(amenity_name)),
    CONSTRAINT hotel_amenities_fk1 FOREIGN KEY (hotel_name)
        REFERENCES hotels (hotel_name) ON DELETE CASCADE
);

CREATE INDEX hotel_amenities_amenity_name ON hotel_amenities (amenity_name);

CREATE TABLE hotel_rooms (
    hotel_name             varchar(20)  NOT NULL,
    room_number            numeric(5,0) NOT NULL,
    room_special_features  varchar(200),
    CONSTRAINT hotel_rooms_pk PRIMARY KEY (hotel_name, room_number),
    CONSTRAINT hotel_rooms_fk1 FOREIGN KEY (hotel_name)
        REFERENCES hotels (hotel_name) ON DELETE CASCADE
);

CREATE INDEX hotel_rooms_room_idx ON hotel_rooms (room_number);

CREATE TABLE customers (
    customer_name  varchar(20) NOT NULL,
    phone_number   varchar(20) NOT NULL,
    email_address  varchar(80) NOT NULL,
    CONSTRAINT customers_pk PRIMARY KEY (customer_name),
    CONSTRAINT customers_email_has_at CHECK (strpos(email_address, '@') > 1
        AND strpos(email_address, '@') < length(email_address))
);

CREATE UNIQUE INDEX customers_email_address ON customers (email_address);

CREATE UNIQUE INDEX customers_phone_number ON customers (phone_number);

CREATE TABLE room_bookings (
    booking_id     numeric       NOT NULL,
    hotel_name     varchar(30)   NOT NULL,
    customer_name  varchar(20)   NOT NULL,
    room_number    numeric(38,0) NOT NULL,
    start_date     timestamp(0)  NOT NULL,
    end_date       timestamp(0)  NOT NULL,
    CONSTRAINT room_bookings_pk PRIMARY KEY (booking_id),
    CONSTRAINT start_before_end CHECK (start_date < end_date),
    CONSTRAINT room_bookings_start_midnight CHECK (start_date = date_trunc('day', start_date)),
    CONSTRAINT room_bookings_end_midnight CHECK (end_date = date_trunc('day', end_date)),
    CONSTRAINT room_bookings_hotel_room FOREIGN KEY (hotel_name, room_number)
        REFERENCES hotel_rooms (hotel_name, room_number) ON DELETE CASCADE,
    CONSTRAINT room_bookings_fk1 FOREIGN KEY (hotel_name)
        REFERENCES hotels (hotel_name),
    CONSTRAINT room_bookings_fk2 FOREIGN KEY (customer_name)
        REFERENCES customers (customer_name)
);

CREATE INDEX room_bookings_customer ON room_bookings (customer_name);

CREATE INDEX room_bookings_hotel_name ON room_bookings (hotel_name);

CREATE SEQUENCE complaint_id_seq;

CREATE TABLE complaints (
    complaint_id     numeric      DEFAULT nextval('complaint_id_seq') NOT NULL,
    customer_name    varchar(20)  NOT NULL,
    complaint_date   timestamp(0) DEFAULT localtimestamp(0) NOT NULL,
    complaint_text   varchar(400) NOT NULL,
    resolved_y_or_n  varchar(1)   DEFAULT 'N' NOT NULL,
    CONSTRAINT complaints_pk PRIMARY KEY (complaint_id),
    CONSTRAINT complaints_chk1 CHECK (resolved_y_or_n IN ('Y','N')),
    CONSTRAINT complaints_fk1 FOREIGN KEY (customer_name)
        REFERENCES customers (customer_name)
);

CREATE INDEX complaints_customer_name ON complaints (customer_name);

CREATE VIEW hotel_regions
    (region_name, min_star_rating, max_star_rating,
     min_customer_rating, customer_star_rating, hotels_in_region) AS
SELECT region_name
,      min(star_rating)
,      max(star_rating)
,      min(customer_rating)
,      max(customer_rating)
,      count(*)
FROM   hotels
GROUP BY region_name;

CREATE VIEW hotel_amenities_summary
    (amenity_name, percent_time_chargable, hotels_with_amenity) AS
SELECT amenity_name
,      (sum(CASE chargable_y_or_n WHEN 'Y' THEN 1 ELSE 0 END)::numeric / count(*)) * 100
,      count(*)
FROM   hotel_amenities
GROUP BY amenity_name;

CREATE SEQUENCE booking_id_seq MINVALUE 1 INCREMENT BY 1 START WITH 10000 CACHE 20 NO CYCLE;

-- ---- upsert_customer --------------------------------------------------------

CREATE PROCEDURE upsert_customer(IN p_customer customers, OUT p_message varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    v_customer customers := p_customer;
    v_existing customers;
    c_needs_at CONSTANT varchar(100) :=
        ' is not a valid email address, it needs an @ with text on both sides';
BEGIN
    -- Customer names are always stored in upper case, email addresses in
    -- lower case, so that the unique indexes see one form of each value
    v_customer.customer_name := upper(nullif(btrim(p_customer.customer_name), ''));
    v_customer.email_address := lower(nullif(btrim(p_customer.email_address), ''));
    v_customer.phone_number  := nullif(btrim(p_customer.phone_number), '');

    IF v_customer.customer_name IS NULL THEN
        p_message := 'A customer name is required';
        RETURN;
    END IF;

    IF v_customer.phone_number IS NULL THEN
        p_message := 'A phone number is required';
        RETURN;
    END IF;

    IF v_customer.email_address IS NULL THEN
        p_message := 'An email address is required';
        RETURN;
    END IF;

    IF strpos(v_customer.email_address, '@') <= 1
    OR strpos(v_customer.email_address, '@') = length(v_customer.email_address) THEN
        p_message := concat('Email address ', v_customer.email_address, c_needs_at);
        RETURN;
    END IF;

    BEGIN
        SELECT * INTO STRICT v_existing
        FROM   customers
        WHERE  customer_name = v_customer.customer_name
        FOR UPDATE NOWAIT;
    EXCEPTION WHEN no_data_found THEN
        INSERT INTO customers SELECT v_customer.*;
        p_message := concat('Created customer ', v_customer.customer_name);
        RETURN;
    END;

    IF  v_existing.phone_number  IS NOT DISTINCT FROM v_customer.phone_number
    AND v_existing.email_address IS NOT DISTINCT FROM v_customer.email_address THEN
        p_message := 'This customer already exists';
    ELSE
        UPDATE customers
        SET    (customer_name, phone_number, email_address)
             = (v_customer.customer_name, v_customer.phone_number, v_customer.email_address)
        WHERE  customer_name = v_customer.customer_name;

        p_message := concat('Updated customer ', v_customer.customer_name);
    END IF;

EXCEPTION
    WHEN unique_violation THEN
        IF strpos(SQLERRM, 'customers_email_address') > 0 THEN
            p_message := concat('Email address ', v_customer.email_address,
                                ' already belongs to another customer');
        ELSIF strpos(SQLERRM, 'customers_phone_number') > 0 THEN
            p_message := concat('Phone number ', v_customer.phone_number,
                                ' already belongs to another customer');
        ELSE
            p_message := 'This customer already exists';
        END IF;
    WHEN lock_not_available THEN
        p_message := concat('Customer ', v_customer.customer_name,
                            ' is being changed by someone else, please try again');
    WHEN check_violation THEN
        IF strpos(SQLERRM, 'customers_email_has_at') > 0 THEN
            p_message := concat('Email address ', v_customer.email_address, c_needs_at);
        ELSE
            RAISE;
        END IF;
END $$;

-- ---- hotel_occupancy --------------------------------------------------------

CREATE PROCEDURE hotel_occupancy(IN p_from_date timestamp(0), IN p_to_date timestamp(0),
                                 OUT p_results refcursor, IN p_hotel_name varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    v_from_date  timestamp(0) := date_trunc('day', p_from_date);
    v_to_date    timestamp(0) := date_trunc('day', p_to_date);
    v_hotel_name varchar(20)  := upper(nullif(btrim(p_hotel_name), ''));
    v_exists     integer;
BEGIN
    IF v_from_date IS NULL THEN
        RAISE EXCEPTION 'A from date is required' USING ERRCODE = 'U0001';
    END IF;

    IF v_to_date IS NULL THEN
        RAISE EXCEPTION 'A to date is required' USING ERRCODE = 'U0002';
    END IF;

    IF v_from_date > v_to_date THEN
        RAISE EXCEPTION 'The from date must not be after the to date' USING ERRCODE = 'U0003';
    END IF;

    IF v_hotel_name IS NOT NULL THEN
        SELECT count(*) INTO v_exists FROM hotels WHERE hotel_name = v_hotel_name;
        IF v_exists = 0 THEN
            RAISE EXCEPTION '%', concat('There is no hotel called ', v_hotel_name)
                USING ERRCODE = 'U0004';
        END IF;
    END IF;

    -- A booking occupies [start_date, end_date), so a checkout day is free.
    -- Every hotel appears on every day of the range, including days with no
    -- bookings at all.
    OPEN p_results FOR
    SELECT c.occupancy_date
    ,      h.hotel_name
    ,      h.rooms                                                          AS rooms_in_hotel
    ,      count(DISTINCT b.room_number)                                    AS rooms_occupied
    ,      round(count(DISTINCT b.room_number)::numeric / h.rooms * 100, 1) AS percent_occupied
    FROM   (SELECT d::timestamp(0) AS occupancy_date
            FROM   generate_series(v_from_date, v_to_date, interval '1 day') AS d) c
    CROSS JOIN
           (SELECT   hotel_name
            ,        count(*) AS rooms
            FROM     hotel_rooms
            WHERE    v_hotel_name IS NULL
            OR       hotel_name = v_hotel_name
            GROUP BY hotel_name) h
    LEFT JOIN room_bookings b
           ON  b.hotel_name  = h.hotel_name
           AND b.start_date <= c.occupancy_date
           AND b.end_date   >  c.occupancy_date
    GROUP BY c.occupancy_date, h.hotel_name, h.rooms
    ORDER BY c.occupancy_date, h.hotel_name;
END $$;

-- ---- room_manager -----------------------------------------------------------

SET search_path = mcpdemo_room_manager, mcpdemo, public;

CREATE PROCEDURE getroomlist(IN p_hotel_name varchar, IN p_from_date timestamp(0),
                             IN p_to_date timestamp(0), OUT p_results refcursor,
                             OUT p_message varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
BEGIN
    p_message := concat('Looking for availability for ', p_hotel_name, p_from_date, ' to ', p_to_date);

    IF p_hotel_name IS NULL OR length(btrim(p_hotel_name)) = 0 THEN
        p_message := 'Hotel Name Needed';
    ELSIF p_from_date IS NULL THEN
        p_message := 'From Date Needed';
    ELSIF p_to_date IS NULL THEN
        p_message := 'To Date Needed';
    ELSE
        OPEN p_results FOR
        SELECT r.hotel_name, r.room_number, r.room_special_features
        FROM   hotel_rooms r
        WHERE  r.hotel_name = upper(btrim(p_hotel_name))
        AND    NOT EXISTS (SELECT NULL
                           FROM   room_bookings b
                           WHERE  b.hotel_name  = r.hotel_name
                           AND    b.room_number = r.room_number
                           AND    (   (b.start_date >= p_from_date AND b.end_date <= p_to_date)   -- bookings inside our booking...
                                   OR (b.start_date <= p_from_date AND b.end_date >= p_to_date)   -- bookings absorbing our booking...
                                   OR (b.start_date >= p_from_date AND b.end_date >= p_from_date) -- conflict with start
                                   OR (b.start_date <= p_to_date   AND b.end_date >= p_to_date))) -- conflict with end
        ORDER BY room_number;
    END IF;
END $$;

CREATE PROCEDURE bookroom(IN p_hotel_name varchar, IN p_customer_name varchar,
                          IN p_from_date timestamp(0), IN p_to_date timestamp(0),
                          IN p_room_count mcpdemo.dom_natural, OUT bookingcursor refcursor,
                          OUT p_message varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_room_cursor       refcursor;
    l_room_message      varchar(2048);
    l_booked_room_count integer := 0;
    l_room              hotel_rooms;
BEGIN
    BEGIN
        CALL getroomlist(p_hotel_name, p_from_date, p_to_date, l_room_cursor, l_room_message);

        LOOP
            FETCH l_room_cursor INTO l_room;
            EXIT WHEN NOT FOUND;

            INSERT INTO room_bookings
                (booking_id, hotel_name, customer_name, room_number, start_date, end_date)
            VALUES
                (nextval('booking_id_seq'), upper(btrim(p_hotel_name)),
                 upper(btrim(p_customer_name)), l_room.room_number, p_from_date, p_to_date);

            l_booked_room_count := l_booked_room_count + 1;

            IF l_booked_room_count = p_room_count THEN
                EXIT;
            END IF;
        END LOOP;

        CLOSE l_room_cursor;

        IF l_booked_room_count < p_room_count THEN
            RAISE SQLSTATE 'U0900';                       -- ROLLBACK
        END IF;

        p_message := concat('Booked ', p_room_count, ' rooms.');
    EXCEPTION WHEN SQLSTATE 'U0900' THEN
        p_message := concat('Unable to book ', p_room_count, ' rooms. Only ',
                            l_booked_room_count, ' available. Nothing booked.');
    END;

    -- Note that if the loop failed we *still* return a list of bookings, as
    -- the same customer might make multiple ones. p_message conveys the outcome.
    OPEN bookingcursor FOR
    SELECT b.*
    FROM   room_bookings b
    WHERE  b.hotel_name    = upper(btrim(p_hotel_name))
    AND    b.customer_name = upper(btrim(p_customer_name))
    AND    b.start_date    = p_from_date
    AND    b.end_date      = p_to_date
    ORDER BY b.booking_id;
END $$;

-- ---- customer_portal --------------------------------------------------------
--
-- What a CUSTOMER-facing agent may do: for one customer, and only that one.
-- The customer is never a parameter. It comes from the mcp.customer_name
-- setting, which an MCPDBWizard server sets before every tool call from its
-- connection URL (?CUSTOMER_NAME=SUZY%20BISHOP). Unset, every call is refused.

SET search_path = mcpdemo_customer_portal, mcpdemo, public;

-- Oracle's package-private current_customer.
CREATE FUNCTION current_customer() RETURNS varchar
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_name  varchar(4000) := upper(nullif(btrim(nullif(current_setting('mcp.customer_name', true), '')), ''));
    l_count numeric;
BEGIN
    IF l_name IS NULL THEN
        RAISE EXCEPTION 'No customer. Connect with ?CUSTOMER_NAME=<your name> on the MCP server URL.'
            USING ERRCODE = 'U0100';
    END IF;
    SELECT count(*) INTO l_count FROM customers WHERE customer_name = l_name;
    IF l_count = 0 THEN
        RAISE EXCEPTION '%', concat('Customer ', l_name, ' is not known to this hotel chain.')
            USING ERRCODE = 'U0101';
    END IF;
    RETURN l_name;
END $$;

CREATE PROCEDURE my_details(OUT p_customer_name varchar, OUT p_phone_number varchar,
                            OUT p_email_address varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_customer varchar(4000) := current_customer();
BEGIN
    SELECT customer_name, phone_number, email_address
    INTO STRICT p_customer_name, p_phone_number, p_email_address
    FROM   customers
    WHERE  customer_name = l_customer;
END $$;

CREATE PROCEDURE my_bookings(OUT p_bookings refcursor)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_customer varchar(4000) := current_customer();
BEGIN
    OPEN p_bookings FOR
    SELECT b.*
    FROM   room_bookings b
    WHERE  b.customer_name = l_customer
    ORDER BY b.start_date, b.booking_id;
END $$;

CREATE PROCEDURE book_rooms(IN p_hotel_name varchar, IN p_from_date timestamp(0),
                            IN p_to_date timestamp(0), IN p_room_count mcpdemo.dom_natural,
                            OUT p_bookings refcursor, OUT p_message varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
BEGIN
    CALL mcpdemo_room_manager.bookroom(p_hotel_name, current_customer(), p_from_date,
                                                  p_to_date, p_room_count, p_bookings, p_message);
END $$;

CREATE PROCEDURE cancel_booking(IN p_booking_id numeric, OUT p_message varchar)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_customer varchar(4000) := current_customer();
    l_rows     bigint;
BEGIN
    DELETE FROM room_bookings
    WHERE  booking_id    = p_booking_id
    AND    customer_name = l_customer;
    GET DIAGNOSTICS l_rows = ROW_COUNT;
    IF l_rows = 0 THEN
        p_message := concat('You have no booking ', p_booking_id, '.');
    ELSE
        p_message := concat('Cancelled booking ', p_booking_id, '.');
    END IF;
END $$;

CREATE PROCEDURE my_complaints(OUT p_complaints refcursor)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_customer varchar(4000) := current_customer();
BEGIN
    OPEN p_complaints FOR
    SELECT c.*
    FROM   complaints c
    WHERE  c.customer_name = l_customer
    ORDER BY c.complaint_date, c.complaint_id;
END $$;

CREATE PROCEDURE add_complaint(IN p_complaint_text varchar, OUT p_complaint_id numeric)
    LANGUAGE plpgsql SET search_path FROM CURRENT AS $$
DECLARE
    l_customer varchar(4000) := current_customer();
BEGIN
    INSERT INTO complaints (customer_name, complaint_text)
    VALUES (l_customer, p_complaint_text)
    RETURNING complaint_id INTO p_complaint_id;
END $$;
