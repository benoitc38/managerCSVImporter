--
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat Jan 28 16:41:00 2023
--

BEGIN TRANSACTION;

--
-- Table: customers
--
DROP TABLE customers;

CREATE TABLE customers (
  id INTEGER PRIMARY KEY NOT NULL,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL
);

CREATE UNIQUE INDEX first_last_name_unique ON customers (first_name, last_name);

--
-- Table: orders
--
DROP TABLE orders;

CREATE TABLE orders (
  id INTEGER PRIMARY KEY NOT NULL,
  number text NOT NULL,
  date text NOT NULL,
  customer_id integer NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE INDEX orders_idx_customer_id ON orders (customer_id);

CREATE UNIQUE INDEX number_unique ON orders (number);

--
-- Table: items
--
DROP TABLE items;

CREATE TABLE items (
  id INTEGER PRIMARY KEY NOT NULL,
  name text NOT NULL,
  manufacturer text NOT NULL,
  price integer NOT NULL,
  order_id integer NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE INDEX items_idx_order_id ON items (order_id);

CREATE UNIQUE INDEX number_unique02 ON items (order_id, name, manufacturer, price);

COMMIT;
