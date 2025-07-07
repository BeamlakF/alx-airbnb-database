## Database Performance Monitoring Report

- Profiled the query: `SELECT * FROM Booking WHERE user_id = 'some-user-id'`
- Observed a full table scan causing high latency.
- Created a composite index on `(user_id, start_date)` to optimize filtering and sorting.
- Post-implementation EXPLAIN ANALYZE showed index scan usage.
- Query execution time dropped from 120ms to 15ms.
- Further monitoring ongoing for other queries.
