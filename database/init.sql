CREATE DATABASE IF NOT EXISTS sauce;
USE sauce;

CREATE TABLE IF NOT EXISTS products (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    stock_quantity INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS roles (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) UNIQUE NOT NULL,  
    description TEXT   
);

INSERT INTO roles (name, description) VALUES
('admin', 'Administrator role with full permissions'),
('customer', 'Customer role with limited permissions');

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    username VARCHAR(100) NOT NULL,    
    address TEXT,                    
    contact_number VARCHAR(20),         
    role_id INT DEFAULT 2,                      
    email VARCHAR(100) UNIQUE NOT NULL, 
    password_hash VARCHAR(255) NOT NULL,   
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    CONSTRAINT unique_user_product UNIQUE (user_id, product_id)
);

-- Seeds for easier testing (why did we not do this earlier)
-- Seed products
INSERT INTO products (id, name, category, stock_quantity, price, image, description)
VALUES
('P001', 'The Ballad of Q', 'Condiment', 50, 300.00, 'ballad.jpg', 'A mysterious sauce with a bold, rich flavor.'),
('P002', 'Big Bald Bob', 'Condiment', 50, 400.00, 'bigbald.jpg', 'Intense and strong, just like Bob himself.'),
('P003', 'Call Me Debra', 'Condiment', 50, 300.00, 'callme.jpg', 'Sweet with a surprising kick.'),
('P004', 'Carbon', 'Condiment', 50, 400.00, 'carbon.jpg', 'Smoky and dark — for those who like it bold.'),
('P005', 'Catch 22', 'Condiment', 50, 300.00, 'catch.jpg', 'A twisty blend that keeps you coming back.');

-- Seed users
INSERT INTO users (username, address, contact_number, role_id, email, password_hash)
VALUES
('walter_white', '308 Negra Arroyo Lane, Albuquerque', '5051234567', 1, 'heisenberg@bb.com', '$2b$10$HeisenbergHashPlaceholder'),
('jesse_pinkman', '9809 Margo Street, Albuquerque', '5057654321', 2, 'yo@bb.com', '$2b$10$JesseHashPlaceholder'),
('saul_goodman', '1000 Legal Ave, Albuquerque', '5050000000', 2, 'bettercall@saul.com', '$2b$10$SaulHashPlaceholder'),
('skyler_white', '308 Negra Arroyo Lane, Albuquerque', '5059999999', 2, 'skyler@bb.com', '$2b$10$SkylerHashPlaceholder'),
('gus_fring', 'Los Pollos Hermanos HQ, Albuquerque', '5051112222', 1, 'gus@pollos.com', '$2b$10$GusHashPlaceholder');

-- Seed cart
INSERT INTO cart (user_id, product_id, quantity) VALUES
(2, 'P001', 2),  
(3, 'P002', 1),  
(4, 'P005', 3);  