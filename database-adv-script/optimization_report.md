SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pm.payment_id,
    pm.amount,
    pm.payment_date,
    pm.method_id
FROM Booking b
INNER JOIN User u USE INDEX (PRIMARY) ON b.user_id = u.user_id
INNER JOIN Property p USE INDEX (PRIMARY) ON b.property_id = p.property_id
LEFT JOIN Payment pm USE INDEX (idx_payment_booking) ON b.booking_id = pm.booking_id
WHERE b.status != 'canceled';
