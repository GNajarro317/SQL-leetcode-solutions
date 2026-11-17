-- LeetCode Problem 1045: Customers Who Bought All Products
-- Source: LeetCode
-- https://leetcode.com/problems/customers-who-bought-all-products/
--
-- Goal:
-- Find the customer ids who purchased every product listed in
-- the Product table.

-- My solution:
select
    customer_id
from customer
group by customer_id
having count(distinct product_key) =  
    (select count(product_key) as cnt from product)
;