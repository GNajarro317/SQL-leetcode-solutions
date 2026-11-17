-- LeetCode Problem 1164: Product Price at a Given Date
-- Source: LeetCode
-- https://leetcode.com/problems/product-price-at-a-given-date/
--
-- Goal:
-- Find the price of every product as of 2019-08-16, given that
-- all products start at price 10 and change over time.

-- My solution:
select
    p1.product_id,
    coalesce(
        (
        select
            p2.new_price
        from products as p2
        where 
            p2.product_id = p1.product_id
            and p2.change_date <= '2019-8-16'
        order by p2.change_date desc
        limit 1
        ), 10 ) as price
from products as p1
group by p1.product_id
;