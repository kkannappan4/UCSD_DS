-- Sales Cube
-- Create Schema

CREATE TABLE customers (
 ID SERIAL PRIMARY KEY,
 first_name TEXT NOT NULL,
 last_name TEXT NOT NULL,
 state_id INTEGER REFERENCES states (ID) NOT NULL
);

CREATE TABLE states (
 ID SERIAL PRIMARY KEY,
 state_name TEXT NOT NULL
);

CREATE TABLE products (
 ID SERIAL PRIMARY KEY,
 product_name TEXT NOT NULL,
 price DECIMAL NOT NULL,
 category_id INTEGER REFERENCES categories (ID) NOT NULL
);

CREATE TABLE categories (
 ID SERIAL PRIMARY KEY,
 category_name TEXT NOT NULL,
 category_desc TEXT
 );

CREATE TABLE sales (
 ID BIGSERIAL PRIMARY KEY,
 product_id INTEGER REFERENCES products (ID) NOT NULL,
 customer_id INTEGER REFERENCES customers (ID) NOT NULL,
 quantity INTEGER NOT NULL,
 unit_price DECIMAL NOT NULL
 );