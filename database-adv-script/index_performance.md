## Implementing Indexes for Optimization

Indexes improve database query performance by allowing faster lookups, especially on columns frequently used in filtering, joining, or sorting.

### Identified High-Usage Columns

- `User.email` — used for login and lookups
- `Booking.user_id` — used to find bookings by user
- `Booking.property_id` — used to find bookings by property
- `Property.host_id` — used to find properties by host

---

### SQL Commands to Create Indexes (save as `database_index.sql`)

```sql
CREATE INDEX idx_user_email ON User(email);

CREATE INDEX idx_booking_user ON Booking(user_id);

CREATE INDEX idx_booking_property ON Booking(property_id);

CREATE INDEX idx_property_host ON Property(host_id);

