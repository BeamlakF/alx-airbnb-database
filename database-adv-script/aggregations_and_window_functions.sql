SELECT user_id, COUNT(*) AS total_bookings
FROM Booking
GROUP BY user_id;
SELECT 
    property_id,
    COUNT(*) AS bookings_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM Booking
GROUP BY property_id;

SELECT 
    property_id,
    COUNT(*) AS bookings_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_row_number
FROM Booking
GROUP BY property_id;

SELECT 
    property_id,
    COUNT(*) AS bookings_count,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_dense_rank
FROM Booking
GROUP BY property_id;
