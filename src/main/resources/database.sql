-- Initial Data for ElectroZone

INSERT INTO categories (name) VALUES ('Laptops'), ('Phones'), ('Audio'), ('gaming'), ('Wearables');

INSERT INTO brands (name) VALUES ('Asus'), ('MSI'), ('Razer'), ('Apple'), ('Dell'), ('Sony'), ('Anker'), ('Spigen'), ('Samsung');

-- Insert Statuses
INSERT IGNORE INTO status (value) VALUES ('ACTIVE'), ('PENDING'), ('INACTIVE'), ('BLOCKED'), ('DELIVERED'), ('PACKING'), ('APPROVED'), ('REJECTED'), ('CANCELED'), ('VERIFIED'), ('RECEIVED'), ('COMPLETED');

-- Admin user (password: Admin@123)
-- INSERT INTO users (full_name, email, password, role, status, created_at) VALUES ('Admin User', 'admin@electro.zone', '$2a$10$Yl2J3CRi8fCwJUKS3i0pY.8GHtWmEAIeGtR8nu2gOaTW62CVFRCCa', 'ADMIN', 'ACTIVE', NOW());
