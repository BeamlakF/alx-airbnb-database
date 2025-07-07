## Partitioning Performance Report

- Implemented **range partitioning** on `Booking` table by `YEAR(start_date)`.
- Partitioned data into yearly partitions from 2019 to 2022, plus a max partition.
- After partitioning, queries filtering on `start_date` ranged scans only relevant partitions.
- Query performance improved significantly for date range queries, reducing I/O and execution time.
- EXPLAIN showed scanning 1 partition instead of the whole table.
- Write-heavy operations showed slight overhead due to partition maintenance.
- Overall, partitioning effectively optimized large historical data queries.
