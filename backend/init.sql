-- Drop existing tables if they exist
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- Create products table without size column
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC(19, 2) NOT NULL,
    stock INTEGER NOT NULL,
    image_url VARCHAR(255),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert initial products with correct image URLs
INSERT INTO products (name, description, price, stock, image_url, created_at) VALUES
('T-shirt 4L Trophy - Landscape', 'T-shirt premium en coton bio, édition exclusive 4L des Dômes. Design unique inspiré du désert marocain. Fabriqué à Clermont-Ferrand.', 19.99, 100, '/t-shirt/front-t-shirt-landscape.png', CURRENT_TIMESTAMP),
('T-shirt 4L Trophy - Sponsors', 'T-shirt premium en coton bio, parfait pour l''aventure. Collection 4L des Dômes avec logo brodé. Fabriqué à Clermont-Ferrand.', 19.99, 100, '/t-shirt/front-t-shirt-sponsor.png', CURRENT_TIMESTAMP);
