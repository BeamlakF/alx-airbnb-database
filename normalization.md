# Database Normalization to 3NF


## 1. Review of Initial Schema

The database consists of the following main entities and their attributes:

- **User** (`user_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`)  
- **Property** (`property_id`, `host_id`, `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`)  
- **Booking** (`booking_id`, `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `created_at`)  
- **Payment** (`payment_id`, `booking_id`, `amount`, `payment_date`, `payment_method`)  
- **Review** (`review_id`, `property_id`, `user_id`, `rating`, `comment`, `created_at`)  
- **Message** (`message_id`, `sender_id`, `recipient_id`, `message_body`, `sent_at`)

---

## 2. Identification of Potential Redundancies and Normalization Violations

- All tables use single-column primary keys (UUIDs), so there are **no partial dependencies** → satisfies 2NF.  
- Most attributes are atomic and directly related to their entity → satisfies 1NF.  
- Possible improvements identified for 3NF:  
  - **User `role` attribute** is an ENUM; if roles expand, this could violate 3NF (transitive dependency on role description).  
  - **Payment `payment_method`** stored as ENUM; if payment methods have additional attributes (provider details), it might violate 3NF.

---

## 3. Normalization Steps Taken

### 3.1 User Roles as a Separate Table

- Created a new table `UserRole`:
```

UserRole

* role\_name (PK)
* description

```
- Modified `User` to reference `UserRole` by `role_name` (foreign key), eliminating transitive dependency.

### 3.2 Payment Methods as a Separate Table

- Created a new table `PaymentMethod`:
```

PaymentMethod

* method\_id (PK)
* name
* provider\_info (optional)

```
- Modified `Payment` table to reference `PaymentMethod` by `method_id`, enabling extension without modifying the `Payment` table.



---

## 4. Result

- The database schema is now in **Third Normal Form (3NF)**:


