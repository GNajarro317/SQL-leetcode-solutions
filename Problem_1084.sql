-- LeetCode Problem 1084: Sales Analysis III
-- Source: LeetCode
-- https://leetcode.com/problems/sales-analysis-iii/
--
-- Goal:
-- Find the products that were sold only during the first quarter
-- of 2019.

-- My solution:
select
    p.product_id,
    p.product_name
from product as p
    left join sales as s
        on p.product_id = s.product_id
group by 1, 2
having 
    min(sale_date) >= '2019-01-01'
    and max(sale_date) <= '2019-03-31'
;