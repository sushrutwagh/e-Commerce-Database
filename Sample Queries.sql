-- 1.	Print all the addresses of the user with transaction_id =’11’

SELECT ADDRESS.address_id, state_id, city_id, unit_no, street_name, landmark, area  
FROM ADDRESS, SHOP_ORDER, SITE_USER_ADDRESS
WHERE SHOP_ORDER.transaction_id='11' and SHOP_ORDER.user_id= SITE_USER_ADDRESS.user_id and SITE_USER_ADDRESS.address_id=ADDRESS.address_id;

-- 2.	Give the email and the order time & date of all the users who have ordered a ‘polypon free sweater’.

SELECT user_email, shop_order_DATE_TIME 
FROM PRODUCT_ITEM, ORDERED_ITEM, SHOP_ORDER_ORDERED_ITEM, SHOP_ORDER, SITE_USER
WHERE product_item_name='polypon free sweater' and PRODUCT_ITEM.product_item_id=ORDERED_ITEM.product_item_id and ORDERED_ITEM.ordered_item_id=SHOP_ORDER_ORDERED_ITEM.ordered_item_id and SHOP_ORDER_ORDERED_ITEM.shop_order_id=SHOP_ORDER.shop_order_id and SHOP_ORDER.user_id=SITE_USER.user_id;

-- 3.	  Print the user ids of all the users who have ordered multiple types of items at one time(i.e in 1 shop order) and also print the count of those multiple ordered item types.

SELECT DISTINCT SHOP_ORDER.user_id,count(SHOP_ORDER_ORDERED_ITEM.ordered_item_id)
FROM SHOP_ORDER, SHOP_ORDER_ORDERED_ITEM
WHERE SHOP_ORDER.shop_order_id=SHOP_ORDER_ORDERED_ITEM.shop_order_id
GROUP BY SHOP_ORDER_ORDERED_ITEM.shop_order_id
HAVING count(SHOP_ORDER_ORDERED_ITEM.ordered_item_id)>1;

-- 4.	Print the state names along with the count of the number of cities in each of those states. (name the column with the count as ‘city_count’)

SELECT state_name,count(CITIES.city_id) as city_count
FROM STATES, CITIES
WHERE STATES.state_id=CITIES.state_id
GROUP BY CITIES.state_id;

-- 5.	Print the product name and their company name whose user_rating is above 4.0 

SELECT product_item_name,company_name
FROM PRODUCT_ITEM, USER_REVIEWS, ORDERED_ITEM
WHERE USER_REVIEWS.user_review_id=ORDERED_ITEM.user_review_id and PRODUCT_ITEM.product_item_id=ORDERED_ITEM.product_item_id and USER_REVIEWS.rating_value>4.0;

-- 6.	Display the product_item_name, product_name,_product_subcategory_name,product_category_name, material and colour of all the product items whose colours are shades of brown (having ‘Brown’ as a substring)

SELECT product_item_name, product_name, product_subcategory_name,product_category_name, materials, colour
FROM PRODUCT_CATEGORY, PRODUCT_SUBCATEGORY, PRODUCT, PRODUCT_ITEM, PRODUCT_ITEM_SPECIFICATIONS
WHERE colour like '%Brown%' and PRODUCT_ITEM.product_id=PRODUCT.product_id and PRODUCT.product_subcategory_id=PRODUCT_SUBCATEGORY.product_subcategory_id and PRODUCT_SUBCATEGORY.product_category_id=PRODUCT_CATEGORY.product_category_id and PRODUCT_ITEM_SPECIFICATIONS.product_item_id=PRODUCT_ITEM.product_item_id

-- 7.	Display the user_ids and the user_last_login of all the users (irrespective of whether they’ve ordered anything or not) except for those whose orders have not yet been delivered (i.e. order_status = 0)

SELECT SITE_USER.user_id, user_last_login
FROM SITE_USER, SHOP_ORDER
EXCEPT 
(SELECT SITE_USER.user_id, user_last_login
FROM SITE_USER, SHOP_ORDER
WHERE SITE_USER.user_id=SHOP_ORDER.user_id and SHOP_ORDER.order_status=0);

-- 8.	Display the product item name, product original price, product item discount rate and the product item discounted price as ‘product_item_discount_price’ of all the product items.

SELECT product_item_name, product_item_original_price, product_item_discount_rate, product_item_original_price-(product_item_discount_rate*product_item_original_price/100) as product_item_discount_price
FROM PRODUCT_ITEM;

-- 9.	Display all details of distinct users whose order total is more than 15000 (using joins).

SELECT DISTINCT user_id, user_email, user_phonenum, user_pwd, user_last_login
FROM SITE_USER NATURAL JOIN SHOP_ORDER
WHERE SHOP_ORDER.order_total>15000;

-- 10.	Display the product item_ids of all the product items that have not yet been ordered (all the product items except for those that have already been ordered)

SELECT product_item_id
FROM PRODUCT_ITEM
WHERE product_item_id not in 
(SELECT product_item_id
FROM ORDERED_ITEM);

-- 11.	Display the count of user ids whose user review value = 4.0 (using left outer join)

SELECT count(USER_REVIEWS.user_id)
FROM SITE_USER left outer join USER_REVIEWS
ON USER_REVIEWS.rating_value = 4.0 and SITE_USER.user_id=USER_REVIEWS.user_id; 

-- 12.	Display the user_id and the total of all of their shop orders

SELECT SHOP_ORDER.user_id,SUM(order_total)
FROM SHOP_ORDER, SITE_USER
WHERE SHOP_ORDER.user_id=SITE_USER.user_id
GROUP BY SHOP_ORDER.user_id;

-- 13.	Display all the products in from ‘Mens’ Category

SELECT product_id, product_name
FROM PRODUCT, PRODUCT_CATEGORY,PRODUCT_SUBCATEGORY
WHERE  PRODUCT_CATEGORY.product_category_name='Mens' and PRODUCT_CATEGORY.product_category_id=PRODUCT_SUBCATEGORY.product_category_id and PRODUCT.product_subcategory_id=PRODUCT_SUBCATEGORY.product_subcategory_id;

-- 14.	Display the names of all the Product items made of ’Cotton’

SELECT product_item_name
FROM PRODUCT_ITEM, PRODUCT_ITEM_SPECIFICATIONS
WHERE PRODUCT_ITEM_SPECIFICATIONS.materials='Cotton' and PRODUCT_ITEM_SPECIFICATIONS.product_item_id=PRODUCT_ITEM.product_item_id;

-- 15.	Display the product_id and the maximum cost price corresponding to it.

SELECT product_id,MAX(product_item_original_price)
FROM PRODUCT_ITEM
GROUP BY product_id;







