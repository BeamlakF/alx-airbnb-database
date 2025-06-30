-- User Roles table to normalize roles (3NF)
CREATE TABLE UserRole (
    role_name ENUM('guest', 'host', 'admin') PRIMARY KEY,
    description VARCHAR(255) NULL
);

-- Users table
CREATE TABLE User (
    user_id CHAR(20) PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role_name ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_role FOREIGN KEY (role_name) REFERENCES UserRole(role_name)
);

CREATE INDEX idx_user_email ON User(email);

-- Properties table
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_host FOREIGN KEY (host_id) REFERENCES User(user_id)
);

CREATE INDEX idx_property_host ON Property(host_id);

-- Bookings table
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_booking_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES User(user_id)
);

CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_booking_user ON Booking(user_id);

-- Payment Methods table to normalize payment_method ENUM (optional but normalized)
CREATE TABLE PaymentMethod (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name ENUM('credit_card', 'paypal', 'stripe') NOT NULL UNIQUE
);

-- Payments table
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id INT NOT NULL,
    CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT fk_payment_method FOREIGN KEY (method_id) REFERENCES PaymentMethod(method_id)
);

CREATE INDEX idx_payment_booking ON Payment(booking_id);

-- Reviews table
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_review_property FOREIGN KEY (property_id) REFERENCES Property(property_id),
    CONSTRAINT fk_review_user FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Messages table
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_message_sender FOREIGN KEY (sender_id) REFERENCES User(user_id),
    CONSTRAINT fk_message_recipient FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);

-- Insert initial roles into UserRole
INSERT INTO UserRole (role_name, description) VALUES
('guest', 'Guest user who can book properties'),
('host', 'User who owns and lists properties'),
('admin', 'Administrator with full access');

-- Insert initial payment methods
INSERT INTO PaymentMethod (method_name) VALUES
('credit_card'), ('paypal'), ('stripe');
