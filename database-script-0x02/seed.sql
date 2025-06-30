-- Sample data for UserRole
INSERT INTO UserRole (role_name, description) VALUES
('guest', 'Guest user who can book properties'),
('host', 'User who owns and lists properties'),
('admin', 'Administrator with full access');

-- Sample data for PaymentMethod
INSERT INTO PaymentMethod (method_name) VALUES
('credit_card'),
('paypal'),
('stripe');

-- Sample data for Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role_name, created_at) VALUES
('11111111-1111-1111-1111', 'Alice', 'Johnson', 'alice@example.com', 'hashed_pwd_1', '123-456-7890', 'host', NOW()),
('22222222-2222-2222-2222', 'Bob', 'Smith', 'bob@example.com', 'hashed_pwd_2', '234-567-8901', 'guest', NOW()),
('33333333-3333-3333-3333', 'Carol', 'Williams', 'carol@example.com', 'hashed_pwd_3', NULL, 'admin', NOW());

-- Sample data for Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('aaaaaaa1-aaaa-aaaa-aaaa', '11111111-1111-1111-1111', 'Cozy Cabin', 'A small cozy cabin in the woods', 'Aspen, CO', 120.00, NOW(), NOW()),
('aaaaaaa2-aaaa-aaaa-aaaa', '11111111-1111-1111-1111', 'Downtown Loft', 'Modern loft in city center', 'New York, NY', 250.00, NOW(), NOW());

-- Sample data for Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('bbbbbbb1-bbbb-bbbb-bbbb', 'aaaaaaa1-aaaa-aaaa-aaaa', '22222222-2222-2222-2222', '2025-07-01', '2025-07-07', 840.00, 'confirmed', NOW()),
('bbbbbbb2-bbbb-bbbb-bbbb', 'aaaaaaa2-aaaa-aaaa-aaaa', '22222222-2222-2222-2222', '2025-08-15', '2025-08-20', 1250.00, 'pending', NOW());

-- Sample data for Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, method_id) VALUES
('ccccc1cc-cccc-cccc-cccc', 'bbbbbbb1-bbbb-bbbb-bbbb', 840.00, NOW(), 1), -- credit_card
('ccccc2cc-cccc-cccc-cccc', 'bbbbbbb2-bbbb-bbbb-bbbb', 0.00, NOW(), 2); -- paypal (pending payment)

-- Sample data for Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('ddddddd1-dddd-dddd-dddd', 'aaaaaaa1-aaaa-aaaa-aaaa', '22222222-2222-2222-2222', 5, 'Amazing stay, very cozy and quiet.', NOW()),
('ddddddd2-dddd-dddd-dddd', 'aaaaaaa2-aaaa-aaaa-aaaa', '22222222-2222-2222-2222', 4, 'Great location but a bit noisy.', NOW());

-- Sample data for Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('eeeeeee1-eeee-eeee-eeee', '22222222-2222-2222-2222', '11111111-1111-1111-1111', 'Hi! Is the cabin available next month?', NOW()),
('eeeeeee2-eeee-eeee-eeee', '11111111-1111-1111-1111', '22222222-2222-2222-2222', 'Yes, it is available. Let me know your dates.', NOW());
