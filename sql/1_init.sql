DROP TABLE IF EXISTS mock_data;

CREATE TABLE mock_data (
    id INTEGER,
    customer_first_name VARCHAR,
    customer_last_name VARCHAR,
    customer_age INTEGER,
    customer_email VARCHAR,
    customer_country VARCHAR,
    customer_postal_code VARCHAR,
    customer_pet_type VARCHAR,
    customer_pet_name VARCHAR,
    customer_pet_breed VARCHAR,
    seller_first_name VARCHAR,
    seller_last_name VARCHAR,
    seller_email VARCHAR,
    seller_country VARCHAR,
    seller_postal_code VARCHAR,
    product_name VARCHAR,
    product_category VARCHAR,
    product_price NUMERIC(10,2),
    product_quantity INTEGER,
    sale_date VARCHAR,
    sale_customer_id INTEGER,
    sale_seller_id INTEGER,
    sale_product_id INTEGER,
    sale_quantity INTEGER,
    sale_total_price NUMERIC(12,2),
    store_name VARCHAR,
    store_location VARCHAR,
    store_city VARCHAR,
    store_state VARCHAR,
    store_country VARCHAR,
    store_phone VARCHAR,
    store_email VARCHAR,
    pet_category VARCHAR,
    product_weight NUMERIC,
    product_color VARCHAR,
    product_size VARCHAR,
    product_brand VARCHAR,
    product_material VARCHAR,
    product_description TEXT,
    product_rating NUMERIC(3,2),
    product_reviews INTEGER,
    product_release_date VARCHAR,
    product_expiry_date VARCHAR,
    supplier_name VARCHAR,
    supplier_contact VARCHAR,
    supplier_email VARCHAR,
    supplier_phone VARCHAR,
    supplier_address TEXT,
    supplier_city VARCHAR,
    supplier_country VARCHAR
);

CREATE OR REPLACE PROCEDURE load_mock_data(p_path text)
LANGUAGE plpgsql
AS $proc$
BEGIN
    EXECUTE format(
        $sql$
        COPY mock_data (
            id, customer_first_name, customer_last_name, customer_age,
            customer_email, customer_country, customer_postal_code,
            customer_pet_type, customer_pet_name, customer_pet_breed,
            seller_first_name, seller_last_name, seller_email,
            seller_country, seller_postal_code,
            product_name, product_category, product_price, product_quantity,
            sale_date, sale_customer_id, sale_seller_id, sale_product_id,
            sale_quantity, sale_total_price,
            store_name, store_location, store_city, store_state, store_country,
            store_phone, store_email,
            pet_category,
            product_weight, product_color, product_size, product_brand,
            product_material, product_description, product_rating, product_reviews,
            product_release_date, product_expiry_date,
            supplier_name, supplier_contact, supplier_email, supplier_phone,
            supplier_address, supplier_city, supplier_country
        )
        FROM %L
        DELIMITER ','
        CSV HEADER
        NULL AS ''
        $sql$,
        p_path
    );
END;
$proc$;

CALL load_mock_data('/mock_data/MOCK_DATA.csv');
CALL load_mock_data('/mock_data/MOCK_DATA (1).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (2).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (3).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (4).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (5).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (6).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (7).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (8).csv');
CALL load_mock_data('/mock_data/MOCK_DATA (9).csv');