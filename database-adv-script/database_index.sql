CREATE INDEX idx_user_email ON User(email);

-- Index on 'user_id' in the Booking table for faster joins with the User table
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Index on 'property_id' in the Booking table to improve joins and filtering with Property
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index on 'host_id' in the Property table to speed up queries filtering by host
CREATE INDEX idx_property_host ON Property(host_id);

EXPLAIN
SELECT u.email, b.booking_id, p.name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id;

EXPLAIN ANALYZE
SELECT u.email, b.booking_id, p.name
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id;
