-- ============================================
-- PRIMARY KEYS
-- ============================================

-- Central table
ALTER TABLE orders 
    MODIFY order_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (order_id);

-- Dependent tables
ALTER TABLE customers 
    MODIFY customer_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (customer_id);

ALTER TABLE products 
    MODIFY product_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (product_id);

ALTER TABLE sellers 
    MODIFY seller_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (seller_id);

ALTER TABLE order_payments 
    MODIFY order_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (order_id);

-- Composite PKs
ALTER TABLE order_reviews 
    MODIFY review_id VARCHAR(255),
    MODIFY order_id VARCHAR(255),  
    ADD PRIMARY KEY IF NOT EXISTS (review_id, order_id);

ALTER TABLE order_items 
    MODIFY order_id VARCHAR(255), 
    ADD PRIMARY KEY IF NOT EXISTS (order_id, order_item_id);


-- ============================================
-- INDICES
-- ============================================

-- orders (central hub)
CREATE INDEX idx_orders_customer_id          ON orders (customer_id);
CREATE INDEX idx_orders_status               ON orders (order_status);  -- WHERE clause in every query

-- order_payments
CREATE INDEX idx_order_payments_order_id     ON order_payments (order_id);

-- order_reviews
CREATE INDEX idx_order_reviews_order_id      ON order_reviews (order_id);

-- order_items (joins on 3 keys)
CREATE INDEX idx_order_items_order_id        ON order_items (order_id);
CREATE INDEX idx_order_items_product_id      ON order_items (product_id);
CREATE INDEX idx_order_items_seller_id       ON order_items (seller_id);

-- customers
CREATE INDEX idx_customers_zip_code          ON customers (customer_zip_code_prefix);

-- sellers
CREATE INDEX idx_sellers_zip_code            ON sellers (seller_zip_code_prefix);

-- geolocation
CREATE INDEX idx_geolocation_zip_code        ON geolocation (geolocation_zip_code_prefix);

-- products & categories (used in every category query)
CREATE INDEX idx_products_category_name      ON products (product_category_name);
CREATE INDEX idx_category_translation        ON product_category_name_translation (product_category_name);