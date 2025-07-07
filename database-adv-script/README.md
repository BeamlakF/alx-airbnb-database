
## SQL Subqueries

Subqueries allow you to embed one query inside another to filter or compute results.

### Non-Correlated Subquery Example

Find all properties with an average rating greater than 4.0:

```sql
SELECT *
FROM Property
WHERE property_id IN (
    SELECT property_id
    FROM Review
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);
````

> Note: This subquery runs independently of the outer query.

---

### Correlated Subquery Example

Find users who have made more than 3 bookings:

```sql
SELECT u.user_id, u.first_name, u.last_name
FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking b
    WHERE b.user_id = u.user_id
) > 3;
```

> Note: This subquery depends on the outer query (correlated).

---

### When to Use

* Use **non-correlated subqueries** for independent aggregated values.
* Use **correlated subqueries** when the inner query references the outer query’s row.


## SQL Joins

Joins are used to combine rows from two or more tables based on related columns.

### Common Types of Joins

| Join Type      | Description                                          | Example Use Case                                      |
|----------------|------------------------------------------------------|------------------------------------------------------|
| **INNER JOIN** | Returns only matching rows between tables            | Get all bookings along with the users who made them  |
| **LEFT JOIN**  | Returns all rows from left table + matching from right | List all properties with their reviews (if any)      |
| **RIGHT JOIN** | Returns all rows from right table + matching from left | Less common, opposite of LEFT JOIN                    |
| **FULL OUTER JOIN** | Returns all rows from both tables, matched or not | List all users and bookings, even unmatched records   |

---

### INNER JOIN Example

```sql
SELECT b.booking_id, u.user_id, u.first_name
FROM Booking b
INNER JOIN User u ON b.user_id = u.user_id;
````

### LEFT JOIN Example

```sql
SELECT p.property_id, r.review_id, r.rating
FROM Property p
LEFT JOIN Review r ON p.property_id = r.property_id;
```

### Simulated FULL OUTER JOIN (MySQL)

MySQL does not support FULL OUTER JOIN directly, but you can simulate it with `UNION`:

```sql
SELECT u.user_id, b.booking_id
FROM User u
LEFT JOIN Booking b ON u.user_id = b.user_id

UNION

SELECT u.user_id, b.booking_id
FROM Booking b
RIGHT JOIN User u ON u.user_id = b.user_id;
```

---

### When to Use Joins

* Use **INNER JOIN** to get only matching records.
* Use **LEFT JOIN** to get all records from the left table, even if there are no matches.
* Use **FULL OUTER JOIN** (or simulate it) to get all records from both tables.

## SQL Aggregations and Window Functions

Aggregation functions summarize data across groups, while window functions allow ranking and running totals without collapsing rows.

### 1. Total Number of Bookings Per User

```sql
SELECT user_id, COUNT(*) AS total_bookings
FROM Booking
GROUP BY user_id;
```

* Uses `COUNT` to count bookings.
* Groups results by `user_id` to get totals per user.

---

### 2. Rank Properties by Number of Bookings Using Window Function

```sql
SELECT 
    property_id,
    COUNT(*) AS bookings_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM Booking
GROUP BY property_id;
```

* Counts total bookings per property.
* Uses `RANK()` window function to assign ranks based on booking counts (highest bookings get rank 1).
* `OVER (ORDER BY COUNT(*) DESC)` defines the ranking order.

---

### Notes

* Aggregations reduce rows using functions like `COUNT`, `SUM`, `AVG`.
* Window functions compute values across rows without grouping them away.

```



