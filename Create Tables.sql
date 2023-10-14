



CREATE TABLE SITE_USER(
user_id VARCHAR(100) PRIMARY KEY NOT NULL,
user_email VARCHAR(100),
user_phonenum NUMERIC(10),
user_pwd VARCHAR(100),
user_last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP);




CREATE TABLE STATES(
state_id NUMERIC(4) PRIMARY KEY NOT NULL,
state_name VARCHAR(50) NOT NULL);





CREATE TABLE CITIES(
city_id NUMERIC(4) PRIMARY KEY NOT NULL,
city_name VARCHAR(50) NOT NULL,
state_id NUMERIC(4) NOT NULL,
FOREIGN KEY(state_id) REFERENCES STATES(state_id));





CREATE TABLE ADDRESS(
address_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
unit_no VARCHAR(1000),
street_name VARCHAR(100),
landmark VARCHAR(100),
area VARCHAR(100),
city_id NUMERIC(4) NOT NULL,
state_id NUMERIC(4) NOT NULL,
FOREIGN KEY(city_id) REFERENCES cities(city_id),
FOREIGN KEY(state_id) REFERENCES states(state_id));



CREATE TABLE SITE_USER_ADDRESS(
address_id INT NOT NULL,
user_id VARCHAR(100) NOT NULL,
default_address INT,
PRIMARY KEY (address_id,user_id),
FOREIGN KEY(address_id) REFERENCES ADDRESS(address_id),
FOREIGN KEY(user_id) REFERENCES SITE_USER(user_id));



CREATE TABLE USER_PAYMENT(
transaction_id VARCHAR(100) PRIMARY KEY);



CREATE TABLE CREDIT_CARD(
credit_card_num NUMERIC(16) PRIMARY KEY NOT NULL,
transaction_id VARCHAR(100) NOT NULL,
credit_card_cvv NUMERIC(3),
credit_card_holder_name VARCHAR(100),
FOREIGN KEY(transaction_id) REFERENCES USER_PAYMENT(transaction_id));


CREATE TABLE DEBIT_CARD(
debit_card_num NUMERIC(16) PRIMARY KEY NOT NULL,
transaction_id VARCHAR(100) NOT NULL,
debit_card_cvv NUMERIC(3),
debit_card_holder_name VARCHAR(100),
debit_card_exp_date DATE,
FOREIGN KEY(transaction_id) REFERENCES USER_PAYMENT(transaction_id));







CREATE TABLE SHOPPING_CART(
shopping_cart_id VARCHAR(100) PRIMARY KEY,
user_id VARCHAR(100) NOT NULL,
FOREIGN KEY(user_id) REFERENCES SITE_USER(user_id));




CREATE TABLE SHOPPING_CART_ITEM(
shopping_cart_item_id VARCHAR(100) PRIMARY KEY,
shopping_cart_item_quantity NUMERIC(5) NOT NULL,
shopping_cart_id VARCHAR(100),
FOREIGN KEY(shopping_cart_id) REFERENCES SHOPPING_CART(shopping_cart_id));









CREATE TABLE SHOP_ORDER(
shop_order_id VARCHAR(100) PRIMARY KEY,
user_id VARCHAR(100) NOT NULL,
shop_order_DATE_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
transaction_id VARCHAR(100),
address_id INT NOT NULL,
order_total NUMERIC(10) NOT NULL,
order_status NUMERIC(1),
FOREIGN KEY(user_id) REFERENCES SITE_USER(user_id),
FOREIGN KEY(transaction_id) REFERENCES USER_PAYMENT(transaction_id),
FOREIGN KEY(address_id) REFERENCES ADDRESS(address_id));









CREATE TABLE USER_REVIEWS(
user_review_id VARCHAR(100) PRIMARY KEY,
user_id VARCHAR(100),
rating_value NUMERIC(2,1),
rating_comment VARCHAR(10000),
FOREIGN KEY(user_id) REFERENCES SITE_USER(user_id));











CREATE TABLE PRODUCT_CATEGORY(
product_category_id VARCHAR(100) PRIMARY KEY,
product_category_name VARCHAR(100));





CREATE TABLE PRODUCT_SUBCATEGORY(
product_subcategory_id VARCHAR(100) PRIMARY KEY,
product_category_id VARCHAR(100),
product_subcategory_name VARCHAR(100),
FOREIGN KEY(product_category_id) REFERENCES PRODUCT_CATEGORY(product_category_id));






CREATE TABLE PRODUCT(
product_id VARCHAR(100) PRIMARY KEY,
product_name VARCHAR(100),
product_category_id VARCHAR(100),
product_subcategory_id VARCHAR(100),
FOREIGN KEY(product_category_id) REFERENCES PRODUCT_CATEGORY(product_category_id),
FOREIGN KEY(product_subcategory_id) REFERENCES PRODUCT_SUBCATEGORY(product_subcategory_id));






CREATE TABLE PRODUCT_ITEM(
product_item_id VARCHAR(100)  PRIMARY KEY,
product_item_name VARCHAR(100),
product_item_quantity_in_stock NUMERIC(5),
product_item_original_price NUMERIC(7),
product_item_discount_rate NUMERIC(3),
company_name VARCHAR(100),
product_id VARCHAR(100),
FOREIGN KEY(product_id) REFERENCES PRODUCT(product_id));






CREATE TABLE PRODUCT_ITEM_SPECIFICATIONS(
product_item_specification_id VARCHAR(100) UNIQUE NOT NULL,
product_item_id VARCHAR(100),
materials VARCHAR(100),
colour VARCHAR(100),
size VARCHAR(100),
details VARCHAR(10000),
PRIMARY KEY (product_item_specification_id,product_item_id),
FOREIGN KEY(product_item_id) REFERENCES PRODUCT_ITEM(product_item_id));







CREATE TABLE ORDERED_ITEM(
ordered_item_id VARCHAR(100) PRIMARY KEY,
ordered_item_qty NUMERIC(5),
price_of_product_item NUMERIC(7),
product_item_id VARCHAR(100),
user_review_id VARCHAR(100) NOT NULL,
FOREIGN KEY(product_item_id) REFERENCES PRODUCT_ITEM(product_item_id),
FOREIGN KEY(user_review_id) REFERENCES USER_REVIEWS(user_review_id));




CREATE TABLE SHOP_ORDER_ORDERED_ITEM(
shop_order_id VARCHAR(100) NOT NULL,
ordered_item_id VARCHAR(100) NOT NULL,
PRIMARY KEY(shop_order_id,ordered_item_id),
FOREIGN KEY(shop_order_id) REFERENCES SHOP_ORDER(shop_order_id),
FOREIGN KEY(ordered_item_id) REFERENCES ORDERED_ITEM(ordered_item_id));



-- ****************************************************************************************************************************


SHOW TABLES;



