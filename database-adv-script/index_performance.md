## Implementing Indexes for Optimization

Indexes improve database query performance by allowing faster lookups, especially on columns frequently used in filtering, joining, or sorting.

### Identified High-Usage Columns

- `User.email` — used for login and lookups
- `Booking.user_id` — used to find bookings by user
- `Booking.property_id` — used to find bookings by property
- `Property.host_id` — used to find properties by host

---

### SQL Commands to Create Indexes 

-- 📌 Indexes to Improve Query Performance

-- Index on the 'email' column of the User table for faster searches and uniqueness checks
CREATE INDEX idx_user_email ON User(email);

-- Index on 'user_id' in the Booking table for faster joins with the User table
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Index on 'property_id' in the Booking table to improve joins and filtering with Property
CREATE INDEX idx_booking_property ON Booking(property_id);

-- Index on 'host_id' in the Property table to speed up queries filtering by host
CREATE INDEX idx_property_host ON Property(host_id);

