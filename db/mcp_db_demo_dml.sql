-- mcp_db_demo_dml.sql: the hotel demo's sample data: 10 hotels, their amenities and
-- rooms, customers, bookings and complaints. Run it as mcpdemo, after the DDL:
--
--   psql -h <host> -U mcpdemo -d <database> -f db/mcp_db_demo_dml.sql

SET search_path = mcpdemo, public;

INSERT INTO hotels VALUES ('THORIUM TOWERS', 'MINING REGION', 3, 2.1);
INSERT INTO hotels VALUES ('BORDER VIEW', 'BORDER REGION', 5, 2.1);

INSERT INTO HOTEL_AMENITIES VALUES ('THORIUM TOWERS','SWIMMING POOL','A deep, dank and possibly bottomless pool','N');
INSERT INTO HOTEL_AMENITIES VALUES ('THORIUM TOWERS','CAR PARK','Outside','N');
INSERT INTO HOTEL_AMENITIES VALUES ('BORDER VIEW','SWIMMING POOL','Enter at your own risk','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('BORDER VIEW','CONVERSATION PIT','The main topic of conversation among guests are ''who left this huge hole in lobby floor?'' and ''Is that my leg bone sticking out?''','N');

insert into hotel_rooms values ('THORIUM TOWERS',100,null);
insert into hotel_rooms values ('THORIUM TOWERS',101,null);
insert into hotel_rooms values ('THORIUM TOWERS',102,null);
insert into hotel_rooms values ('THORIUM TOWERS',103,null);
insert into hotel_rooms values ('THORIUM TOWERS',104,null);
insert into hotel_rooms values ('THORIUM TOWERS',105,null);
insert into hotel_rooms values ('THORIUM TOWERS',106,null);

insert into hotel_rooms values ('BORDER VIEW',200,null);
insert into hotel_rooms values ('BORDER VIEW',201,null);
insert into hotel_rooms values ('BORDER VIEW',202,null);
insert into hotel_rooms values ('BORDER VIEW',203,null);
insert into hotel_rooms values ('BORDER VIEW',204,null);
insert into hotel_rooms values ('BORDER VIEW',205,'An excellent view of the border, which runs along the start of the balcony');
insert into hotel_rooms values ('BORDER VIEW',206,null);
insert into hotel_rooms values ('BORDER VIEW',207,null);

INSERT INTO hotels VALUES ('GRAND BUDAPEST', 'ZUBROWKA ALPS', 5, 4.8);
INSERT INTO hotels VALUES ('HOTEL CHEVALIER', 'RUE BLAGUE', 4, 3.9);
INSERT INTO hotels VALUES ('CAMP IVANHOE', 'NEW PENZANCE', 2, 4.1);
INSERT INTO hotels VALUES ('THE DARJEELING', 'RAJASTHAN LINE', 3, 2.8);
INSERT INTO hotels VALUES ('ASTEROID CITY INN', 'ASTEROID PLAINS', 2, 3.3);
INSERT INTO hotels VALUES ('LE SANS BLAGUE', 'ENNUI-SUR-BLASE', 4, 4.4);
INSERT INTO hotels VALUES ('TRASH ISLAND INN', 'MEGASAKI BAY', 1, 1.9);
INSERT INTO hotels VALUES ('BELAFONTE BERTH', 'PORT OF LORO', 3, 3.7);

INSERT INTO HOTEL_AMENITIES VALUES ('GRAND BUDAPEST','FUNICULAR','A pink railway carriage that ascends the mountain twice hourly, weather and revolution permitting','N');
INSERT INTO HOTEL_AMENITIES VALUES ('GRAND BUDAPEST','CONCIERGE','Available at all hours. Discretion assured. Perfume applied liberally','N');
INSERT INTO HOTEL_AMENITIES VALUES ('GRAND BUDAPEST','PATISSERIE','Courtesan au chocolat delivered in a pale blue box tied with ribbon','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('HOTEL CHEVALIER','ROOM SERVICE','Grilled cheese, fries and a bloody mary. The only order anyone has ever placed','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('HOTEL CHEVALIER','BATHTUB','Yellow. Enormous. Suitable for two if neither party mentions the past','N');
INSERT INTO HOTEL_AMENITIES VALUES ('CAMP IVANHOE','CAR PARK','A field. Scouts will direct you with semaphore flags','N');
INSERT INTO HOTEL_AMENITIES VALUES ('CAMP IVANHOE','LOOKOUT TOWER','Built by twelve year olds without adult supervision. Structurally optimistic','N');
INSERT INTO HOTEL_AMENITIES VALUES ('THE DARJEELING','LAMINATED MENU','Sweet lime soda, Indian sweets and a cough syrup nightcap','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('THE DARJEELING','LUGGAGE PORTERAGE','Eleven monogrammed suitcases carried by one increasingly resentful man','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('ASTEROID CITY INN','SWIMMING POOL','A rectangle of concrete with no water in it. Very good acoustics','N');
INSERT INTO HOTEL_AMENITIES VALUES ('ASTEROID CITY INN','VENDING MACHINE','Dispenses martinis, real estate deeds and small parcels of land','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('LE SANS BLAGUE','CAFE TERRACE','Journalists nurse one coffee for eleven hours while writing very long sentences','Y');
INSERT INTO HOTEL_AMENITIES VALUES ('LE SANS BLAGUE','CONVERSATION PIT','Sunken, upholstered in mustard velvet, and permanently occupied by a poet','N');
INSERT INTO HOTEL_AMENITIES VALUES ('TRASH ISLAND INN','SWIMMING POOL','Technically a puddle in a disused incinerator. Dogs swim free','N');
INSERT INTO HOTEL_AMENITIES VALUES ('TRASH ISLAND INN','CAR PARK','Outside, and also on fire','N');
INSERT INTO HOTEL_AMENITIES VALUES ('BELAFONTE BERTH','OBSERVATION DECK','Watch for jaguar sharks. Binoculars and a red woollen cap are provided','N');
INSERT INTO HOTEL_AMENITIES VALUES ('BELAFONTE BERTH','SAUNA','Below the waterline, next to the editing suite and the dolphin pens','Y');

insert into hotel_rooms values ('GRAND BUDAPEST',300,null);
insert into hotel_rooms values ('GRAND BUDAPEST',301,null);
insert into hotel_rooms values ('GRAND BUDAPEST',302,null);
insert into hotel_rooms values ('GRAND BUDAPEST',303,'Suite of the late Madame D. Contains a painting of a boy with an apple, or possibly a forgery of same');
insert into hotel_rooms values ('GRAND BUDAPEST',304,null);
insert into hotel_rooms values ('GRAND BUDAPEST',305,null);

insert into hotel_rooms values ('HOTEL CHEVALIER',400,null);
insert into hotel_rooms values ('HOTEL CHEVALIER',401,null);
insert into hotel_rooms values ('HOTEL CHEVALIER',403,'Yellow throughout. Occupied by the same guest for one month. Do not enquire about the wife or the manuscript');
insert into hotel_rooms values ('HOTEL CHEVALIER',404,null);

insert into hotel_rooms values ('CAMP IVANHOE',500,null);
insert into hotel_rooms values ('CAMP IVANHOE',501,null);
insert into hotel_rooms values ('CAMP IVANHOE',502,'Tent, not a room. Sleeps one scout and a small quantity of contraband fireworks');
insert into hotel_rooms values ('CAMP IVANHOE',503,null);
insert into hotel_rooms values ('CAMP IVANHOE',504,null);

insert into hotel_rooms values ('THE DARJEELING',600,null);
insert into hotel_rooms values ('THE DARJEELING',601,null);
insert into hotel_rooms values ('THE DARJEELING',602,'A sleeper compartment. The room moves overnight and may not be where you left it');
insert into hotel_rooms values ('THE DARJEELING',603,null);

insert into hotel_rooms values ('ASTEROID CITY INN',700,null);
insert into hotel_rooms values ('ASTEROID CITY INN',701,null);
insert into hotel_rooms values ('ASTEROID CITY INN',702,'Ground floor. Uninterrupted view of the crater and, on some nights, of an alien collecting the meteorite');
insert into hotel_rooms values ('ASTEROID CITY INN',703,null);
insert into hotel_rooms values ('ASTEROID CITY INN',704,null);

insert into hotel_rooms values ('LE SANS BLAGUE',800,null);
insert into hotel_rooms values ('LE SANS BLAGUE',801,'Overlooks the Rue des Poissons. Comes with a typewriter and a standing tab at the bar downstairs');
insert into hotel_rooms values ('LE SANS BLAGUE',802,null);
insert into hotel_rooms values ('LE SANS BLAGUE',803,null);

insert into hotel_rooms values ('TRASH ISLAND INN',900,null);
insert into hotel_rooms values ('TRASH ISLAND INN',901,null);
insert into hotel_rooms values ('TRASH ISLAND INN',902,'Constructed entirely from crushed sake bottles. Guests are asked to bring their own dog');
insert into hotel_rooms values ('TRASH ISLAND INN',903,null);

insert into hotel_rooms values ('BELAFONTE BERTH',1000,null);
insert into hotel_rooms values ('BELAFONTE BERTH',1001,null);
insert into hotel_rooms values ('BELAFONTE BERTH',1002,'The cross section cabin. One wall is missing so that the interior may be filmed at all times');
insert into hotel_rooms values ('BELAFONTE BERTH',1003,null);
insert into hotel_rooms values ('BELAFONTE BERTH',1004,null);

INSERT INTO customers VALUES ('M GUSTAVE','+36 1 555 0101','m.gustave@grandbudapest.zz');
INSERT INTO customers VALUES ('ZERO MOUSTAFA','+36 1 555 0102','zero.moustafa@grandbudapest.zz');
INSERT INTO customers VALUES ('AGATHA','+36 1 555 0103','agatha@mendls.zz');
INSERT INTO customers VALUES ('SUZY BISHOP','+1 401 555 0110','suzy.bishop@newpenzance.zz');
INSERT INTO customers VALUES ('SAM SHAKUSKY','+1 401 555 0111','sam.shakusky@khakiscouts.zz');
INSERT INTO customers VALUES ('STEVE ZISSOU','+33 4 555 0120','steve.zissou@belafonte.zz');
INSERT INTO customers VALUES ('KLAUS DAIMLER','+49 30 555 0121','klaus.daimler@belafonte.zz');
INSERT INTO customers VALUES ('FRANCIS WHITMAN','+91 141 555 0130','francis.whitman@darjeeling.zz');
INSERT INTO customers VALUES ('AUGIE STEENBECK','+1 505 555 0140','augie.steenbeck@asteroidcity.zz');
INSERT INTO customers VALUES ('ROEBUCK WRIGHT','+33 1 555 0150','roebuck.wright@frenchdispatch.zz');
INSERT INTO customers VALUES ('MARGOT TENENBAUM','+1 212 555 0160','margot.tenenbaum@tenenbaum.zz');
INSERT INTO customers VALUES ('MR FOX','+44 20 555 0170','mr.fox@foxholdings.zz');
INSERT INTO customers VALUES ('HERMAN BLUME','+1 713 555 0180','herman.blume@blumeintl.zz');

INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','M GUSTAVE',300,DATE '2026-01-12',DATE '2026-01-19');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','ZERO MOUSTAFA',301,DATE '2026-01-12',DATE '2026-02-28');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','AGATHA',303,DATE '2026-02-14',DATE '2026-02-16');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','M GUSTAVE',300,DATE '2026-09-01',DATE '2026-09-08');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','SAM SHAKUSKY',501,DATE '2026-06-20',DATE '2026-06-27');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','SUZY BISHOP',502,DATE '2026-06-20',DATE '2026-06-27');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','STEVE ZISSOU',1002,DATE '2026-08-10',DATE '2026-09-30');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','KLAUS DAIMLER',1000,DATE '2026-08-10',DATE '2026-09-30');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','FRANCIS WHITMAN',602,DATE '2026-08-22',DATE '2026-08-29');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','AUGIE STEENBECK',702,DATE '2026-08-24',DATE '2026-08-31');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'LE SANS BLAGUE','ROEBUCK WRIGHT',801,DATE '2026-03-05',DATE '2026-11-05');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','MARGOT TENENBAUM',403,DATE '2026-09-14',DATE '2026-09-16');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','MR FOX',902,DATE '2026-10-02',DATE '2026-10-03');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','HERMAN BLUME',100,DATE '2026-07-01',DATE '2026-07-04');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BORDER VIEW','ZERO MOUSTAFA',205,DATE '2026-12-24',DATE '2026-12-31');


INSERT INTO customers VALUES ('ROYAL TENENBAUM','+1 212 555 0201','royal.tenenbaum@traveller.zz');
INSERT INTO customers VALUES ('ETHELINE TENENBAUM','+1 212 555 0202','etheline.tenenbaum@traveller.zz');
INSERT INTO customers VALUES ('CHAS TENENBAUM','+1 212 555 0203','chas.tenenbaum@traveller.zz');
INSERT INTO customers VALUES ('RICHIE TENENBAUM','+1 212 555 0204','richie.tenenbaum@traveller.zz');
INSERT INTO customers VALUES ('ELI CASH','+1 212 555 0205','eli.cash@traveller.zz');
INSERT INTO customers VALUES ('RALEIGH ST CLAIR','+44 20 555 0206','raleigh.st.clair@traveller.zz');
INSERT INTO customers VALUES ('DIGNAN','+1 214 555 0207','dignan@traveller.zz');
INSERT INTO customers VALUES ('ANTHONY ADAMS','+1 214 555 0208','anthony.adams@traveller.zz');
INSERT INTO customers VALUES ('BOB MAPPLETHORPE','+1 214 555 0209','bob.mapplethorpe@traveller.zz');
INSERT INTO customers VALUES ('MAX FISCHER','+1 713 555 0210','max.fischer@traveller.zz');
INSERT INTO customers VALUES ('ROSEMARY CROSS','+1 713 555 0211','rosemary.cross@traveller.zz');
INSERT INTO customers VALUES ('DIRK CALLOWAY','+1 713 555 0212','dirk.calloway@traveller.zz');
INSERT INTO customers VALUES ('NED PLIMPTON','+1 504 555 0213','ned.plimpton@traveller.zz');
INSERT INTO customers VALUES ('ELEANOR ZISSOU','+33 4 555 0214','eleanor.zissou@traveller.zz');
INSERT INTO customers VALUES ('VLADIMIR WOLODARSKY','+7 495 555 0215','vladimir.wolodarsky@traveller.zz');
INSERT INTO customers VALUES ('PELE DOS SANTOS','+55 21 555 0216','pele.dos.santos@traveller.zz');
INSERT INTO customers VALUES ('JANE WINSLETT','+44 20 555 0217','jane.winslett@traveller.zz');
INSERT INTO customers VALUES ('PETER WHITMAN','+91 141 555 0218','peter.whitman@traveller.zz');
INSERT INTO customers VALUES ('JACK WHITMAN','+91 141 555 0219','jack.whitman@traveller.zz');
INSERT INTO customers VALUES ('WALT BISHOP','+1 401 555 0220','walt.bishop@traveller.zz');
INSERT INTO customers VALUES ('LAURA BISHOP','+1 401 555 0221','laura.bishop@traveller.zz');
INSERT INTO customers VALUES ('CAPTAIN SHARP','+1 401 555 0222','captain.sharp@traveller.zz');
INSERT INTO customers VALUES ('BECKY SHARP','+1 401 555 0223','becky.sharp@traveller.zz');
INSERT INTO customers VALUES ('FELICITY FOX','+44 20 555 0224','felicity.fox@traveller.zz');
INSERT INTO customers VALUES ('ASH FOX','+44 20 555 0225','ash.fox@traveller.zz');
INSERT INTO customers VALUES ('KRISTOFFERSON FOX','+44 20 555 0226','kristofferson.fox@traveller.zz');
INSERT INTO customers VALUES ('FRANKLIN BEAN','+44 20 555 0227','franklin.bean@traveller.zz');
INSERT INTO customers VALUES ('ATARI KOBAYASHI','+81 3 555 0228','atari.kobayashi@traveller.zz');
INSERT INTO customers VALUES ('TRACY WALKER','+81 3 555 0229','tracy.walker@traveller.zz');
INSERT INTO customers VALUES ('TILDA SIMMONS','+33 1 555 0230','tilda.simmons@traveller.zz');

INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','ROYAL TENENBAUM',300,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','ETHELINE TENENBAUM',301,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','CHAS TENENBAUM',302,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','RICHIE TENENBAUM',303,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','ELI CASH',304,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','RALEIGH ST CLAIR',305,DATE '2026-05-04',DATE '2026-05-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','DIGNAN',500,DATE '2026-07-11',DATE '2026-07-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','ANTHONY ADAMS',501,DATE '2026-07-11',DATE '2026-07-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','BOB MAPPLETHORPE',502,DATE '2026-07-11',DATE '2026-07-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','MAX FISCHER',503,DATE '2026-07-11',DATE '2026-07-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','ROSEMARY CROSS',504,DATE '2026-07-11',DATE '2026-07-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','DIRK CALLOWAY',900,DATE '2026-10-15',DATE '2026-10-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','NED PLIMPTON',901,DATE '2026-10-15',DATE '2026-10-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','ELEANOR ZISSOU',902,DATE '2026-10-15',DATE '2026-10-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','VLADIMIR WOLODARSKY',903,DATE '2026-10-15',DATE '2026-10-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','PELE DOS SANTOS',400,DATE '2026-04-06',DATE '2026-04-10');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','JANE WINSLETT',403,DATE '2026-04-06',DATE '2026-04-10');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','PETER WHITMAN',404,DATE '2026-04-06',DATE '2026-04-10');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','JACK WHITMAN',700,DATE '2026-03-16',DATE '2026-03-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','WALT BISHOP',701,DATE '2026-03-16',DATE '2026-03-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','LAURA BISHOP',702,DATE '2026-03-16',DATE '2026-03-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','CAPTAIN SHARP',703,DATE '2026-03-16',DATE '2026-03-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','BECKY SHARP',600,DATE '2026-11-09',DATE '2026-11-13');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','FELICITY FOX',601,DATE '2026-11-09',DATE '2026-11-13');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','ASH FOX',602,DATE '2026-11-09',DATE '2026-11-13');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','ROYAL TENENBAUM',400,DATE '2026-07-23',DATE '2026-07-25');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','ROYAL TENENBAUM',603,DATE '2026-01-15',DATE '2026-01-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','ETHELINE TENENBAUM',601,DATE '2026-02-01',DATE '2026-02-08');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','ETHELINE TENENBAUM',603,DATE '2026-08-28',DATE '2026-08-31');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','CHAS TENENBAUM',1003,DATE '2026-10-13',DATE '2026-10-15');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','CHAS TENENBAUM',601,DATE '2026-04-24',DATE '2026-05-01');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','CHAS TENENBAUM',102,DATE '2026-09-02',DATE '2026-09-09');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'LE SANS BLAGUE','RICHIE TENENBAUM',802,DATE '2026-09-11',DATE '2026-09-15');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BORDER VIEW','RICHIE TENENBAUM',200,DATE '2026-05-19',DATE '2026-05-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','ELI CASH',305,DATE '2026-02-19',DATE '2026-02-24');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','ELI CASH',1004,DATE '2026-06-01',DATE '2026-06-03');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BORDER VIEW','ELI CASH',204,DATE '2026-04-20',DATE '2026-04-30');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','RALEIGH ST CLAIR',504,DATE '2026-10-30',DATE '2026-11-03');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'LE SANS BLAGUE','RALEIGH ST CLAIR',801,DATE '2026-12-20',DATE '2026-12-24');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','DIGNAN',503,DATE '2026-04-25',DATE '2026-04-28');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','ANTHONY ADAMS',100,DATE '2026-01-04',DATE '2026-01-09');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','BOB MAPPLETHORPE',600,DATE '2026-01-15',DATE '2026-01-17');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','MAX FISCHER',700,DATE '2026-10-09',DATE '2026-10-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','ROSEMARY CROSS',1002,DATE '2026-11-20',DATE '2026-11-23');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','DIRK CALLOWAY',603,DATE '2026-07-14',DATE '2026-07-21');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','NED PLIMPTON',701,DATE '2026-09-02',DATE '2026-09-05');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','NED PLIMPTON',603,DATE '2026-01-26',DATE '2026-01-28');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','ELEANOR ZISSOU',701,DATE '2026-02-27',DATE '2026-03-02');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','VLADIMIR WOLODARSKY',600,DATE '2026-05-03',DATE '2026-05-06');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','VLADIMIR WOLODARSKY',404,DATE '2026-12-10',DATE '2026-12-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BORDER VIEW','VLADIMIR WOLODARSKY',207,DATE '2026-03-05',DATE '2026-03-06');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','PELE DOS SANTOS',701,DATE '2026-01-06',DATE '2026-01-09');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','JANE WINSLETT',303,DATE '2026-02-16',DATE '2026-02-23');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','JANE WINSLETT',303,DATE '2026-11-29',DATE '2026-12-01');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','PETER WHITMAN',704,DATE '2026-10-04',DATE '2026-10-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','PETER WHITMAN',600,DATE '2026-09-16',DATE '2026-09-17');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'ASTEROID CITY INN','JACK WHITMAN',703,DATE '2026-01-22',DATE '2026-02-05');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','JACK WHITMAN',502,DATE '2026-09-04',DATE '2026-09-14');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','WALT BISHOP',100,DATE '2026-12-04',DATE '2026-12-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'LE SANS BLAGUE','WALT BISHOP',800,DATE '2026-05-26',DATE '2026-06-02');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THE DARJEELING','WALT BISHOP',601,DATE '2026-09-27',DATE '2026-10-04');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','LAURA BISHOP',903,DATE '2026-01-21',DATE '2026-01-24');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','LAURA BISHOP',401,DATE '2026-05-21',DATE '2026-05-23');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BELAFONTE BERTH','CAPTAIN SHARP',1004,DATE '2026-08-23',DATE '2026-08-30');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','CAPTAIN SHARP',902,DATE '2026-02-04',DATE '2026-02-11');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','BECKY SHARP',900,DATE '2026-06-29',DATE '2026-07-06');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','FELICITY FOX',105,DATE '2026-10-27',DATE '2026-11-03');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'BORDER VIEW','ASH FOX',200,DATE '2026-12-10',DATE '2026-12-15');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'HOTEL CHEVALIER','KRISTOFFERSON FOX',401,DATE '2026-09-02',DATE '2026-09-06');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','KRISTOFFERSON FOX',501,DATE '2026-11-23',DATE '2026-11-28');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','FRANKLIN BEAN',503,DATE '2026-11-05',DATE '2026-11-19');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','FRANKLIN BEAN',302,DATE '2026-03-15',DATE '2026-03-16');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'TRASH ISLAND INN','ATARI KOBAYASHI',902,DATE '2026-04-09',DATE '2026-04-19');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'LE SANS BLAGUE','ATARI KOBAYASHI',802,DATE '2026-11-26',DATE '2026-12-03');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'GRAND BUDAPEST','TRACY WALKER',300,DATE '2026-08-19',DATE '2026-08-22');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'CAMP IVANHOE','TRACY WALKER',502,DATE '2026-05-11',DATE '2026-05-18');
INSERT INTO room_bookings VALUES (nextval('booking_id_seq'),'THORIUM TOWERS','TILDA SIMMONS',104,DATE '2026-11-05',DATE '2026-11-06');

INSERT INTO complaints (customer_name, complaint_text) VALUES ('M GUSTAVE','The lobby boy was insufficiently discreet. I have trained him myself and take full responsibility, but the complaint stands');
INSERT INTO complaints (customer_name, complaint_text) VALUES ('ZERO MOUSTAFA','My room in BORDER VIEW is bisected by an international frontier. I am obliged to carry papers to reach the bathroom');
INSERT INTO complaints (customer_name, complaint_text) VALUES ('STEVE ZISSOU','The sauna is directly beneath the dolphin pens and the acoustics are unbearable. Also the dolphins are unreliable');
INSERT INTO complaints (customer_name, complaint_text) VALUES ('MR FOX','My room is constructed from crushed sake bottles. I was asked to bring my own dog and was then charged for it');
INSERT INTO complaints (customer_name, complaint_text) VALUES ('SUZY BISHOP','The lookout tower was built by twelve year olds without adult supervision. I have inspected it and I concur');
INSERT INTO complaints (customer_name, complaint_text, complaint_date, resolved_y_or_n) VALUES ('AUGIE STEENBECK','An alien removed the meteorite from the crater during my stay. The front desk denies all knowledge',DATE '2026-08-25','Y');
INSERT INTO complaints (customer_name, complaint_text, complaint_date, resolved_y_or_n) VALUES ('MARGOT TENENBAUM','The bath is yellow, enormous, and suitable for two. I was travelling alone',DATE '2026-09-15','Y');
