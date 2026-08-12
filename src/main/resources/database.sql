-- Initial Data for ElectroZone

INSERT INTO categories (name) VALUES ('Laptops & Notebooks'), ('Desktop Computers'), ('Components'), ('Wearables'), ('Audio'), ('Tablets'), ('Smartphones');

INSERT INTO brands (name) VALUES ('Asus'), ('MSI'), ('Razer'), ('Apple'), ('Dell'), ('Sony'), ('Anker'), ('Spigen'), ('Samsung');

-- Insert Statuses
INSERT IGNORE INTO status (value) VALUES ('ACTIVE'), ('PENDING'), ('INACTIVE'), ('BLOCKED'), ('DELIVERED'), ('PACKING'), ('APPROVED'), ('REJECTED'), ('CANCELED'), ('VERIFIED'), ('RECEIVED'), ('COMPLETED');

-- Admin user (password: Admin123)
-- INSERT INTO users (full_name, email, password, role, status, created_at) VALUES ('Admin User', 'admin@electro.zone', '$2a$10$Wq38zI01b0c034Rz610XEuI2qWj0vK0Y93yXyT0ZgQ28o/g7aT28.', 'ADMIN', 'ACTIVE', NOW());
