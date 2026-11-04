SELECT booking_id, hotel_name, room_number, start_date, end_date
from room_bookings
where customer_name = UPPER(LTRIM(RTRIM(? /* String */)))
ORDER BY start_date, booking_id;
