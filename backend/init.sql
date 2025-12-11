-- Drop existing tables if they exist
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS colors CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- Create products table
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(19, 2) NOT NULL,
    stock INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create colors table
CREATE TABLE colors (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    label VARCHAR(50) NOT NULL,
    hex VARCHAR(7) NOT NULL,
    front_image VARCHAR(255) NOT NULL,
    back_image VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Create orders table
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL,
    customer_phone VARCHAR(255) NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    total_amount NUMERIC(19, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create order_items table
CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    price_at_purchase NUMERIC(19, 2) NOT NULL,
    size VARCHAR(10),
    color VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert initial products
INSERT INTO products (name, description, price, stock, created_at) VALUES
('T-shirt 4L des Dômes', 'T-shirt en coton bio avec notre design exclusif. Confortable et résistant, parfait pour soutenir notre aventure !', 20, 100, CURRENT_TIMESTAMP),
('Pull 4L des Dômes', 'Pull confortable avec notre design exclusif. Idéal pour les soirées fraîches et pour afficher votre soutien !', 35.00, 100, CURRENT_TIMESTAMP);

-- Insert colors for T-shirt (product_id = 1)
INSERT INTO colors (product_id, name, label, hex, front_image, back_image) VALUES
(1, 'White', 'Blanc', '#FFFFFF', '/clothes/front-white-t-shirt.png', '/clothes/back-white-t-shirt.png'),
(1, 'Black', 'Noir', '#000000', '/clothes/front-black-t-shirt.png', '/clothes/back-black-t-shirt.png');

-- Insert colors for Pull (product_id = 2)
INSERT INTO colors (product_id, name, label, hex, front_image, back_image) VALUES
(2, 'Beige', 'Beige', '#D4C5B9', '/clothes/front-beige-pull.png', '/clothes/back-beige-pull.png'),
(2, 'Blue', 'Bleu', '#4A90E2', '/clothes/front-blue-pull.png', '/clothes/back-blue-pull.png');

