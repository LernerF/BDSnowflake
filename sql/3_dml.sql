INSERT INTO dim_category (category)
SELECT DISTINCT pet_category
FROM mock_data;

INSERT INTO dim_pet (pet_type, pet_name, pet_breed, pet_customer_email)
SELECT DISTINCT
    customer_pet_type, customer_pet_name, customer_pet_breed, customer_email
FROM mock_data;

INSERT INTO dim_customer (
    customer_first_name, customer_last_name, customer_age,
    customer_email, customer_country, customer_postal_code
)
SELECT DISTINCT
    customer_first_name, customer_last_name, customer_age,
    customer_email, customer_country, customer_postal_code
FROM mock_data;

INSERT INTO dim_product (
    product_name, product_category, product_price, product_quantity,
    product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    product_release_date, product_expiry_date
)
SELECT DISTINCT
    product_name, product_category, product_price, product_quantity,
    product_weight, product_color, product_size, product_brand,
    product_material, product_description, product_rating, product_reviews,
    TO_DATE(product_release_date, 'MM/DD/YYYY'),
    TO_DATE(product_expiry_date, 'MM/DD/YYYY')
FROM mock_data;


INSERT INTO dim_seller (
    seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code
)
SELECT DISTINCT
    seller_first_name, seller_last_name, seller_email,
    seller_country, seller_postal_code
FROM mock_data;

INSERT INTO dim_store (
    store_name, store_location, store_city, store_state,
    store_country, store_phone, store_email
)
SELECT DISTINCT
    store_name, store_location, store_city, store_state,
    store_country, store_phone, store_email
FROM mock_data;

INSERT INTO dim_supplier (
    supplier_name, supplier_contact, supplier_email,
    supplier_phone, supplier_address, supplier_city, supplier_country
)
SELECT DISTINCT
    supplier_name, supplier_contact, supplier_email,
    supplier_phone, supplier_address, supplier_city, supplier_country
FROM mock_data;

INSERT INTO fact_sale (
    sale_date, sale_quantity, sale_total_price,
    category_id, pet_id, customer_id, product_id,
    seller_id, store_id, supplier_id
)
SELECT
    TO_DATE(md.sale_date, 'MM/DD/YYYY')  AS sale_date,
    md.sale_quantity,
    md.sale_total_price,

    (SELECT id FROM dim_category
     WHERE category = md.pet_category) AS category_id,

    (SELECT id FROM dim_pet
     WHERE pet_type = md.customer_pet_type
       AND pet_name = md.customer_pet_name
       AND pet_breed = md.customer_pet_breed
       AND pet_customer_email = md.customer_email) AS pet_id,

    (SELECT id FROM dim_customer
     WHERE customer_email = md.customer_email) AS customer_id,

    (SELECT id FROM dim_product
     WHERE product_name = md.product_name
       AND product_category = md.product_category
       AND product_price = md.product_price
       AND product_quantity = md.product_quantity
       AND product_weight = md.product_weight
       AND product_color = md.product_color
       AND product_size = md.product_size
       AND product_brand = md.product_brand
       AND product_material = md.product_material
       AND product_description = md.product_description
       AND product_rating = md.product_rating
       AND product_reviews = md.product_reviews
       AND product_release_date = TO_DATE(md.product_release_date, 'MM/DD/YYYY')
       AND product_expiry_date = TO_DATE(md.product_expiry_date, 'MM/DD/YYYY')
       ) AS product_id,

    (SELECT id FROM dim_seller
     WHERE seller_email = md.seller_email) AS seller_id,

    (SELECT id FROM dim_store
     WHERE store_email = md.store_email) AS store_id,

    (SELECT id FROM dim_supplier
     WHERE supplier_email = md.supplier_email) AS supplier_id

FROM mock_data md;
